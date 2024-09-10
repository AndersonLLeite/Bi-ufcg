import 'package:bi_ufcg/core/ui/styles/colors_app.dart';
import 'package:bi_ufcg/service/data/data.dart';
import 'package:bi_ufcg/core/widgets/widget_no_data.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BarChartGroupedGender extends StatefulWidget {
  const BarChartGroupedGender({super.key});

  @override
  State<StatefulWidget> createState() => BarChartGroupedGenderState();
}

class BarChartGroupedGenderState extends State<BarChartGroupedGender> {
  int touchedGroupIndex = -1;
  int? touchedRodIndex;

  BarChartGroupData generateBarGroup(
    int x,
    double maleValue,
    double femaleValue,
  ) {
    return BarChartGroupData(
      x: x,
      barRods: [
        BarChartRodData(
          toY: maleValue,
          color: context.colors.maleColor, // Barra azul para masculino
          width: 10,
        ),
        BarChartRodData(
          toY: femaleValue,
          color: context.colors.femaleColor, // Barra vermelha para feminino
          width: 10,
        ),
      ],
      showingTooltipIndicators: touchedGroupIndex == x ? [0, 1] : [],
    );
  }

  @override
  Widget build(BuildContext context) {
    final data = Provider.of<Data>(context);

    // Ordena os períodos em ordem crescente com base no valor double
    final sortedPeriods = data.genderDistribution.keys.toList()
      ..sort((a, b) => double.parse(a).compareTo(double.parse(b)));

    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 700), // Duração da transição
      switchInCurve: Curves.easeInOut,
      switchOutCurve: Curves.easeInOut,
      child: data.genderDistribution.isEmpty
          ? const WidgetNoData()
          : Card(
              key: const ValueKey('chart'), // Chave única para o gráfico
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
                                final periodData =
                                    data.genderDistribution[period]!;
                                return generateBarGroup(
                                  index,
                                  periodData['MASCULINO']?.toDouble() ?? 0,
                                  periodData['FEMININO']?.toDouble() ?? 0,
                                );
                              }),
                              maxY: data.genderDistribution.values
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
                                    if (rodIndex != 0) {
                                      return null; // Retorna nulo para evitar duplicação
                                    }
                                    final maleValue = group.barRods[0].toY;
                                    final femaleValue = group.barRods[1].toY;
                                    return BarTooltipItem(
                                      '',
                                      TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: rod.color,
                                      ),
                                      children: [
                                        TextSpan(
                                          text: 'M: ',
                                          style: TextStyle(
                                            color: context.colors.maleColor,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        TextSpan(
                                          text: maleValue.toString(),
                                          style: TextStyle(
                                            color: context.colors.maleColor,
                                          ),
                                        ),
                                        TextSpan(
                                          text: '\nF: ',
                                          style: TextStyle(
                                            color: context.colors.femaleColor,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        TextSpan(
                                          text: femaleValue.toString(),
                                          style: TextStyle(
                                            color: context.colors.femaleColor,
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
