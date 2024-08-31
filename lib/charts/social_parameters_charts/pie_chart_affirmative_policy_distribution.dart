import 'package:bi_ufcg/resource/app_colors.dart';
import 'package:bi_ufcg/service/data/data.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PieChartAffirmativePolicyDistribution extends StatefulWidget {
  const PieChartAffirmativePolicyDistribution({super.key});

  @override
  State<StatefulWidget> createState() =>
      _PieChartAffirmativePolicyDistributionState();
}

class _PieChartAffirmativePolicyDistributionState
    extends State<PieChartAffirmativePolicyDistribution> {
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
        child: data.affirmativePolicyDistribution.isEmpty
            ? Container(
                key: const ValueKey('no_data'),
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15),
                  boxShadow: const [
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
                    const SizedBox(height: 20),
                    Text(
                      'Nenhum dado disponível',
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey.shade700,
                      ),
                    ),
                    const SizedBox(height: 10),
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
                key: const ValueKey('chart'),
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
                        title: const Text(
                          "Distribuição por Política Afirmativa",
                          style: TextStyle(color: Colors.white),
                        ),
                        trailing: IconButton(
                          icon: Icon(
                            showPercentage ? Icons.show_chart : Icons.pie_chart,
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
                            children: _buildIndicators(data),
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

  // Cria as seções do gráfico de pizza
  List<PieChartSectionData> showingSections(Data data) {
    final combinedPolicyData = <String, int>{};

    // Combina todas as políticas afirmativas de todos os períodos
    data.affirmativePolicyDistribution.forEach((_, policyMap) {
      policyMap.forEach((policy, count) {
        if (combinedPolicyData.containsKey(policy)) {
          combinedPolicyData[policy] = combinedPolicyData[policy]! + count;
        } else {
          combinedPolicyData[policy] = count;
        }
      });
    });

    final total = combinedPolicyData.values.reduce((a, b) => a + b).toDouble();

    return List.generate(combinedPolicyData.length, (i) {
      final isTouched = i == touchedIndex;
      final fontSize = isTouched ? 40.0 : 14.0;
      final radius = isTouched ? 80.0 : 50.0;
      const shadows = [Shadow(color: Colors.black, blurRadius: 2)];

      final entry = combinedPolicyData.entries.elementAt(i);
      final percentage = (entry.value / total) * 100;

      return PieChartSectionData(
        color: _getColorForPolicy(entry.key), // Utiliza a mesma lógica de cores
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

  // Utiliza a mesma função para obter cores
  Color _getColorForPolicy(String policy) {
    return Colors.primaries[(policy.hashCode + 100) % Colors.primaries.length];
  }

  // Constrói os indicadores dinamicamente
  List<Widget> _buildIndicators(Data data) {
    final combinedPolicyData = <String, int>{};

    // Combina todas as políticas afirmativas de todos os períodos
    data.affirmativePolicyDistribution.forEach((_, policyMap) {
      policyMap.forEach((policy, count) {
        if (combinedPolicyData.containsKey(policy)) {
          combinedPolicyData[policy] = combinedPolicyData[policy]! + count;
        } else {
          combinedPolicyData[policy] = count;
        }
      });
    });

    return combinedPolicyData.keys.map((policy) {
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 4.0),
        child: Indicator(
          color: _getColorForPolicy(policy), // Utiliza a mesma lógica de cores
          text: policy,
          isSquare: true,
        ),
      );
    }).toList();
  }
}

class Indicator extends StatelessWidget {
  const Indicator({
    super.key,
    required this.color,
    required this.text,
    required this.isSquare,
    this.size = 20,
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
