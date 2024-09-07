import 'package:bi_ufcg/core/ui/styles/colors_app.dart';
import 'package:bi_ufcg/service/data/data.dart';
import 'package:bi_ufcg/widgets/widget_no_data.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LineChartAgeDistribution extends StatefulWidget {
  const LineChartAgeDistribution({super.key});

  @override
  State<StatefulWidget> createState() => LineChartAgeDistributionState();
}

class LineChartAgeDistributionState extends State<LineChartAgeDistribution> {
  bool isCurved = true;

  @override
  Widget build(BuildContext context) {
    final data = Provider.of<Data>(context);

    if (data.ageDistribution.isEmpty) {
      return const WidgetNoData();
    }

    final periods = data.ageDistribution.keys.toList()
      ..sort((a, b) => double.parse(a).compareTo(double.parse(b)));

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: SingleChildScrollView(
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Card(
                    color: context.colors.chartCardColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    elevation: 3,
                    child: AspectRatio(
                      aspectRatio: 1,
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          children: [
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
                IconButton(
                  icon: Icon(
                    Icons.refresh,
                    color: Colors.grey,
                  ),
                  onPressed: () {
                    setState(() {
                      isCurved = !isCurved;
                    });
                  },
                ),
              ],
            ),
            const SizedBox(height: 10),
          ],
        ),
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
                        fontSize: 11),
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
          fitInsideHorizontally: true,
          fitInsideVertically: true,
          getTooltipItems: (touchedBarSpots) {
            bool periodShown = false; // Controle para exibir o período uma vez

            return touchedBarSpots.map((spot) {
              final periodIndex = spot.x.toInt();
              final period = periods[periodIndex];
              final ageGroup = data.ageDistribution[period]!.entries
                  .firstWhere(
                    (entry) =>
                        entry.value.toDouble() == spot.y &&
                        _getColorForAgeGroup(entry.key) == spot.bar.color,
                    orElse: () => MapEntry('Unknown', 0),
                  )
                  .key;

              final color = _getColorForAgeGroup(ageGroup);

              // Adiciona o período apenas uma vez
              List<TextSpan> children = [];
              if (!periodShown) {
                children.add(
                  TextSpan(
                    text: '$period\n', // Exibe o período uma única vez
                    style: const TextStyle(
                      color: Colors.grey,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                );
                periodShown = true; // Marca que o período já foi exibido
              }

              // Adiciona o grupo etário e o valor
              children.add(
                TextSpan(
                  text: '$ageGroup:\n ${spot.y.toInt()}',
                  style: TextStyle(
                    color: color,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              );

              return LineTooltipItem(
                '', // Deixa o texto principal vazio
                TextStyle(),
                children: children,
              );
            }).toList();
          },
        ),
      ),
    );
  }

  List<LineChartBarData> _generateLineBars(
      Data data, List<String> periods, bool isCurved) {
    final ageData = <String, List<FlSpot>>{};

    for (var i = 0; i < periods.length; i++) {
      final period = periods[i];
      final ageMap = data.ageDistribution[period]!;

      ageMap.forEach((ageGroup, count) {
        final existingSpots = ageData.putIfAbsent(ageGroup, () => []);
        if (!existingSpots.any(
            (spot) => spot.x == i.toDouble() && spot.y == count.toDouble())) {
          existingSpots.add(FlSpot(i.toDouble(), count.toDouble()));
        }
      });
    }

    return ageData.entries.map((entry) {
      return LineChartBarData(
        spots: entry.value,
        isCurved: isCurved,
        color: _getColorForAgeGroup(entry.key),
        barWidth: 4,
        isStrokeCapRound: true,
        belowBarData: BarAreaData(show: false),
      );
    }).toList();
  }

  Color _getColorForAgeGroup(String ageGroup) {
    switch (ageGroup) {
      case '16-20':
        return const Color(0xff0293ee);
      case '21-25':
        return const Color(0xFFFFC300);
      case '26-30':
        return const Color(0xffff5182);
      case '30+':
        return const Color(0xff13d38e);
      default:
        return Colors.grey;
    }
  }
}
