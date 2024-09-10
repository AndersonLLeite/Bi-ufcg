import 'package:bi_ufcg/charts_column_sections/social_parameters_section/charts/bar_chart_grouped_gender.dart';
import 'package:bi_ufcg/charts_column_sections/social_parameters_section/charts/line_chart_gender_distribuition.dart';
import 'package:bi_ufcg/core/ui/styles/colors_app.dart';
import 'package:bi_ufcg/core/ui/styles/text_styles.dart';
import 'package:flutter/material.dart';

class GenderSection extends StatefulWidget {
  const GenderSection({super.key});

  @override
  State<GenderSection> createState() => _GenderSectionState();
}

class _GenderSectionState extends State<GenderSection> {
  bool showLineChart = true; // Controla a exibição entre LineChart e PieChart

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
                                color: context.colors.maleColor,
                                fontSize: 16,
                              ),
                            ),
                            const TextSpan(
                              text: ' E ',
                              style: TextStyle(
                                color: Color(0xff77839a),
                                fontSize: 16,
                              ),
                            ),
                            TextSpan(
                              text: 'Feminino',
                              style: TextStyle(
                                color: context.colors.femaleColor,
                                fontSize: 16,
                              ),
                            ),
                          ],
                        ),
                      )
                    : Text(
                        'Evolução',
                        style: TextStyles.instance.textSubtitleChart,
                      ),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      icon: Icon(
                        Icons.bar_chart,
                        color: showLineChart
                            ? context.colors.chartIconSelectedColor
                            : context.colors.chartIconUnselectedColor,
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
                            ? context.colors.chartIconSelectedColor
                            : context.colors.chartIconUnselectedColor,
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
                    ? const BarChartGroupedGender()
                    : const LineChartGenderDistribution(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
