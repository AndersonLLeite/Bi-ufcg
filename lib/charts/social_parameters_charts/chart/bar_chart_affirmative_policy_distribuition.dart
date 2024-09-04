import 'package:bi_ufcg/resource/app_colors.dart';
import 'package:bi_ufcg/service/data/data.dart';
import 'package:bi_ufcg/widgets/widget_no_data.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BarChartAffirmativePolicyDistribution extends StatefulWidget {
  const BarChartAffirmativePolicyDistribution({super.key});

  @override
  State<StatefulWidget> createState() =>
      BarChartAffirmativePolicyDistributionState();
}

class BarChartAffirmativePolicyDistributionState
    extends State<BarChartAffirmativePolicyDistribution> {
  int touchedGroupIndex = -1;

  @override
  Widget build(BuildContext context) {
    final data = Provider.of<Data>(context);

    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 700),
      switchInCurve: Curves.easeInOut,
      switchOutCurve: Curves.easeInOut,
      child: data.affirmativePolicyDistribution.isEmpty
          ? const WidgetNoData()
          : Card(
              key: const ValueKey('chart'),
              color: AppColors.purpleLight,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              elevation: 3,
              child: AspectRatio(
                aspectRatio: 0.9,
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      const SizedBox(height: 8),
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
                                      final policyNames = _getPolicyNames(data);
                                      final index = value.toInt();
                                      return SideTitleWidget(
                                        axisSide: meta.axisSide,
                                        child: Text(
                                          policyNames[index],
                                          style: TextStyle(
                                            color: touchedGroupIndex == index
                                                ? Colors.white
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
                              barGroups: _generateBarGroups(data),
                              maxY: _getMaxY(data) + 10,
                              barTouchData: BarTouchData(
                                enabled: true,
                                touchTooltipData: BarTouchTooltipData(
                                  tooltipBgColor: Colors.black87,
                                  getTooltipItem:
                                      (group, groupIndex, rod, rodIndex) {
                                    final policyNames = _getPolicyNames(data);
                                    final policyName =
                                        policyNames[groupIndex] == "BN"
                                            ? "BONUS"
                                            : policyNames[groupIndex];
                                    final value = rod.toY;
                                    return BarTooltipItem(
                                      '$policyName\n$value',
                                      TextStyle(
                                        color: rod.color,
                                        fontWeight: FontWeight.bold,
                                      ),
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
                                    });
                                  } else {
                                    setState(() {
                                      touchedGroupIndex = -1;
                                    });
                                  }
                                },
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 12),
                    ],
                  ),
                ),
              ),
            ),
    );
  }

  // Gera os grupos de barras para o gráfico
  List<BarChartGroupData> _generateBarGroups(Data data) {
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

    // Organiza as políticas em ordem decrescente
    final sortedPolicies = combinedPolicyData.entries.toList()
      ..sort(
          (a, b) => b.value.compareTo(a.value)); // Ordena em ordem decrescente

    return List.generate(sortedPolicies.length, (index) {
      final entry = sortedPolicies[index];
      return BarChartGroupData(
        x: index,
        barRods: [
          BarChartRodData(
            toY: entry.value.toDouble(),
            color: _getColorForPolicy(
                entry.key), // Cor dinâmica para cada política
            width: 10,
          ),
        ],
        showingTooltipIndicators: touchedGroupIndex == index ? [0] : [],
      );
    });
  }

  // Método para definir a cor de acordo com a política
  Color _getColorForPolicy(String policy) {
    // Você pode adicionar lógica aqui para definir cores específicas para políticas, se necessário
    // Para exemplo, retornando uma cor aleatória
    return Colors.primaries[(policy.hashCode + 100) % Colors.primaries.length];
  }

  // Obter o valor máximo para o eixo Y
  double _getMaxY(Data data) {
    final combinedPolicyData = <String, int>{};

    data.affirmativePolicyDistribution.forEach((_, policyMap) {
      policyMap.forEach((policy, count) {
        if (combinedPolicyData.containsKey(policy)) {
          combinedPolicyData[policy] = combinedPolicyData[policy]! + count;
        } else {
          combinedPolicyData[policy] = count;
        }
      });
    });

    return combinedPolicyData.values
        .fold(0, (a, b) => a > b ? a : b)
        .toDouble();
  }

  // Método para obter os nomes das políticas, substituindo BONUS por BN
  List<String> _getPolicyNames(Data data) {
    final combinedPolicyData = <String, int>{};

    data.affirmativePolicyDistribution.forEach((_, policyMap) {
      policyMap.forEach((policy, count) {
        if (combinedPolicyData.containsKey(policy)) {
          combinedPolicyData[policy] = combinedPolicyData[policy]! + count;
        } else {
          combinedPolicyData[policy] = count;
        }
      });
    });

    // Organiza os nomes em ordem decrescente com base nos valores
    final sortedPolicies = combinedPolicyData.entries.toList()
      ..sort(
          (a, b) => b.value.compareTo(a.value)); // Ordena em ordem decrescente

    return sortedPolicies
        .map((entry) => entry.key == 'BONUS' ? 'BN' : entry.key)
        .toList();
  }
}
