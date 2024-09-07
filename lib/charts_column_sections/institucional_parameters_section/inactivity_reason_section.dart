import 'package:bi_ufcg/charts_column_sections/institucional_parameters_section/charts/bar_chart_inactivity_reasons.dart';
import 'package:bi_ufcg/charts_column_sections/institucional_parameters_section/charts/line_chart_inactivity_reasons.dart';
import 'package:bi_ufcg/charts_column_sections/institucional_parameters_section/charts/pie_chart_inactivity_reasons.dart';
import 'package:bi_ufcg/core/ui/styles/colors_app.dart';
import 'package:bi_ufcg/core/ui/styles/text_styles.dart';
import 'package:flutter/material.dart';

class InactivityReasonSection extends StatefulWidget {
  const InactivityReasonSection({super.key});

  @override
  State<InactivityReasonSection> createState() =>
      _InactivityReasonSectionState();
}

class _InactivityReasonSectionState extends State<InactivityReasonSection> {
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
                child: Text('Motivos de Inatividade',
                    style: context.textStyles.textTitleChart),
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
                    ? const BarChartInactivityReasons()
                    : selectedChartIndex == 1
                        ? const PieChartInactivityReasons()
                        : const LineChartInactivityReasonsDistribution(), // Substitua com seu novo widget
              ),
            ],
          ),
        ),
      ),
    );
  }
}
