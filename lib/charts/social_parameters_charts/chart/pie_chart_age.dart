import 'package:bi_ufcg/resource/app_colors.dart';
import 'package:bi_ufcg/service/data/data.dart';
import 'package:bi_ufcg/widgets/widget_no_data.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PieChartAge extends StatefulWidget {
  const PieChartAge({super.key});

  @override
  State<StatefulWidget> createState() => PieChartAgeState();
}

class PieChartAgeState extends State<PieChartAge> {
  int touchedIndex = -1;
  bool showPercentage = true;

  @override
  Widget build(BuildContext context) {
    final data = Provider.of<Data>(context);

    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: AnimatedSwitcher(
        duration: const Duration(milliseconds: 700),
        switchInCurve: Curves.easeInOut,
        switchOutCurve: Curves.easeInOut,
        child: data.ageDistribution.isEmpty
            ? const WidgetNoData()
            : Card(
                key: const ValueKey('chart'), // Chave para o gráfico
                color: AppColors.purpleLight,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                elevation: 3,
                child: AspectRatio(
                  aspectRatio: 1,
                  child: Column(
                    children: [
                      ListTile(
                        trailing: IconButton(
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
                      ),
                      Row(
                        children: <Widget>[
                          const SizedBox(
                            height: 18,
                          ),
                          Expanded(
                            child: AspectRatio(
                              aspectRatio: 1,
                              child: PieChart(
                                PieChartData(
                                  pieTouchData: PieTouchData(
                                    touchCallback:
                                        (FlTouchEvent event, pieTouchResponse) {
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
                            children: const <Widget>[
                              Indicator(
                                color: Color(0xff0293ee),
                                text: '16-20',
                                isSquare: true,
                              ),
                              SizedBox(
                                height: 4,
                              ),
                              Indicator(
                                color: Color(0xFFFFC300),
                                text: '21-25',
                                isSquare: true,
                              ),
                              SizedBox(
                                height: 4,
                              ),
                              Indicator(
                                color: Color(0xffff5182),
                                text: '26-30',
                                isSquare: true,
                              ),
                              SizedBox(
                                height: 4,
                              ),
                              Indicator(
                                color: Color(0xff13d38e),
                                text: '30+',
                                isSquare: true,
                              ),
                              SizedBox(
                                height: 18,
                              ),
                            ],
                          ),
                          const SizedBox(
                            width: 28,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
      ),
    );
  }

  List<PieChartSectionData> showingSections(Data data) {
    // Combina todas as idades de todos os períodos
    final combinedAgeData = <String, int>{
      '16-20': 0,
      '21-25': 0,
      '26-30': 0,
      '30+': 0,
    };

    data.ageDistribution.forEach((_, ageMap) {
      ageMap.forEach((ageRange, count) {
        combinedAgeData[ageRange] = combinedAgeData[ageRange]! + count;
      });
    });

    final total = combinedAgeData.values.reduce((a, b) => a + b).toDouble();

    return List.generate(combinedAgeData.length, (i) {
      final isTouched = i == touchedIndex;
      final fontSize = isTouched ? 25.0 : 14.0;
      final radius = isTouched ? 60.0 : 50.0;
      const shadows = [Shadow(color: Colors.black, blurRadius: 2)];

      final entry = combinedAgeData.entries.elementAt(i);
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

class Indicator extends StatelessWidget {
  const Indicator({
    super.key,
    required this.color,
    required this.text,
    required this.isSquare,
    this.size = 16,
    this.textColor = Colors.white70,
  });
  final Color color;
  final String text;
  final bool isSquare;
  final double size;
  final Color? textColor;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Container(
          width: size,
          height: size,
          decoration: BoxDecoration(
            shape: isSquare ? BoxShape.rectangle : BoxShape.circle,
            color: color,
          ),
        ),
        const SizedBox(
          width: 4,
        ),
        Text(
          text,
          style: TextStyle(
            fontSize: 13,
            color: textColor,
          ),
        )
      ],
    );
  }
}
