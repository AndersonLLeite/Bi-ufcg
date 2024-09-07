import 'package:bi_ufcg/core/ui/styles/app_colors.dart';
import 'package:bi_ufcg/core/ui/styles/colors_app.dart';
import 'package:bi_ufcg/service/data/data.dart';
import 'package:bi_ufcg/widgets/widget_no_data.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../widgets/indicator.dart';
import '../../social_parameters_section/charts/pie_chart_age.dart';

class PieChartInactivityReasons extends StatefulWidget {
  const PieChartInactivityReasons({super.key});

  @override
  State<StatefulWidget> createState() => PieChartInactivityReasonsState();
}

class PieChartInactivityReasonsState extends State<PieChartInactivityReasons> {
  int touchedIndex = -1;
  bool showPercentage = true;
  String selectedPeriod = 'Todos os Períodos';

  @override
  Widget build(BuildContext context) {
    final data = Provider.of<Data>(context);

    if (data.inactivityReasonsDistribution.isEmpty) {
      return const WidgetNoData();
    }

    final periods = data.inactivityReasonsDistribution.keys.toList()
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
                              style: TextStyle(color: Colors.white)),
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
                child: TotalInactivityReasons(
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
    final filteredReasonData = <String, int>{};

    // Coleta dinamicamente todos os motivos de inatividade
    data.inactivityReasonsDistribution.forEach((_, reasonMap) {
      reasonMap.forEach((reason, count) {
        filteredReasonData[reason] = (filteredReasonData[reason] ?? 0) + count;
      });
    });

    if (selectedPeriod != 'Todos os Períodos') {
      // Limpa dados antigos e pega só do período selecionado
      filteredReasonData.clear();
      data.inactivityReasonsDistribution[selectedPeriod]!
          .forEach((reason, count) {
        filteredReasonData[reason] = count;
      });
    }

    final total = filteredReasonData.values.reduce((a, b) => a + b).toDouble();

    return List.generate(filteredReasonData.length, (i) {
      final isTouched = i == touchedIndex;
      final fontSize = isTouched ? 25.0 : 14.0;
      final radius = isTouched ? 60.0 : 50.0;
      const shadows = [Shadow(color: Colors.black, blurRadius: 2)];

      final entry = filteredReasonData.entries.elementAt(i);
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
    final reasons = <String>{};

    // Extrai os motivos dinamicamente
    data.inactivityReasonsDistribution.forEach((_, reasonMap) {
      reasons.addAll(reasonMap.keys);
    });

    final reasonList = reasons.toList();

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: List.generate(reasonList.length, (index) {
        return Indicator(
          color: ColorsApp.getColorForIndex(index),
          text: reasonList[index],
          isSquare: true,
        );
      }),
    );
  }
}

// Widget para exibir o total de cada motivo de inatividade
class TotalInactivityReasons extends StatelessWidget {
  final Data data;
  final String period;

  const TotalInactivityReasons({
    Key? key,
    required this.data,
    required this.period,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final filteredReasonData = <String, int>{};

    if (period == 'Todos os Períodos') {
      data.inactivityReasonsDistribution.forEach((_, reasonMap) {
        reasonMap.forEach((reason, count) {
          filteredReasonData[reason] =
              (filteredReasonData[reason] ?? 0) + count;
        });
      });
    } else {
      data.inactivityReasonsDistribution[period]!.forEach((reason, count) {
        filteredReasonData[reason] = count;
      });
    }

    final total = filteredReasonData.values.reduce((a, b) => a + b);

    return Text(
      'Total Inativos: $total',
      style: TextStyle(color: Colors.white, fontSize: 16),
    );
  }
}
