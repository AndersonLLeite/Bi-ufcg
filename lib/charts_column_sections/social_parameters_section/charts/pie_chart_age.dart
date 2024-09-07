import 'package:bi_ufcg/core/ui/styles/colors_app.dart';
import 'package:bi_ufcg/service/data/data.dart';
import 'package:bi_ufcg/widgets/widget_no_data.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../widgets/indicator.dart';

class PieChartAge extends StatefulWidget {
  const PieChartAge({super.key});

  @override
  State<StatefulWidget> createState() => PieChartAgeState();
}

class PieChartAgeState extends State<PieChartAge> {
  int touchedIndex = -1;
  bool showPercentage = true;
  String selectedPeriod = 'Todos os Períodos';

  @override
  Widget build(BuildContext context) {
    final data = Provider.of<Data>(context);

    List<String> periods = ['Todos os Períodos', ...data.ageDistribution.keys];

    return Padding(
      padding: const EdgeInsets.only(left: 8, right: 8),
      child: AnimatedSwitcher(
        duration: const Duration(milliseconds: 700),
        switchInCurve: Curves.easeInOut,
        switchOutCurve: Curves.easeInOut,
        child: data.ageDistribution.isEmpty
            ? const WidgetNoData()
            : Card(
                key: const ValueKey('chart'), // Chave para o gráfico
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
                              items: periods.map<DropdownMenuItem<String>>(
                                  (String value) {
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
                                      touchCallback: (FlTouchEvent event,
                                          pieTouchResponse) {
                                        setState(() {
                                          if (!event
                                                  .isInterestedForInteractions ||
                                              pieTouchResponse == null ||
                                              pieTouchResponse.touchedSection ==
                                                  null) {
                                            touchedIndex = -1;
                                            return;
                                          }
                                          touchedIndex = pieTouchResponse
                                              .touchedSection!
                                              .touchedSectionIndex;
                                        });
                                      },
                                    ),
                                    borderData: FlBorderData(
                                      show: false,
                                    ),
                                    sectionsSpace: 0,
                                    centerSpaceRadius: 40,
                                    sections: showingSections(data),
                                  ),
                                ),
                              ),
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Indicator(
                                  color: Color(0xff0293ee),
                                  text: '16-20',
                                  isSquare: true,
                                ),
                                SizedBox(height: 4),
                                Indicator(
                                  color: Color(0xFFFFC300),
                                  text: '21-25',
                                  isSquare: true,
                                ),
                                SizedBox(height: 4),
                                Indicator(
                                  color: Color(0xffff5182),
                                  text: '26-30',
                                  isSquare: true,
                                ),
                                SizedBox(height: 4),
                                Indicator(
                                  color: Color(0xff13d38e),
                                  text: '30+',
                                  isSquare: true,
                                ),
                                SizedBox(height: 18),
                              ],
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

  List<PieChartSectionData> showingSections(Data data) {
    // Dados filtrados com base no período selecionado
    final filteredAgeData = <String, int>{
      '16-20': 0,
      '21-25': 0,
      '26-30': 0,
      '30+': 0,
    };

    if (selectedPeriod == 'Todos os Períodos') {
      // Combina todas as idades de todos os períodos
      data.ageDistribution.forEach((_, ageMap) {
        ageMap.forEach((ageRange, count) {
          filteredAgeData[ageRange] = filteredAgeData[ageRange]! + count;
        });
      });
    } else {
      // Filtra por período selecionado
      data.ageDistribution[selectedPeriod]!.forEach((ageRange, count) {
        filteredAgeData[ageRange] = count;
      });
    }

    final total = filteredAgeData.values.reduce((a, b) => a + b).toDouble();

    return List.generate(filteredAgeData.length, (i) {
      final isTouched = i == touchedIndex;
      final fontSize = isTouched ? 25.0 : 14.0;
      final radius = isTouched ? 60.0 : 50.0;
      const shadows = [Shadow(color: Colors.black, blurRadius: 2)];

      final entry = filteredAgeData.entries.elementAt(i);
      final percentage = (entry.value / total) * 100;

      return PieChartSectionData(
        color: _getSectionColor(i),
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

  Color _getSectionColor(int index) {
    switch (index) {
      case 0:
        return const Color(0xff0293ee); // Cor para 16-20
      case 1:
        return const Color(0xFFFFC300); // Cor para 21-25
      case 2:
        return const Color(0xffff5182); // Cor para 26-30
      case 3:
        return const Color(0xff13d38e); // Cor para 30+
      default:
        return Colors.grey;
    }
  }
}
