import 'package:bi_ufcg/core/ui/styles/colors_app.dart';
import 'package:bi_ufcg/service/data/data.dart';
import 'package:bi_ufcg/core/widgets/indicator.dart';
import 'package:bi_ufcg/core/widgets/widget_no_data.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PieChartStatus extends StatefulWidget {
  const PieChartStatus({super.key});

  @override
  State<StatefulWidget> createState() => PieChartStatusState();
}

class PieChartStatusState extends State<PieChartStatus> {
  int touchedIndex = -1;
  bool showPercentage = true;
  String selectedPeriod = 'Todos os Períodos';

  @override
  Widget build(BuildContext context) {
    final data = Provider.of<Data>(context);

    List<String> periods = [
      'Todos os Períodos',
      ...data.statusDistribution.keys
    ];

    return Padding(
      padding: const EdgeInsets.only(left: 8, right: 8),
      child: AnimatedSwitcher(
        duration: const Duration(milliseconds: 700),
        switchInCurve: Curves.easeInOut,
        switchOutCurve: Curves.easeInOut,
        child: data.statusDistribution.isEmpty
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
                            const Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Indicator(
                                  color: Color(0xff0293ee),
                                  text: 'ATIVO',
                                  isSquare: true,
                                ),
                                SizedBox(height: 4),
                                Indicator(
                                  color: Color(0xffff5182),
                                  text: 'INATIVO',
                                  isSquare: true,
                                ),
                                SizedBox(height: 4),
                                Indicator(
                                  color: Color(0xFFFFC300),
                                  text: 'GRADUADO',
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
                      // Exibe o total de ativos e inativos
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TotalStatus(data: data, period: selectedPeriod),
                      ),
                    ],
                  ),
                ),
              ),
      ),
    );
  }

  List<PieChartSectionData> showingSections(Data data) {
    final filteredStatusData = <String, int>{
      'ATIVO': 0,
      'INATIVO': 0,
      'GRADUADO': 0,
    };

    if (data.statusDistribution.isEmpty) {
      return []; // Retorna uma lista vazia se não houver dados
    }

    if (selectedPeriod == 'Todos os Períodos') {
      // Combina todos os status de todos os períodos
      data.statusDistribution.forEach((_, statusMap) {
        statusMap.forEach((status, count) {
          filteredStatusData[status] =
              (filteredStatusData[status] ?? 0) + count;
        });
      });
    } else {
      // Filtra por período selecionado
      filteredStatusData.forEach((status, count) {
        filteredStatusData[status] =
            data.statusDistribution[selectedPeriod]?[status] ?? 0;
      });
    }

    final total = filteredStatusData.values.reduce((a, b) => a + b).toDouble();

    return List.generate(filteredStatusData.length, (i) {
      final isTouched = i == touchedIndex;
      final fontSize = isTouched ? 25.0 : 14.0;
      final radius = isTouched ? 60.0 : 50.0;
      const shadows = [Shadow(color: Colors.black, blurRadius: 2)];

      final entry = filteredStatusData.entries.elementAt(i);
      final percentage = (total > 0)
          ? (entry.value / total) * 100
          : 0; // Previne divisão por zero

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
        return const Color(0xff0293ee); // Cor para ATIVO
      case 1:
        return const Color(0xffff5182); // Cor para INATIVO
      case 2:
        return const Color(0xFFFFC300); // Cor para GRADUADO
      default:
        return Colors.grey;
    }
  }
}

// Widget para exibir o total de ATIVO e INATIVO
class TotalStatus extends StatelessWidget {
  final Data data;
  final String period;

  const TotalStatus({
    Key? key,
    required this.data,
    required this.period,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    int totalAtivo = 0;
    int totalInativo = 0;
    int totalGraduado = 0;

    if (period == 'Todos os Períodos') {
      data.statusDistribution.forEach((_, statusMap) {
        totalAtivo += statusMap['ATIVO'] ?? 0;
        totalInativo += statusMap['INATIVO'] ?? 0;
        totalGraduado += statusMap['GRADUADO'] ?? 0;
      });
    } else {
      totalAtivo = data.statusDistribution[period]!['ATIVO'] ?? 0;
      totalInativo = data.statusDistribution[period]!['INATIVO'] ?? 0;
      totalGraduado = data.statusDistribution[period]!['GRADUADO'] ?? 0;
    }

    return Text(
      'Total Matriculado: ${totalAtivo + totalInativo + totalGraduado}\n',
      style: const TextStyle(color: Colors.white, fontSize: 16),
    );
  }
}
