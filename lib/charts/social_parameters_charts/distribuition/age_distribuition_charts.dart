import 'package:bi_ufcg/charts/social_parameters_charts/chart/line_chart_age_distribuition.dart';
import 'package:bi_ufcg/core/ui/styles/text_styles.dart';
import 'package:bi_ufcg/resource/app_colors.dart';
import 'package:bi_ufcg/service/data/data.dart';
import 'package:bi_ufcg/widgets/widget_no_data.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../chart/pie_chart_age.dart';

class AgeDistributionCharts extends StatefulWidget {
  const AgeDistributionCharts({super.key});

  @override
  _AgeDistributionChartsState createState() => _AgeDistributionChartsState();
}

class _AgeDistributionChartsState extends State<AgeDistributionCharts> {
  bool showLineChart = false; // Controla a exibição entre LineChart e PieChart

  @override
  Widget build(BuildContext context) {
    final data = Provider.of<Data>(context);

    if (data.ageDistribution.isEmpty) {
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
                child: Text(
                  'Idade',
                  style: TextStyles.instance.textTitleChart,
                ),
              ),
              ListTile(
                title: Text(
                  showLineChart
                      ? 'Distribuição da idade ao longo dos períodos'
                      : 'Distribuição de idade',
                  style: TextStyles.instance.textSubtitleChart,
                ),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      icon: Icon(
                        Icons.pie_chart,
                        color: !showLineChart
                            ? AppColors.chartIconSelectedColor
                            : AppColors.chartIconUnselectedColor,
                      ),
                      onPressed: () {
                        setState(() {
                          showLineChart = false; // Alterna para PieChart
                        });
                      },
                    ),
                    IconButton(
                      icon: Icon(
                        Icons.show_chart,
                        color: showLineChart
                            ? AppColors.chartIconSelectedColor
                            : AppColors.chartIconUnselectedColor,
                      ),
                      onPressed: () {
                        setState(() {
                          showLineChart = true; // Alterna para LineChart
                        });
                      },
                    ),
                  ],
                ),
              ),
              Expanded(
                child:
                    !showLineChart ? PieChartAge() : LineChartAgeDistribution(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
