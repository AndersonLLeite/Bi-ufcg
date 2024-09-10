import 'package:bi_ufcg/core/ui/styles/colors_app.dart';
import 'package:bi_ufcg/service/data/data.dart';
import 'package:bi_ufcg/core/widgets/widget_no_data.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/widgets/indicator.dart';

class PieChartSecondarySchoolTypeDistribution extends StatefulWidget {
  const PieChartSecondarySchoolTypeDistribution({super.key});

  @override
  State<StatefulWidget> createState() =>
      PieChartSecondarySchoolTypeDistributionState();
}

class PieChartSecondarySchoolTypeDistributionState
    extends State<PieChartSecondarySchoolTypeDistribution> {
  int touchedIndex = -1;
  bool showPercentage = true;
  String selectedPeriod = 'Todos os Períodos';

  @override
  Widget build(BuildContext context) {
    final data = Provider.of<Data>(context);

    if (data.secondarySchoolTypeDistribution.isEmpty) {
      return const WidgetNoData();
    }

    final periods = data.secondarySchoolTypeDistribution.keys.toList()
      ..sort((a, b) => a.compareTo(b)); // Ordena os períodos

    return Padding(
      padding: const EdgeInsets.only(left: 8, right: 8),
      child: Card(
        color: context.colors.chartCardColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        elevation: 3,
        child: AspectRatio(
          aspectRatio: 0.95,
          child: Column(
            children: [
              // Dropdown para seleção de períodos
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
                      items: [
                        'Todos os Períodos',
                        ...periods,
                      ].map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value,
                              style: const TextStyle(color: Colors.white)),
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
                  children: <Widget>[
                    Expanded(
                      child: AspectRatio(
                        aspectRatio: 1,
                        child: PieChart(
                          PieChartData(
                            pieTouchData: PieTouchData(
                              touchCallback:
                                  (FlTouchEvent event, pieTouchResponse) {
                                setState(() {
                                  if (!event.isInterestedForInteractions ||
                                      pieTouchResponse == null ||
                                      pieTouchResponse.touchedSection == null) {
                                    touchedIndex = -1;
                                    return;
                                  }
                                  touchedIndex = pieTouchResponse
                                      .touchedSection!.touchedSectionIndex;
                                });
                              },
                            ),
                            borderData: FlBorderData(show: false),
                            sectionsSpace: 0,
                            centerSpaceRadius: 40,
                            sections: _buildChartSections(data),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                  ],
                ),
              ),
              _buildIndicators(data),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TotalSecondarySchoolTypes(
                  data: data,
                  period: selectedPeriod,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  List<PieChartSectionData> _buildChartSections(Data data) {
    final filteredSchoolData = <String, int>{};

    // Coleta dinamicamente os tipos de escola secundária
    data.secondarySchoolTypeDistribution.forEach((_, schoolMap) {
      schoolMap.forEach((schoolType, count) {
        filteredSchoolData[schoolType] =
            (filteredSchoolData[schoolType] ?? 0) + count;
      });
    });

    if (selectedPeriod != 'Todos os Períodos') {
      // Limpa dados antigos e pega só do período selecionado
      filteredSchoolData.clear();
      data.secondarySchoolTypeDistribution[selectedPeriod]!
          .forEach((schoolType, count) {
        filteredSchoolData[schoolType] = count;
      });
    }

    final total = filteredSchoolData.values.reduce((a, b) => a + b).toDouble();

    return List.generate(filteredSchoolData.length, (i) {
      final isTouched = i == touchedIndex;
      final fontSize = isTouched ? 25.0 : 14.0;
      final radius = isTouched ? 60.0 : 50.0;
      const shadows = [Shadow(color: Colors.black, blurRadius: 2)];

      final entry = filteredSchoolData.entries.elementAt(i);
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

  Widget _buildIndicators(Data data) {
    final schoolTypes = <String>{};

    // Extrai os tipos de escola secundária dinamicamente
    data.secondarySchoolTypeDistribution.forEach((_, schoolMap) {
      schoolTypes.addAll(schoolMap.keys);
    });

    final schoolTypeList = schoolTypes.toList();

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: List.generate(schoolTypeList.length, (index) {
        return Indicator(
          color: ColorsApp.getColorForIndex(index),
          text: schoolTypeList[index],
          isSquare: true,
        );
      }),
    );
  }
}

// Widget para exibir o total de cada tipo de escola secundária
class TotalSecondarySchoolTypes extends StatelessWidget {
  final Data data;
  final String period;

  const TotalSecondarySchoolTypes({
    Key? key,
    required this.data,
    required this.period,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final filteredSchoolData = <String, int>{};

    if (period == 'Todos os Períodos') {
      data.secondarySchoolTypeDistribution.forEach((_, schoolMap) {
        schoolMap.forEach((schoolType, count) {
          filteredSchoolData[schoolType] =
              (filteredSchoolData[schoolType] ?? 0) + count;
        });
      });
    } else {
      data.secondarySchoolTypeDistribution[period]!
          .forEach((schoolType, count) {
        filteredSchoolData[schoolType] = count;
      });
    }

    final total = filteredSchoolData.values.reduce((a, b) => a + b);

    return Text(
      'Total: $total',
      style: const TextStyle(color: Colors.white, fontSize: 16),
    );
  }
}
