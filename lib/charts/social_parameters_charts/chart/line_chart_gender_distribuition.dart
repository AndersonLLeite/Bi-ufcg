import 'package:bi_ufcg/resource/app_colors.dart';
import 'package:bi_ufcg/service/data/data.dart';
import 'package:bi_ufcg/widgets/widget_no_data.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LineChartGenderDistribution extends StatefulWidget {
  const LineChartGenderDistribution({super.key});

  @override
  _LineChartGenderDistributionState createState() =>
      _LineChartGenderDistributionState();
}

class _LineChartGenderDistributionState
    extends State<LineChartGenderDistribution> {
  bool isCurved = true;

  @override
  Widget build(BuildContext context) {
    final data = Provider.of<Data>(context);

    if (data.genderDistribution.isEmpty) {
      return const WidgetNoData();
    }

    final periods = data.genderDistribution.keys.toList()
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
                    color: AppColors.purpleLight,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    elevation: 3,
                    child: AspectRatio(
                      aspectRatio: 0.95,
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
            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }

  LineChartData _buildLineChartData(Data data, List<String> periods) {
    final maleSpots = <FlSpot>[];
    final femaleSpots = <FlSpot>[];

    for (var i = 0; i < periods.length; i++) {
      final period = periods[i];
      final periodData = data.genderDistribution[period]!;

      final maleValue = periodData['MASCULINO']?.toDouble() ?? 0;
      final femaleValue = periodData['FEMININO']?.toDouble() ?? 0;

      maleSpots.add(FlSpot(i.toDouble(), maleValue));
      femaleSpots.add(FlSpot(i.toDouble(), femaleValue));
    }

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
        // Remover os títulos do topo e da direita
        topTitles: AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        rightTitles: AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
      ),
      borderData: FlBorderData(
        show: true,
        border: Border.all(
          color: Colors.grey.withOpacity(0.5),
          width: 1,
        ),
      ),
      lineBarsData: [
        LineChartBarData(
          spots: maleSpots,
          isCurved: isCurved,
          color: AppColors.maleColor,
          barWidth: 4,
          isStrokeCapRound: true,
          belowBarData: BarAreaData(show: false),
        ),
        LineChartBarData(
          spots: femaleSpots,
          isCurved: isCurved,
          color: AppColors.femaleColor,
          barWidth: 4,
          isStrokeCapRound: true,
          belowBarData: BarAreaData(show: false),
        ),
      ],
      lineTouchData: LineTouchData(
        touchTooltipData: LineTouchTooltipData(
          tooltipBgColor: Colors.white,
          getTooltipItems: (touchedBarSpots) {
            return touchedBarSpots.map((spot) {
              final periodIndex = spot.x.toInt();
              final period = periods[periodIndex];
              final label = spot.bar.color == AppColors.maleColor
                  ? 'Masculino'
                  : 'Feminino';

              return LineTooltipItem(
                '$label:\n${spot.y.toInt()}',
                TextStyle(
                  color: spot.bar.color,
                  fontWeight: FontWeight.bold,
                ),
              );
            }).toList();
          },
        ),
      ),
    );
  }
}
