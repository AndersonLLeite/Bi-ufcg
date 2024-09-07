import 'package:bi_ufcg/core/ui/styles/colors_app.dart';
import 'package:bi_ufcg/service/data/data.dart';
import 'package:bi_ufcg/widgets/widget_no_data.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LineChartAdmissionTypeDistribution extends StatefulWidget {
  const LineChartAdmissionTypeDistribution({super.key});

  @override
  State<StatefulWidget> createState() =>
      _LineChartAdmissionTypeDistributionState();
}

class _LineChartAdmissionTypeDistributionState
    extends State<LineChartAdmissionTypeDistribution> {
  bool isCurved = true;

  @override
  Widget build(BuildContext context) {
    final data = Provider.of<Data>(context);

    if (data.admissionTypeDistribution.isEmpty) {
      return const WidgetNoData();
    }

    final periods = data.admissionTypeDistribution.keys.toList()
      ..sort((a, b) => double.parse(a).compareTo(double.parse(b)));

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: SingleChildScrollView(
        child: Column(
          children: [
            Column(
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
              ],
            ),
            _buildLegend(data),
          ],
        ),
      ),
    );
  }

  Widget _buildLegend(Data data) {
    final admissionTypes = data.admissionTypeDistribution.values
        .expand((map) => map.keys)
        .toSet()
        .toList();

    return Wrap(
      alignment: WrapAlignment.center,
      spacing: 10,
      runSpacing: 10,
      children: List.generate(admissionTypes.length, (index) {
        final admissionType = admissionTypes[index];
        final color = ColorsApp.getColorForIndex(index);
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
              admissionType,
              style: const TextStyle(
                fontSize: 12,
                color: Colors.white,
              ),
            ),
          ],
        );
      }),
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
          sideTitles: SideTitles(showTitles: false),
        ),
        rightTitles: AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
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
              final admissionType =
                  data.admissionTypeDistribution[period]!.entries
                      .firstWhere(
                        (entry) =>
                            entry.value.toDouble() == spot.y &&
                            ColorsApp.getColorForIndex(
                                    _getAdmissionTypeIndex(entry.key, data)) ==
                                spot.bar.color,
                        orElse: () => MapEntry('Unknown', 0),
                      )
                      .key;

              final color = ColorsApp.getColorForIndex(
                  _getAdmissionTypeIndex(admissionType, data));

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
                  text: '$admissionType:\n${spot.y.toInt()}',
                  style: TextStyle(
                    color: color,
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

  List<LineChartBarData> _generateLineBars(
      Data data, List<String> periods, bool isCurved) {
    final admissionData = <String, List<FlSpot>>{};

    for (var i = 0; i < periods.length; i++) {
      final period = periods[i];
      final admissionMap = data.admissionTypeDistribution[period]!;

      admissionMap.forEach((admissionType, count) {
        final existingSpots =
            admissionData.putIfAbsent(admissionType, () => []);
        if (!existingSpots.any(
            (spot) => spot.x == i.toDouble() && spot.y == count.toDouble())) {
          existingSpots.add(FlSpot(i.toDouble(), count.toDouble()));
        }
      });
    }

    return admissionData.entries.map((entry) {
      final index = _getAdmissionTypeIndex(entry.key, data);
      return LineChartBarData(
        spots: entry.value,
        isCurved: isCurved,
        color: ColorsApp.getColorForIndex(index),
        barWidth: 4,
        isStrokeCapRound: true,
        belowBarData: BarAreaData(show: false),
      );
    }).toList();
  }

  int _getAdmissionTypeIndex(String admissionType, Data data) {
    final admissionTypes = data.admissionTypeDistribution.values
        .expand((map) => map.keys)
        .toSet()
        .toList();
    return admissionTypes.indexOf(admissionType);
  }
}
