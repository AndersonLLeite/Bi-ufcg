import 'package:bi_ufcg/resource/app_colors.dart';
import 'package:bi_ufcg/service/data/data.dart';
import 'package:bi_ufcg/widgets/widget_no_data.dart';
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
  bool isCurved = true;

  @override
  Widget build(BuildContext context) {
    final data = Provider.of<Data>(context);

    if (data.affirmativePolicyDistribution.isEmpty) {
      return const WidgetNoData();
    }

    final periods = data.affirmativePolicyDistribution.keys.toList()
      ..sort((a, b) => double.parse(a).compareTo(double.parse(b)));

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Column(
        children: [
          Column(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Card(
                      color: AppColors.purpleLight,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      elevation: 3,
                      child: AspectRatio(
                        aspectRatio: 1.1,
                        child: Padding(
                          padding: const EdgeInsets.all(16),
                          child: Column(
                            children: [
                              const SizedBox(height: 10),
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
                  ),
                  Column(
                    children: [
                      IconButton(
                        icon: Icon(
                          Icons.show_chart,
                          color: isCurved ? Colors.blue : Colors.white,
                        ),
                        onPressed: () {
                          setState(() {
                            isCurved = true;
                          });
                        },
                      ),
                      IconButton(
                        icon: Icon(
                          Icons.straighten,
                          color: isCurved ? Colors.white : Colors.blue,
                        ),
                        onPressed: () {
                          setState(() {
                            isCurved = false;
                          });
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
          _buildLegend(data),
        ],
      ),
    );
  }

  Widget _buildLegend(Data data) {
    final policies = data.affirmativePolicyDistribution.values
        .expand((map) => map.keys)
        .toSet()
        .toList();

    return Wrap(
      alignment: WrapAlignment.center,
      spacing: 10,
      runSpacing: 10,
      children: policies.map((policy) {
        final color = _getColorForPolicy(policy);
        return Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 12,
              height: 12,
              decoration: BoxDecoration(
                color: color,
                shape: BoxShape.circle,
              ),
            ),
            const SizedBox(width: 5),
            Text(
              policy,
              style: const TextStyle(
                fontSize: 12,
                color: Colors.white,
              ),
            ),
          ],
        );
      }).toList(),
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
        topTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: false, // Remover título superior
          ),
        ),
        rightTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: false, // Remover título direito
          ),
        ),
        bottomTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true, // Manter título inferior
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
                      fontSize: 11,
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
            showTitles: true, // Manter título esquerdo
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
        isCurved: isCurved,
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
