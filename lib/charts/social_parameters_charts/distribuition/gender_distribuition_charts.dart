import 'package:bi_ufcg/charts/social_parameters_charts/chart/bar_chart_grouped_gender.dart';
import 'package:bi_ufcg/charts/social_parameters_charts/chart/line_chart_gender_distribuition.dart';
import 'package:bi_ufcg/core/ui/styles/text_styles.dart';
import 'package:bi_ufcg/resource/app_colors.dart';
import 'package:bi_ufcg/service/data/data.dart';
import 'package:bi_ufcg/widgets/widget_no_data.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class GenderDistribuitionCharts extends StatefulWidget {
  const GenderDistribuitionCharts({super.key});

  @override
  State<GenderDistribuitionCharts> createState() =>
      _GenderDistribuitionChartsState();
}

class _GenderDistribuitionChartsState extends State<GenderDistribuitionCharts> {
  bool showLineChart = true; // Controla a exibição entre LineChart e PieChart

  @override
  Widget build(BuildContext context) {
    final data = Provider.of<Data>(context);

    if (data.genderDistribution.isEmpty) {
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
                child:
                    Text('Gênero', style: TextStyles.instance.textTitleChart),
              ),
              ListTile(
                title: showLineChart
                    ? Text.rich(
                        TextSpan(
                          children: <TextSpan>[
                            TextSpan(
                              text: 'Masculino',
                              style: TextStyle(
                                color: AppColors.maleColor,
                                fontSize: 16,
                              ),
                            ),
                            TextSpan(
                              text: ' E ',
                              style: TextStyle(
                                color: Color(0xff77839a),
                                fontSize: 16,
                              ),
                            ),
                            TextSpan(
                              text: 'Feminino',
                              style: TextStyle(
                                color: AppColors.femaleColor,
                                fontSize: 16,
                              ),
                            ),
                          ],
                        ),
                      )
                    : Text(
                        'Distribuição do gênero ao longo dos periodos',
                        style: TextStyles.instance.textSubtitleChart,
                      ),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      icon: Icon(
                        Icons.bar_chart,
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
                    IconButton(
                      icon: Icon(
                        Icons.show_chart,
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
                  ],
                ),
              ),
              Expanded(
                child: showLineChart
                    ? BarChartGroupedGender()
                    : LineChartGenderDistribution(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
