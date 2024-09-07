import 'package:bi_ufcg/core/ui/styles/colors_app.dart';
import 'package:bi_ufcg/service/data/data.dart';
import 'package:bi_ufcg/widgets/widget_no_data.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BarChartGroupedStatus extends StatefulWidget {
  const BarChartGroupedStatus({super.key});

  @override
  State<StatefulWidget> createState() => BarChartGroupedStatusState();
}

class BarChartGroupedStatusState extends State<BarChartGroupedStatus> {
  int touchedGroupIndex = -1;
  int? touchedRodIndex;

  BarChartGroupData generateBarGroup(
    int x,
    double activeValue,
    double inactiveValue,
    double graduatedValue,
  ) {
    return BarChartGroupData(
      x: x,
      barRods: [
        BarChartRodData(
          toY: activeValue,
          color: context.colors.activeColor, // Barra azul para ativo
          width: 10,
        ),
        BarChartRodData(
          toY: inactiveValue,
          color: context.colors.inactiveColor, // Barra vermelha para inativo
          width: 10,
        ),
        BarChartRodData(
          toY: graduatedValue,
          color: context.colors.graduatedColor, // Barra verde para graduado
          width: 10,
        ),
      ],
      showingTooltipIndicators: touchedGroupIndex == x ? [0, 1, 2] : [],
    );
  }

  @override
  Widget build(BuildContext context) {
    final data = Provider.of<Data>(context);

    // Ordena os períodos em ordem crescente
    final sortedPeriods = data.statusDistribution.keys.toList()
      ..sort((a, b) => a.compareTo(b));

    return AnimatedSwitcher(
      duration: Duration(milliseconds: 700), // Duração da transição
      switchInCurve: Curves.easeInOut,
      switchOutCurve: Curves.easeInOut,
      child: data.statusDistribution.isEmpty
          ? const WidgetNoData()
          : Card(
              key: ValueKey('chart'), // Chave única para o gráfico
              color: context.colors.chartCardColor,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20)),
              elevation: 3,
              child: AspectRatio(
                aspectRatio: 0.95, // Aumenta a altura das barras
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
                                        style: TextStyle(
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
                                final periodData =
                                    data.statusDistribution[period]!;
                                return generateBarGroup(
                                  index,
                                  periodData['ATIVO']?.toDouble() ?? 0,
                                  periodData['INATIVO']?.toDouble() ?? 0,
                                  periodData['GRADUADO']?.toDouble() ?? 0,
                                );
                              }),
                              maxY: data.statusDistribution.values
                                      .expand((e) => e.values)
                                      .reduce((a, b) => a > b ? a : b)
                                      .toDouble() +
                                  10, // Ajuste de maxY dinamicamente
                              barTouchData: BarTouchData(
                                enabled: true,
                                handleBuiltInTouches: false,
                                touchTooltipData: BarTouchTooltipData(
                                  tooltipBgColor:
                                      Colors.white, // Cor de fundo do tooltip
                                  tooltipRoundedRadius:
                                      8, // Bordas arredondadas no tooltip
                                  getTooltipItem: (
                                    BarChartGroupData group,
                                    int groupIndex,
                                    BarChartRodData rod,
                                    int rodIndex,
                                  ) {
                                    if (rodIndex != 0)
                                      return null; // Retorna nulo para evitar duplicação
                                    final activeValue = group.barRods[0].toY;
                                    final inactiveValue = group.barRods[1].toY;
                                    final graduatedValue = group.barRods[2].toY;
                                    return BarTooltipItem(
                                      '',
                                      TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: rod.color,
                                      ),
                                      children: [
                                        TextSpan(
                                          text: 'Ativo: ',
                                          style: TextStyle(
                                            color: context.colors.activeColor,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        TextSpan(
                                          text: activeValue.toString(),
                                          style: TextStyle(
                                            color: context.colors.activeColor,
                                          ),
                                        ),
                                        TextSpan(
                                          text: '\nInativo: ',
                                          style: TextStyle(
                                            color: context.colors.inactiveColor,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        TextSpan(
                                          text: inactiveValue.toString(),
                                          style: TextStyle(
                                            color: context.colors.inactiveColor,
                                          ),
                                        ),
                                        TextSpan(
                                          text: '\nGraduado: ',
                                          style: TextStyle(
                                            color:
                                                context.colors.graduatedColor,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        TextSpan(
                                          text: graduatedValue.toString(),
                                          style: TextStyle(
                                            color:
                                                context.colors.graduatedColor,
                                          ),
                                        ),
                                      ],
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
                                      touchedRodIndex =
                                          response.spot!.touchedRodDataIndex;
                                    });
                                  } else {
                                    setState(() {
                                      touchedGroupIndex = -1;
                                      touchedRodIndex = null;
                                    });
                                  }
                                },
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 12,
                      ),
                    ],
                  ),
                ),
              ),
            ),
    );
  }
}
