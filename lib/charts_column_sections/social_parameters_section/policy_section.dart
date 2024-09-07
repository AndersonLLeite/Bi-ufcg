import 'package:bi_ufcg/charts_column_sections/social_parameters_section/charts/bar_chart_affirmative_policy_distribuition.dart';
import 'package:bi_ufcg/charts_column_sections/social_parameters_section/charts/line_chart_affirmative_policy_distribuition.dart';
import 'package:bi_ufcg/charts_column_sections/social_parameters_section/charts/pie_chart_affirmative_policy_distribution.dart';
import 'package:bi_ufcg/core/ui/styles/colors_app.dart';
import 'package:bi_ufcg/core/ui/styles/text_styles.dart';
import 'package:bi_ufcg/service/data/data.dart';
import 'package:bi_ufcg/widgets/widget_no_data.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PolicySection extends StatefulWidget {
  const PolicySection({super.key});

  @override
  State<PolicySection> createState() => _PolicySectionState();
}

class _PolicySectionState extends State<PolicySection> {
  int selectedChartIndex = 0; // 0: LineChart, 1: BarChart, 2: OutroChart

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Card(
        color: context.colors.distribuitionCardColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        elevation: 3,
        child: AspectRatio(
          aspectRatio: 0.8,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(2.0),
                child: Text('Políticas Afirmativas',
                    style: TextStyles.instance.textTitleChart),
              ),
              ListTile(
                title: Text(
                  selectedChartIndex == 0
                      ? 'Distribuição Total'
                      : selectedChartIndex == 1
                          ? 'Distribuição'
                          : 'Evolução',
                  style: TextStyles.instance.textSubtitleChart,
                ),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      icon: Icon(
                        Icons.bar_chart,
                        color: selectedChartIndex == 0
                            ? context.colors.chartIconSelectedColor
                            : context.colors.chartIconUnselectedColor,
                      ),
                      onPressed: () {
                        setState(() {
                          selectedChartIndex = 0; // Alterna para BarChart
                        });
                      },
                    ),
                    IconButton(
                      icon: Icon(
                        Icons.pie_chart,
                        color: selectedChartIndex == 1
                            ? context.colors.chartIconSelectedColor
                            : context.colors.chartIconUnselectedColor,
                      ),
                      onPressed: () {
                        setState(() {
                          selectedChartIndex = 1; // Alterna para OutroChart
                        });
                      },
                    ),
                    IconButton(
                      icon: Icon(
                        Icons.show_chart,
                        color: selectedChartIndex == 2
                            ? context.colors.chartIconSelectedColor
                            : context.colors.chartIconUnselectedColor,
                      ),
                      onPressed: () {
                        setState(() {
                          selectedChartIndex = 2; // Alterna para LineChart
                        });
                      },
                    ),
                  ],
                ),
              ),
              Expanded(
                child: selectedChartIndex == 0
                    ? BarChartAffirmativePolicyDistribution()
                    : selectedChartIndex == 1
                        ? PieChartAffirmativePolicyDistribution()
                        : LineChartAffirmativePolicyEvolution(), // Substitua com seu novo widget
              ),
            ],
          ),
        ),
      ),
    );
  }
}
