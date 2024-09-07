import 'package:bi_ufcg/charts_column_sections/institucional_parameters_section/charts/bar_chart_grouped_status.dart';
import 'package:bi_ufcg/charts_column_sections/institucional_parameters_section/charts/line_chart_status_distribution.dart';
import 'package:bi_ufcg/charts_column_sections/institucional_parameters_section/charts/pie_chart_status.dart';
import 'package:bi_ufcg/core/ui/styles/colors_app.dart';
import 'package:bi_ufcg/core/ui/styles/text_styles.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class StatusSection extends StatefulWidget {
  const StatusSection({super.key});

  @override
  State<StatusSection> createState() => _StatusSectionState();
}

class _StatusSectionState extends State<StatusSection> {
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
                child: Text('Status da Matrícula',
                    style: context.textStyles.textTitleChart),
              ),
              ListTile(
                title: Text(
                  selectedChartIndex == 0
                      ? 'Distribuição Agrupada'
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
                    ? const BarChartGroupedStatus()
                    : selectedChartIndex == 1
                        ? const PieChartStatus()
                        : const LineChartStatusDistribution(), // Substitua com seu novo widget
              ),
            ],
          ),
        ),
      ),
    );
  }
}
