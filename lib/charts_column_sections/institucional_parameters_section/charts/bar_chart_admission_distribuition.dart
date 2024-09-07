import 'package:bi_ufcg/core/ui/styles/colors_app.dart';
import 'package:bi_ufcg/service/data/data.dart';
import 'package:bi_ufcg/widgets/widget_no_data.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BarChartAdmissionTypeDistribution extends StatefulWidget {
  const BarChartAdmissionTypeDistribution({super.key});

  @override
  State<StatefulWidget> createState() =>
      BarChartAdmissionTypeDistributionState();
}

class BarChartAdmissionTypeDistributionState
    extends State<BarChartAdmissionTypeDistribution> {
  int touchedGroupIndex = -1;

  @override
  Widget build(BuildContext context) {
    final data = Provider.of<Data>(context);

    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 700),
      switchInCurve: Curves.easeInOut,
      switchOutCurve: Curves.easeInOut,
      child: data.admissionTypeDistribution.isEmpty
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
                                      final admissionNames =
                                          _getAdmissionNames(data);
                                      final index = value.toInt();
                                      return SideTitleWidget(
                                        axisSide: meta.axisSide,
                                        child: Text(
                                          admissionNames[index].substring(0,
                                              3), // Exibe apenas 3 letras no eixo X
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
                                    final admissionNames =
                                        _getAdmissionNames(data);
                                    final admissionName = admissionNames[
                                        groupIndex]; // Nome completo no tooltip
                                    final value = rod.toY;
                                    return BarTooltipItem(
                                      '$admissionName\n$value',
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
    final combinedAdmissionData = <String, int>{};

    // Combina todos os tipos de admissão de todos os períodos
    data.admissionTypeDistribution.forEach((_, admissionMap) {
      admissionMap.forEach((admissionType, count) {
        if (combinedAdmissionData.containsKey(admissionType)) {
          combinedAdmissionData[admissionType] =
              combinedAdmissionData[admissionType]! + count;
        } else {
          combinedAdmissionData[admissionType] = count;
        }
      });
    });

    // Organiza os tipos de admissão em ordem decrescente
    final sortedAdmissions = combinedAdmissionData.entries.toList()
      ..sort((a, b) => b.value.compareTo(a.value));

    return List.generate(sortedAdmissions.length, (index) {
      final entry = sortedAdmissions[index];
      return BarChartGroupData(
        x: index,
        barRods: [
          BarChartRodData(
            toY: entry.value.toDouble(),
            color: ColorsApp.getColorForIndex(
                index), // Cor dinâmica para cada tipo de admissão
            width: 10,
          ),
        ],
        showingTooltipIndicators: touchedGroupIndex == index ? [0] : [],
      );
    });
  }

  // Obter o valor máximo para o eixo Y
  double _getMaxY(Data data) {
    final combinedAdmissionData = <String, int>{};

    data.admissionTypeDistribution.forEach((_, admissionMap) {
      admissionMap.forEach((admissionType, count) {
        if (combinedAdmissionData.containsKey(admissionType)) {
          combinedAdmissionData[admissionType] =
              combinedAdmissionData[admissionType]! + count;
        } else {
          combinedAdmissionData[admissionType] = count;
        }
      });
    });

    return combinedAdmissionData.values
        .fold(0, (a, b) => a > b ? a : b)
        .toDouble();
  }

  // Método para obter os nomes dos tipos de admissão
  List<String> _getAdmissionNames(Data data) {
    final combinedAdmissionData = <String, int>{};

    data.admissionTypeDistribution.forEach((_, admissionMap) {
      admissionMap.forEach((admissionType, count) {
        if (combinedAdmissionData.containsKey(admissionType)) {
          combinedAdmissionData[admissionType] =
              combinedAdmissionData[admissionType]! + count;
        } else {
          combinedAdmissionData[admissionType] = count;
        }
      });
    });

    // Organiza os nomes em ordem decrescente com base nos valores
    final sortedAdmissions = combinedAdmissionData.entries.toList()
      ..sort((a, b) => b.value.compareTo(a.value));

    // Retorna a lista completa de nomes de admissão
    return sortedAdmissions.map((entry) => entry.key).toList();
  }
}
