import 'package:bi_ufcg/components/charts/bar_chart_distribuition.dart';
import 'package:bi_ufcg/components/charts/bar_chart_grouped.dart';
import 'package:bi_ufcg/components/charts/line_chart_distribuition.dart';
import 'package:bi_ufcg/components/charts/pie_chart_distribuition.dart';
import 'package:bi_ufcg/core/ui/styles/colors_app.dart';
import 'package:bi_ufcg/core/ui/styles/text_styles.dart';
import 'package:flutter/material.dart';

class ChartsSection extends StatefulWidget {
  final Map<String, Map<String, double>> dataMap;
  final String title;
  final bool isBarChartGrouped;
  final String? infoMessage;
  final bool showBarChart;
  final bool showPieChart;
  final bool showLineChart;

  const ChartsSection({
    super.key,
    required this.dataMap,
    required this.title,
    this.isBarChartGrouped = false,
    this.infoMessage,
    this.showBarChart = true,
    this.showPieChart = true,
    this.showLineChart = true,
  });

  @override
  State<ChartsSection> createState() => _ChartsSectionState();
}

class _ChartsSectionState extends State<ChartsSection> {
  int selectedChartIndex = 0; // 0: barchart, 1: piechart, 2: lineChart

  void _showInfoDialog(String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          title: Text('Informações', style: context.textStyles.titleInfo),
          content: Text(message, style: context.textStyles.textInfoSubtitle),
          actions: [
            TextButton(
              child: const Text('Fechar', style: TextStyle(color: Colors.blue)),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

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
          aspectRatio: 1.2,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 10, left: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(widget.title,
                        style: context.textStyles.textTitleChart),
                    const SizedBox(width: 5),
                    if (widget.infoMessage != null)
                      IconButton(
                        icon: Icon(Icons.info_outline,
                            color: context.colors.chartIconSelectedColor),
                        onPressed: () {
                          _showInfoDialog(widget.infoMessage!);
                        },
                      ),
                  ],
                ),
              ),
              if (widget.showBarChart ||
                  widget.showPieChart ||
                  widget.showLineChart)
                ListTile(
                  title: Text(
                    selectedChartIndex == 0
                        ? widget.isBarChartGrouped
                            ? 'Distribuição Agrupada'
                            : 'Distribuição Total'
                        : selectedChartIndex == 1
                            ? 'Distribuição'
                            : 'Evolução',
                    style: TextStyles.instance.textSubtitleChart,
                  ),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      if (widget.showBarChart)
                        IconButton(
                          icon: Icon(
                            Icons.bar_chart,
                            color: selectedChartIndex == 0
                                ? context.colors.chartIconSelectedColor
                                : context.colors.chartIconUnselectedColor,
                          ),
                          onPressed: () {
                            setState(() {
                              selectedChartIndex = 0;
                            });
                          },
                        ),
                      if (widget.showPieChart)
                        IconButton(
                          icon: Icon(
                            Icons.pie_chart,
                            color: selectedChartIndex == 1
                                ? context.colors.chartIconSelectedColor
                                : context.colors.chartIconUnselectedColor,
                          ),
                          onPressed: () {
                            setState(() {
                              selectedChartIndex = 1;
                            });
                          },
                        ),
                      if (widget.showLineChart)
                        IconButton(
                          icon: Icon(
                            Icons.show_chart,
                            color: selectedChartIndex == 2
                                ? context.colors.chartIconSelectedColor
                                : context.colors.chartIconUnselectedColor,
                          ),
                          onPressed: () {
                            setState(() {
                              selectedChartIndex = 2;
                            });
                          },
                        ),
                    ],
                  ),
                ),
              Expanded(
                child: selectedChartIndex == 0
                    ? widget.isBarChartGrouped
                        ? BarChartGrouped(dataMap: widget.dataMap)
                        : BarChartDistribuition(dataMap: widget.dataMap)
                    : selectedChartIndex == 1
                        ? PieChartDistribuition(dataMap: widget.dataMap)
                        : LineChartDistribuition(dataMap: widget.dataMap),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
