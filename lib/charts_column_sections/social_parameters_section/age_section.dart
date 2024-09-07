import 'package:bi_ufcg/charts_column_sections/social_parameters_section/charts/line_chart_age_distribuition.dart';
import 'package:bi_ufcg/core/ui/styles/colors_app.dart';
import 'package:bi_ufcg/core/ui/styles/text_styles.dart';
import 'package:bi_ufcg/service/data/data.dart';
import 'package:bi_ufcg/widgets/widget_no_data.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'charts/pie_chart_age.dart';

class AgeSection extends StatefulWidget {
  const AgeSection({super.key});

  @override
  State<AgeSection> createState() => _AgeSectionState();
}

class _AgeSectionState extends State<AgeSection> {
  bool showLineChart = false; // Controla a exibição entre LineChart e PieChart

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
                child: Text(
                  'Idade',
                  style: TextStyles.instance.textTitleChart,
                ),
              ),
              ListTile(
                title: Text(
                  showLineChart ? 'Evolução' : 'Distribuição',
                  style: TextStyles.instance.textSubtitleChart,
                ),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      icon: Icon(
                        Icons.pie_chart,
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
                    IconButton(
                      icon: Icon(
                        Icons.show_chart,
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
