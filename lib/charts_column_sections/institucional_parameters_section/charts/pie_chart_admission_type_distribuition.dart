import 'package:bi_ufcg/core/ui/styles/colors_app.dart';
import 'package:bi_ufcg/service/data/data.dart';
import 'package:bi_ufcg/widgets/widget_no_data.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../widgets/indicator.dart';

class PieChartAdmissionTypeDistribution extends StatefulWidget {
  const PieChartAdmissionTypeDistribution({super.key});

  @override
  State<StatefulWidget> createState() =>
      _PieChartAdmissionTypeDistributionState();
}

class _PieChartAdmissionTypeDistributionState
    extends State<PieChartAdmissionTypeDistribution> {
  int touchedIndex = -1;
  bool showPercentage = true;
  String selectedPeriod = 'Todos os Períodos';

  @override
  Widget build(BuildContext context) {
    final data = Provider.of<Data>(context);

    List<String> periods = [
      'Todos os Períodos',
      ...data.admissionTypeDistribution.keys
    ];

    // Dados filtrados ou combinados conforme o período selecionado
    final Map<String, int> filteredAdmissionData = <String, int>{};
    if (selectedPeriod == 'Todos os Períodos') {
      // Combina todos os tipos de admissão de todos os períodos
      data.admissionTypeDistribution.forEach((_, admissionMap) {
        admissionMap.forEach((admissionType, count) {
          if (filteredAdmissionData.containsKey(admissionType)) {
            filteredAdmissionData[admissionType] =
                filteredAdmissionData[admissionType]! + count;
          } else {
            filteredAdmissionData[admissionType] = count;
          }
        });
      });
    } else {
      // Filtra os dados pelo período selecionado
      data.admissionTypeDistribution[selectedPeriod]!
          .forEach((admissionType, count) {
        filteredAdmissionData[admissionType] = count;
      });
    }

    return Padding(
      padding: const EdgeInsets.only(left: 8, right: 8),
      child: AnimatedSwitcher(
        duration: const Duration(milliseconds: 700),
        switchInCurve: Curves.easeInOut,
        switchOutCurve: Curves.easeInOut,
        child: filteredAdmissionData.isEmpty
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
                  child: Column(
                    children: [
                      // Dropdown para selecionar o período
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: DropdownButton<String>(
                              dropdownColor: context.colors.primary,
                              value: selectedPeriod,
                              onChanged: (String? newValue) {
                                setState(() {
                                  selectedPeriod = newValue!;
                                });
                              },
                              items: periods.map<DropdownMenuItem<String>>(
                                  (String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(value,
                                      style:
                                          const TextStyle(color: Colors.white)),
                                );
                              }).toList(),
                            ),
                          ),
                          IconButton(
                            icon: Icon(
                              showPercentage
                                  ? Icons.percent
                                  : Icons.format_list_numbered,
                              color: Colors.white,
                            ),
                            onPressed: () {
                              setState(() {
                                showPercentage = !showPercentage;
                              });
                            },
                          ),
                        ],
                      ),
                      Expanded(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Expanded(
                              child: AspectRatio(
                                aspectRatio: 1,
                                child: Tooltip(
                                  message: touchedIndex != -1
                                      ? filteredAdmissionData.entries
                                          .elementAt(touchedIndex)
                                          .key
                                      : '',
                                  child: PieChart(
                                    PieChartData(
                                      pieTouchData: PieTouchData(
                                        touchCallback: (FlTouchEvent event,
                                            pieTouchResponse) {
                                          setState(() {
                                            if (event
                                                    .isInterestedForInteractions &&
                                                pieTouchResponse != null &&
                                                pieTouchResponse
                                                        .touchedSection !=
                                                    null) {
                                              touchedIndex = pieTouchResponse
                                                  .touchedSection!
                                                  .touchedSectionIndex;
                                            } else {
                                              touchedIndex = -1;
                                            }
                                          });
                                        },
                                      ),
                                      borderData: FlBorderData(
                                        show: false,
                                      ),
                                      sectionsSpace: 0,
                                      centerSpaceRadius: 40,
                                      sections: showingSections(
                                          filteredAdmissionData),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: _buildIndicators(filteredAdmissionData),
                            ),
                            const SizedBox(
                              width: 28,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
      ),
    );
  }

  // Cria as seções do gráfico de pizza
  List<PieChartSectionData> showingSections(
      Map<String, int> filteredAdmissionData) {
    final total =
        filteredAdmissionData.values.reduce((a, b) => a + b).toDouble();

    return List.generate(filteredAdmissionData.length, (i) {
      final isTouched = i == touchedIndex;
      final fontSize = isTouched ? 40.0 : 14.0;
      final radius = isTouched ? 80.0 : 50.0;
      const shadows = [Shadow(color: Colors.black, blurRadius: 2)];

      final entry = filteredAdmissionData.entries.elementAt(i);
      final percentage = (entry.value / total) * 100;

      return PieChartSectionData(
        color: ColorsApp.getColorForIndex(i),
        value: entry.value.toDouble(),
        title: showPercentage
            ? '${percentage.toStringAsFixed(1)}%'
            : '${entry.value}',
        radius: radius,
        titleStyle: TextStyle(
          fontSize: fontSize,
          fontWeight: FontWeight.bold,
          color: Colors.white,
          shadows: shadows,
        ),
      );
    });
  }

  // Constrói os indicadores dinamicamente
  List<Widget> _buildIndicators(Map<String, int> filteredAdmissionData) {
    return List.generate(filteredAdmissionData.length, (index) {
      final admissionType = filteredAdmissionData.keys.elementAt(index);
      final color = ColorsApp.getColorForIndex(index);
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 4.0),
        child: Indicator(
          color: color,
          text: admissionType,
          isSquare: true,
        ),
      );
    });
  }
}
