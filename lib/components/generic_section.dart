import 'package:bi_ufcg/components/charts/generic_bar_chart.dart';
import 'package:bi_ufcg/components/charts/generic_bar_chart_grouped.dart';
import 'package:bi_ufcg/components/charts/generic_line_chart.dart';
import 'package:bi_ufcg/components/charts/generic_pie_chart.dart';
import 'package:bi_ufcg/core/ui/styles/colors_app.dart';
import 'package:bi_ufcg/core/ui/styles/text_styles.dart';
import 'package:bi_ufcg/service/data/data.dart';
import 'package:flutter/material.dart';

class GenericSection extends StatefulWidget {
  final Map<String, Map<String, int>> dataMap;
  final String title;
  final bool isBarChartGrouped;
  final String?
      infoMessage; // Nova string opcional para a mensagem de informação

  const GenericSection({
    super.key,
    required this.dataMap,
    required this.title,
    this.isBarChartGrouped = false,
    this.infoMessage, // Inicializando a string opcional
  });

  @override
  State<GenericSection> createState() => _GenericSectionState();
}

class _GenericSectionState extends State<GenericSection> {
  int selectedChartIndex = 0; // 0: LineChart, 1: BarChart, 2: OutroChart

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
              child: Text('Fechar', style: TextStyle(color: Colors.blue)),
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
                    ? widget.isBarChartGrouped
                        ? GenericBarChartGrouped(dataMap: widget.dataMap)
                        : GenericBarChart(dataMap: widget.dataMap)
                    : selectedChartIndex == 1
                        ? GenericPieChart(dataMap: widget.dataMap)
                        : GenericLineChart(dataMap: widget.dataMap),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
