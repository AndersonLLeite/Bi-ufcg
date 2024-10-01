import 'package:bi_ufcg/shared/ui/styles/colors_app.dart';
import 'package:bi_ufcg/shared/widgets/widget_no_data.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class BarChartGrouped extends StatefulWidget {
  final Map<String, Map<String, double>> dataMap; // Dados no formato genérico

  const BarChartGrouped({
    Key? key,
    required this.dataMap,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _BarChartGroupedState();
}

class _BarChartGroupedState extends State<BarChartGrouped> {
  int touchedGroupIndex = -1;

  @override
  Widget build(BuildContext context) {
    if (widget.dataMap.isEmpty) {
      return const WidgetNoData();
    }

    // Ordenar os períodos para exibir de forma crescente
    final sortedPeriods = widget.dataMap.keys.toList()
      ..sort((a, b) => double.parse(a).compareTo(double.parse(b)));

    // Obter todas as categorias possíveis para gerar as barras
    final categories =
        widget.dataMap.values.expand((map) => map.keys).toSet().toList();

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: AnimatedSwitcher(
        duration: const Duration(milliseconds: 700),
        switchInCurve: Curves.easeInOut,
        switchOutCurve: Curves.easeInOut,
        child: Card(
          key: const ValueKey('chart'),
          color: context.colors.chartCardColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          elevation: 3,
          child: AspectRatio(
            aspectRatio: 1.6,
            child: Padding(
              padding: const EdgeInsets.all(8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(24),
                      child: BarChart(
                        BarChartData(
                          alignment: BarChartAlignment.spaceBetween,
                          borderData: FlBorderData(
                            show: true,
                            border: Border.symmetric(
                              horizontal: BorderSide(
                                color: Colors.grey.withOpacity(0.2),
                              ),
                            ),
                          ),
                          titlesData: FlTitlesData(
                            show: true,
                            leftTitles: AxisTitles(
                              drawBehindEverything: true,
                              sideTitles: SideTitles(
                                showTitles: true,
                                reservedSize: 30,
                                getTitlesWidget: (value, meta) {
                                  return Text(
                                    value.toInt().toString(),
                                    textAlign: TextAlign.left,
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  );
                                },
                              ),
                            ),
                            bottomTitles: AxisTitles(
                              sideTitles: SideTitles(
                                showTitles: true,
                                reservedSize: 36,
                                getTitlesWidget: (value, meta) {
                                  final index = value.toInt();
                                  return SideTitleWidget(
                                    axisSide: meta.axisSide,
                                    child: Text(
                                      sortedPeriods[index],
                                      style: TextStyle(
                                        color: touchedGroupIndex == index
                                            ? Colors.white
                                            : Colors.grey,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 11,
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
                            rightTitles: AxisTitles(),
                            topTitles: AxisTitles(),
                          ),
                          gridData: FlGridData(
                            show: true,
                            drawVerticalLine: false,
                            getDrawingHorizontalLine: (value) => FlLine(
                              color: Colors.grey.withOpacity(0.2),
                              strokeWidth: 1,
                            ),
                          ),
                          barGroups:
                              List.generate(sortedPeriods.length, (index) {
                            final period = sortedPeriods[index];
                            final periodData = widget.dataMap[period]!;

                            return generateBarGroup(
                              index,
                              periodData,
                              categories,
                            );
                          }),
                          maxY: _getMaxY(widget.dataMap, categories),
                          barTouchData: BarTouchData(
                            enabled: true,
                            handleBuiltInTouches: false,
                            touchTooltipData: BarTouchTooltipData(
                              fitInsideHorizontally: true,
                              fitInsideVertically: true,
                              maxContentWidth: 270,
                              tooltipBgColor: Colors.white,
                              tooltipRoundedRadius: 8,
                              getTooltipItem: (
                                BarChartGroupData group,
                                int groupIndex,
                                BarChartRodData rod,
                                int rodIndex,
                              ) {
                                // Exibe o tooltip apenas uma vez por grupo
                                if (rodIndex != 0) {
                                  return null;
                                }

                                final period = sortedPeriods[groupIndex];
                                final periodData = widget.dataMap[period]!;
                                final tooltipItems = <TextSpan>[
                                  TextSpan(
                                    text: '$period\n',
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.grey,
                                    ),
                                  ),
                                ];

                                // Itera sobre as categorias e adiciona os valores ao tooltip
                                for (int i = 0; i < categories.length; i++) {
                                  final category = categories[i];
                                  final value =
                                      periodData[category]?.toDouble() ?? 0.0;
                                  final color = ColorsApp.getColorForIndex(i);

                                  tooltipItems.add(
                                    TextSpan(
                                      text:
                                          '$category: ${value == value.toInt() ? value.toInt().toString() : value.toStringAsFixed(2)}\n',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: color,
                                      ),
                                    ),
                                  );
                                }

                                return BarTooltipItem(
                                  '', // Tooltip principal vazio
                                  const TextStyle(),
                                  children: tooltipItems,
                                );
                              },
                            ),
                            touchCallback: (event, response) {
                              if (event.isInterestedForInteractions &&
                                  response != null &&
                                  response.spot != null) {
                                setState(() {
                                  touchedGroupIndex =
                                      response.spot!.touchedBarGroupIndex;
                                });
                              } else {
                                setState(() {
                                  touchedGroupIndex = -1;
                                });
                              }
                            },
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  BarChartGroupData generateBarGroup(
    int x,
    Map<String, double> periodData,
    List<String> categories,
  ) {
    return BarChartGroupData(
      x: x,
      barRods: List.generate(categories.length, (i) {
        final category = categories[i];
        final value = periodData[category]?.toDouble() ?? 0.0;

        return BarChartRodData(
          toY: value,
          color: ColorsApp.getColorForIndex(i),
          width: 10,
        );
      }),
      showingTooltipIndicators: touchedGroupIndex == x
          ? [0]
          : [], // Mostra o tooltip para o primeiro rod
    );
  }

  double _getMaxY(
      Map<String, Map<String, double>> dataMap, List<String> categories) {
    double maxY = 0;
    for (var periodData in dataMap.values) {
      for (var category in categories) {
        maxY = maxY < (periodData[category]?.toDouble() ?? 0.0)
            ? (periodData[category]?.toDouble() ?? 0.0)
            : maxY;
      }
    }
    return maxY + 10; // Adiciona uma margem ao máximo
  }
}
