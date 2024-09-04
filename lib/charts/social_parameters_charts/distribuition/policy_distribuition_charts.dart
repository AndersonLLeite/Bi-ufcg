import 'package:bi_ufcg/charts/social_parameters_charts/chart/bar_chart_affirmative_policy_distribuition.dart';
import 'package:bi_ufcg/charts/social_parameters_charts/chart/line_chart_affirmative_policy_distribuition.dart';
import 'package:bi_ufcg/charts/social_parameters_charts/chart/pie_chart_affirmative_policy_distribution.dart';
import 'package:bi_ufcg/core/ui/styles/text_styles.dart';
import 'package:bi_ufcg/resource/app_colors.dart';
import 'package:bi_ufcg/service/data/data.dart';
import 'package:bi_ufcg/widgets/widget_no_data.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PolicyDistribuitionCharts extends StatefulWidget {
  const PolicyDistribuitionCharts({super.key});

  @override
  State<PolicyDistribuitionCharts> createState() =>
      _PolicyDistribuitionChartsState();
}

class _PolicyDistribuitionChartsState extends State<PolicyDistribuitionCharts> {
  int selectedChartIndex = 0; // 0: LineChart, 1: BarChart, 2: OutroChart

  @override
  Widget build(BuildContext context) {
    final data = Provider.of<Data>(context);

    if (data.affirmativePolicyDistribution.isEmpty) {
      return const WidgetNoData(); // Mostra o widget de "sem dados"
    }

    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Card(
        color: AppColors.purpleLight,
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
                  selectedChartIndex == 2 ? 'Evolução' : 'Distribuição',
                  style: TextStyles.instance.textSubtitleChart,
                ),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      icon: Icon(
                        Icons.bar_chart,
                        color: selectedChartIndex == 0
                            ? AppColors.chartIconSelectedColor
                            : AppColors.chartIconUnselectedColor,
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
                            ? AppColors.chartIconSelectedColor
                            : AppColors.chartIconUnselectedColor,
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
                            ? AppColors.chartIconSelectedColor
                            : AppColors.chartIconUnselectedColor,
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
