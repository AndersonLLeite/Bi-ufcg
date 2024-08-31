import 'package:bi_ufcg/core/ui/styles/colors_app.dart';
import 'package:bi_ufcg/service/data/data.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../resource/app_colors.dart';

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
          color: AppColors.maleColor, // Barra azul para masculino
          width: 10,
        ),
        BarChartRodData(
          toY: femaleValue,
          color: AppColors.femaleColor, // Barra vermelha para feminino
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

    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: AnimatedSwitcher(
        duration: Duration(milliseconds: 700), // Duração da transição
        switchInCurve: Curves.easeInOut,
        switchOutCurve: Curves.easeInOut,
        child: data.genderDistribution.isEmpty
            ? Container(
                key: ValueKey('no_data'), // Chave única para o estado sem dados
                padding: EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black26,
                      blurRadius: 10,
                      offset: Offset(0, 5),
                    ),
                  ],
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.data_usage_outlined,
                      size: 100,
                      color: Colors.grey.shade300,
                    ),
                    SizedBox(height: 20),
                    Text(
                      'Nenhum dado disponível',
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey.shade700,
                      ),
                    ),
                    SizedBox(height: 10),
                    Text(
                      'Por favor, adicione pelo menos 1 curso e 1 período para visualizar os dados.',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.grey.shade500,
                      ),
                    ),
                  ],
                ),
              )
            : Card(
                key: ValueKey('chart'), // Chave única para o gráfico
                color: AppColors.purpleLight,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)),
                elevation: 3,
                child: AspectRatio(
                  aspectRatio: 0.8, // Aumenta a altura das barras
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: <Widget>[
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: const <Widget>[
                            Text(
                              'Gênero',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 18),
                            ),
                          ],
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              'Masculino',
                              style: TextStyle(
                                  color: AppColors.maleColor, fontSize: 16),
                            ),
                            const Text(
                              ' E ',
                              style: TextStyle(
                                  color: Color(0xff77839a), fontSize: 16),
                            ),
                            Text(
                              'Feminino',
                              style: TextStyle(
                                  color: AppColors.femaleColor, fontSize: 16),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 8,
                        ),
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
                                                  ? Colors.black
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
                                barGroups: List.generate(sortedPeriods.length,
                                    (index) {
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
                                    tooltipBgColor: Colors
                                        .black87, // Cor de fundo do tooltip
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
                                              color: AppColors.maleColor,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          TextSpan(
                                            text: maleValue.toString(),
                                            style: const TextStyle(
                                              color: AppColors.maleColor,
                                            ),
                                          ),
                                          TextSpan(
                                            text: '\nF: ',
                                            style: TextStyle(
                                              color: AppColors.femaleColor,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          TextSpan(
                                            text: femaleValue.toString(),
                                            style: TextStyle(
                                              color: AppColors.femaleColor,
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
      ),
    );
  }
}
