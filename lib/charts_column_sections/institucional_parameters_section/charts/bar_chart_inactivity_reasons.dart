import 'package:bi_ufcg/core/ui/styles/colors_app.dart';
import 'package:bi_ufcg/service/data/data.dart';
import 'package:bi_ufcg/widgets/widget_no_data.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BarChartInactivityReasons extends StatefulWidget {
  const BarChartInactivityReasons({super.key});

  @override
  State<StatefulWidget> createState() => BarChartInactivityReasonsState();
}

class BarChartInactivityReasonsState extends State<BarChartInactivityReasons> {
  int touchedGroupIndex = -1;

  @override
  Widget build(BuildContext context) {
    final data = Provider.of<Data>(context);

    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 700),
      switchInCurve: Curves.easeInOut,
      switchOutCurve: Curves.easeInOut,
      child: data.inactivityReasonsDistribution.isEmpty
          ? const WidgetNoData()
          : Card(
              key: const ValueKey('chart'),
              color: context.colors.chartCardColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              elevation: 3,
              child: AspectRatio(
                aspectRatio: 0.95,
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      const SizedBox(height: 8),
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
                                      final reasonNames = _getReasonNames(data);
                                      final index = value.toInt();
                                      return SideTitleWidget(
                                        axisSide: meta.axisSide,
                                        child: Text(
                                          reasonNames[index].substring(0,
                                              3), // Pegando apenas as 4 primeiras letras
                                          style: TextStyle(
                                            color: touchedGroupIndex == index
                                                ? Colors.white
                                                : Colors.grey,
                                            fontWeight: FontWeight.bold,
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
                              barGroups: _generateBarGroups(data),
                              maxY: _getMaxY(data) + 10,
                              barTouchData: BarTouchData(
                                enabled: true,
                                touchTooltipData: BarTouchTooltipData(
                                  tooltipBgColor: Colors.white,
                                  getTooltipItem:
                                      (group, groupIndex, rod, rodIndex) {
                                    final reasonNames = _getReasonNames(data);
                                    final reasonName = reasonNames[groupIndex];
                                    final value = rod.toY;
                                    return BarTooltipItem(
                                      '$reasonName\n$value',
                                      TextStyle(
                                        color: rod.color,
                                        fontWeight: FontWeight.bold,
                                      ),
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
    );
  }

  // Gera os grupos de barras para o gráfico
  List<BarChartGroupData> _generateBarGroups(Data data) {
    final combinedReasonsData = <String, int>{};

    // Combina todos os motivos de inatividade de todos os períodos
    data.inactivityReasonsDistribution.forEach((_, reasonMap) {
      reasonMap.forEach((reason, count) {
        if (combinedReasonsData.containsKey(reason)) {
          combinedReasonsData[reason] = combinedReasonsData[reason]! + count;
        } else {
          combinedReasonsData[reason] = count;
        }
      });
    });

    // Organiza os motivos em ordem decrescente
    final sortedReasons = combinedReasonsData.entries.toList()
      ..sort(
          (a, b) => b.value.compareTo(a.value)); // Ordena em ordem decrescente

    return List.generate(sortedReasons.length, (index) {
      final entry = sortedReasons[index];
      return BarChartGroupData(
        x: index,
        barRods: [
          BarChartRodData(
            toY: entry.value.toDouble(),
            color: ColorsApp.getColorForIndex(
                index), // Cor dinâmica para cada motivo
            width: 10,
          ),
        ],
        showingTooltipIndicators: touchedGroupIndex == index ? [0] : [],
      );
    });
  }

  // Obter o valor máximo para o eixo Y
  double _getMaxY(Data data) {
    final combinedReasonsData = <String, int>{};

    data.inactivityReasonsDistribution.forEach((_, reasonMap) {
      reasonMap.forEach((reason, count) {
        if (combinedReasonsData.containsKey(reason)) {
          combinedReasonsData[reason] = combinedReasonsData[reason]! + count;
        } else {
          combinedReasonsData[reason] = count;
        }
      });
    });

    return combinedReasonsData.values
        .fold(0, (a, b) => a > b ? a : b)
        .toDouble();
  }

  // Método para obter os nomes dos motivos de inatividade
  List<String> _getReasonNames(Data data) {
    final combinedReasonsData = <String, int>{};

    data.inactivityReasonsDistribution.forEach((_, reasonMap) {
      reasonMap.forEach((reason, count) {
        if (combinedReasonsData.containsKey(reason)) {
          combinedReasonsData[reason] = combinedReasonsData[reason]! + count;
        } else {
          combinedReasonsData[reason] = count;
        }
      });
    });

    // Organiza os nomes em ordem decrescente com base nos valores
    final sortedReasons = combinedReasonsData.entries.toList()
      ..sort(
          (a, b) => b.value.compareTo(a.value)); // Ordena em ordem decrescente

    return sortedReasons.map((entry) => entry.key).toList();
  }
}
