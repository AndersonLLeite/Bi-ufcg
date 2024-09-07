import 'package:bi_ufcg/core/ui/styles/colors_app.dart';
import 'package:bi_ufcg/service/data/data.dart';
import 'package:bi_ufcg/widgets/widget_no_data.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LineChartStatusDistribution extends StatefulWidget {
  const LineChartStatusDistribution({super.key});

  @override
  State<StatefulWidget> createState() => _LineChartStatusDistributionState();
}

class _LineChartStatusDistributionState
    extends State<LineChartStatusDistribution> {
  bool isCurved = true;

  @override
  Widget build(BuildContext context) {
    final data = Provider.of<Data>(context);

    if (data.statusDistribution.isEmpty) {
      return const WidgetNoData();
    }

    final periods = data.statusDistribution.keys.toList()
      ..sort((a, b) => a.compareTo(b)); // Ordena os períodos

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
    final activeSpots = <FlSpot>[];
    final inactiveSpots = <FlSpot>[];
    final graduatedSpots = <FlSpot>[];

    for (var i = 0; i < periods.length; i++) {
      final period = periods[i];
      final periodData = data.statusDistribution[period]!;

      final activeValue = periodData['ATIVO']?.toDouble() ?? 0;
      final inactiveValue = periodData['INATIVO']?.toDouble() ?? 0;
      final graduatedValue = periodData['GRADUADO']?.toDouble() ?? 0;

      activeSpots.add(FlSpot(i.toDouble(), activeValue));
      inactiveSpots.add(FlSpot(i.toDouble(), inactiveValue));
      graduatedSpots.add(FlSpot(i.toDouble(), graduatedValue));
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
          spots: activeSpots,
          isCurved: isCurved,
          color: context.colors.activeColor,
          barWidth: 4,
          isStrokeCapRound: true,
          belowBarData: BarAreaData(show: false),
        ),
        LineChartBarData(
          spots: inactiveSpots,
          isCurved: isCurved,
          color: context.colors.inactiveColor,
          barWidth: 4,
          isStrokeCapRound: true,
          belowBarData: BarAreaData(show: false),
        ),
        LineChartBarData(
          spots: graduatedSpots,
          isCurved: isCurved,
          color: context.colors.graduatedColor,
          barWidth: 4,
          isStrokeCapRound: true,
          belowBarData: BarAreaData(show: false),
        ),
      ],
      lineTouchData: LineTouchData(
        touchTooltipData: LineTouchTooltipData(
          tooltipBgColor: Colors.white,
          tooltipPadding: const EdgeInsets.all(8),
          tooltipRoundedRadius: 8,
          showOnTopOfTheChartBoxArea: true,
          fitInsideHorizontally: true,
          fitInsideVertically: true,
          getTooltipItems: (touchedBarSpots) {
            bool periodShown = false;

            return touchedBarSpots.map((spot) {
              final periodIndex = spot.x.toInt();
              final period = periods[periodIndex];
              final label = spot.bar.color == context.colors.activeColor
                  ? 'Ativo'
                  : spot.bar.color == context.colors.inactiveColor
                      ? 'Inativo'
                      : 'Graduado';

              List<TextSpan> children = [];
              if (!periodShown) {
                children.add(
                  TextSpan(
                    text: '$period\n',
                    style: const TextStyle(
                      color: Colors.grey,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                );
                periodShown = true;
              }

              children.add(
                TextSpan(
                  text: '$label:\n${spot.y.toInt()}',
                  style: TextStyle(
                    color: spot.bar.color,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              );

              return LineTooltipItem(
                '',
                TextStyle(),
                children: children,
              );
            }).toList();
          },
        ),
      ),
    );
  }
}
