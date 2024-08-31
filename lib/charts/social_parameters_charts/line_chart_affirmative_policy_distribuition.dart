import 'package:bi_ufcg/resource/app_colors.dart';
import 'package:bi_ufcg/service/data/data.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LineChartAffirmativePolicyEvolution extends StatefulWidget {
  const LineChartAffirmativePolicyEvolution({super.key});

  @override
  _LineChartAffirmativePolicyEvolutionState createState() =>
      _LineChartAffirmativePolicyEvolutionState();
}

class _LineChartAffirmativePolicyEvolutionState
    extends State<LineChartAffirmativePolicyEvolution> {
  bool isCurved = true; // Estado para determinar se o gráfico é curvado

  @override
  Widget build(BuildContext context) {
    final data = Provider.of<Data>(context);

    if (data.affirmativePolicyDistribution.isEmpty) {
      return _buildNoDataWidget();
    }

    final periods = data.affirmativePolicyDistribution.keys.toList()
      ..sort((a, b) => double.parse(a).compareTo(double.parse(b)));

    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Card(
        color: AppColors.purpleLight,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        elevation: 3,
        child: AspectRatio(
          aspectRatio: 0.8,
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                // Texto acima do gráfico
                Text(
                  'Evolução das Políticas Afirmativas',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: 10), // Espaço entre o texto e o gráfico
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Espaço para o ícone no canto superior direito
                    const SizedBox(),
                    IconButton(
                      icon: Icon(
                        isCurved
                            ? Icons.show_chart // Gráfico curvado
                            : Icons.straighten, // Gráfico reto
                        color: Colors.white,
                      ),
                      onPressed: () {
                        setState(() {
                          isCurved = !isCurved; // Alternar estado
                        });
                      },
                    ),
                  ],
                ),
                Expanded(
                  child: LineChart(
                    _buildLineChartData(data, periods),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildNoDataWidget() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: const [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 10,
            offset: Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(
            Icons.data_usage_outlined,
            size: 100,
            color: Colors.grey.shade300,
          ),
          const SizedBox(height: 20),
          Text(
            'Nenhum dado disponível',
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: Colors.grey.shade700,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            'Por favor, adicione pelo menos 1 curso e 1 período para visualizar os dados.',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey.shade500,
            ),
          ),
        ],
      ),
    );
  }

  LineChartData _buildLineChartData(Data data, List<String> periods) {
    return LineChartData(
      gridData: FlGridData(
        show: true,
        horizontalInterval: 1,
        verticalInterval: 10,
        getDrawingHorizontalLine: (value) => FlLine(
          color: Colors.grey.withOpacity(0.2),
          strokeWidth: 1,
        ),
        getDrawingVerticalLine: (value) => FlLine(
          color: Colors.grey.withOpacity(0.2),
          strokeWidth: 1,
        ),
      ),
      titlesData: FlTitlesData(
        bottomTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            reservedSize: 38,
            getTitlesWidget: (value, meta) {
              final index = value.toInt();
              if (index < periods.length) {
                return SideTitleWidget(
                  axisSide: meta.axisSide,
                  child: Text(
                    periods[index],
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                );
              }
              return const SizedBox.shrink();
            },
          ),
        ),
        leftTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            reservedSize: 40,
            getTitlesWidget: (value, meta) {
              return Text(
                value.toInt().toString(),
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              );
            },
          ),
        ),
        topTitles: AxisTitles(),
        rightTitles: AxisTitles(),
      ),
      borderData: FlBorderData(
        show: true,
        border: Border.all(
          color: Colors.grey.withOpacity(0.5),
          width: 1,
        ),
      ),
      lineBarsData: _generateLineBars(data, periods, isCurved),
      lineTouchData: LineTouchData(
        touchTooltipData: LineTouchTooltipData(
          tooltipBgColor: Colors.white,
          getTooltipItems: (touchedBarSpots) {
            return touchedBarSpots.map((spot) {
              final periodIndex = spot.x.toInt();
              final period = periods[periodIndex];
              final policy = data.affirmativePolicyDistribution[period]!.entries
                  .firstWhere(
                    (entry) =>
                        entry.value.toDouble() == spot.y &&
                        _getColorForPolicy(entry.key) == spot.bar.color,
                    orElse: () => MapEntry('Unknown', 0),
                  )
                  .key;

              final color = _getColorForPolicy(policy);

              return LineTooltipItem(
                '$policy:\n ${spot.y.toInt()}',
                TextStyle(
                  color: color,
                  fontWeight: FontWeight.bold,
                ),
              );
            }).toList();
          },
        ),
      ),
    );
  }

  List<LineChartBarData> _generateLineBars(
      Data data, List<String> periods, bool isCurved) {
    final policyData = <String, List<FlSpot>>{};

    for (var i = 0; i < periods.length; i++) {
      final period = periods[i];
      final policyMap = data.affirmativePolicyDistribution[period]!;

      policyMap.forEach((policy, count) {
        final existingSpots = policyData.putIfAbsent(policy, () => []);
        if (!existingSpots.any(
            (spot) => spot.x == i.toDouble() && spot.y == count.toDouble())) {
          existingSpots.add(FlSpot(i.toDouble(), count.toDouble()));
        }
      });
    }

    return policyData.entries.map((entry) {
      return LineChartBarData(
        spots: entry.value,
        isCurved: isCurved, // Utiliza a propriedade isCurved
        color: _getColorForPolicy(entry.key),
        barWidth: 4,
        isStrokeCapRound: true,
        belowBarData: BarAreaData(show: false),
      );
    }).toList();
  }

  Color _getColorForPolicy(String policy) {
    return Colors.primaries[(policy.hashCode + 100) % Colors.primaries.length];
  }
}
