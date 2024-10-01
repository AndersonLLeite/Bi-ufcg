import 'package:bi_ufcg/shared/ui/styles/colors_app.dart';
import 'package:bi_ufcg/shared/widgets/widget_no_data.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class LineChartDistribuition extends StatefulWidget {
  final Map<String, Map<String, double>> dataMap; // Dados no formato genérico

  const LineChartDistribuition({
    Key? key,
    required this.dataMap,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _LineChartDistribuitionState();
}

class _LineChartDistribuitionState extends State<LineChartDistribuition> {
  bool isCurved = true;
  late Map<String, bool>
      selectedCategories; // Mapa para armazenar a seleção dos itens da legenda

  @override
  void initState() {
    super.initState();
    // Inicialmente, todos os itens da legenda estarão selecionados
    selectedCategories = {
      for (var category
          in widget.dataMap.values.expand((map) => map.keys).toSet())
        category: true
    };
  }

  @override
  Widget build(BuildContext context) {
    if (widget.dataMap.isEmpty) {
      return const WidgetNoData();
    }

    final periods = widget.dataMap.keys.toList()
      ..sort((a, b) => double.parse(a).compareTo(double.parse(b)));

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: SingleChildScrollView(
        child: Column(
          children: [
            Column(
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Card(
                        color: context.colors.chartCardColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        elevation: 3,
                        child: AspectRatio(
                          aspectRatio: 1.6,
                          child: Padding(
                            padding: const EdgeInsets.all(16),
                            child: Column(
                              children: [
                                const SizedBox(height: 10),
                                Expanded(
                                  child: LineChart(
                                    _buildLineChartData(periods),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    IconButton(
                      icon: const Icon(
                        Icons.refresh,
                        color: Colors.grey,
                      ),
                      onPressed: () {
                        setState(() {
                          isCurved = !isCurved;
                        });
                      },
                    ),
                  ],
                ),
              ],
            ),
            _buildLegend(),
          ],
        ),
      ),
    );
  }

  Widget _buildLegend() {
    final categories =
        widget.dataMap.values.expand((map) => map.keys).toSet().toList();

    return Wrap(
      alignment: WrapAlignment.center,
      spacing: 10,
      runSpacing: 10,
      children: List.generate(categories.length, (index) {
        final category = categories[index];
        final color = ColorsApp.getColorForIndex(index);
        final isSelected = selectedCategories[category] ??
            true; // Verifica se o item está selecionado

        return GestureDetector(
          onTap: () {
            setState(() {
              // Alterna o estado de seleção do item ao clicar
              selectedCategories[category] =
                  !(selectedCategories[category] ?? true);
            });
          },
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 12,
                height: 12,
                decoration: BoxDecoration(
                  color: isSelected
                      ? color
                      : color.withOpacity(0.3), // Cor opaca se desmarcado
                  shape: BoxShape.circle,
                  border: isSelected
                      ? Border.all(
                          color: Colors.white,
                          width: 2) // Marca selecionada com borda
                      : null,
                ),
              ),
              const SizedBox(width: 5),
              Text(
                category,
                style: const TextStyle(
                  fontSize: 12,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        );
      }),
    );
  }

  LineChartData _buildLineChartData(List<String> periods) {
    return LineChartData(
      gridData: FlGridData(
        show: true,
        horizontalInterval: 1,
        verticalInterval: 10,
        getDrawingHorizontalLine: (value) => FlLine(
          color: Colors.grey.withOpacity(0.2),
          strokeWidth: 1,
        ),
        getDrawingVerticalLine: (value) => FlLine(
          color: Colors.grey.withOpacity(0.2),
          strokeWidth: 1,
        ),
      ),
      titlesData: FlTitlesData(
        topTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: false, // Remover título superior
          ),
        ),
        rightTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: false, // Remover título direito
          ),
        ),
        bottomTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true, // Título inferior
            reservedSize: 38,
            getTitlesWidget: (value, meta) {
              final index = value.toInt();
              if (index < periods.length) {
                return SideTitleWidget(
                  axisSide: meta.axisSide,
                  child: Text(
                    periods[index],
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 11,
                    ),
                  ),
                );
              }
              return const SizedBox.shrink();
            },
          ),
        ),
        leftTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true, // Título esquerdo
            reservedSize: 40,
            getTitlesWidget: (value, meta) {
              return Text(
                value.toInt().toString(),
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              );
            },
          ),
        ),
      ),
      borderData: FlBorderData(
        show: true,
        border: Border.all(
          color: Colors.grey.withOpacity(0.5),
          width: 1,
        ),
      ),
      lineBarsData: _generateLineBars(periods),
      lineTouchData: LineTouchData(
        touchTooltipData: LineTouchTooltipData(
          tooltipBgColor: Colors.white,
          tooltipPadding:
              const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          tooltipRoundedRadius: 8,
          showOnTopOfTheChartBoxArea: true,
          fitInsideHorizontally: true,
          fitInsideVertically: true,
          maxContentWidth: 270, // Define um limite máximo de largura
          getTooltipItems: (touchedBarSpots) {
            bool periodShown = false;

            return touchedBarSpots.map((spot) {
              final periodIndex = spot.x.toInt();
              final period = periods[periodIndex];

              // Encontra a categoria correspondente ao ponto tocado
              final category = widget.dataMap[period]!.entries.firstWhere(
                (entry) {
                  final categoryIndex =
                      _getCategoryIndex(entry.key, widget.dataMap);
                  final spotColor = ColorsApp.getColorForIndex(categoryIndex);
                  return entry.value == spot.y && spotColor == spot.bar.color;
                },
                orElse: () => const MapEntry('Unknown', 0.0),
              ).key;

              final color = ColorsApp.getColorForIndex(
                _getCategoryIndex(category, widget.dataMap),
              );

              List<TextSpan> children = [];
              if (!periodShown) {
                children.add(
                  TextSpan(
                    text: '$period\n',
                    style: const TextStyle(
                      color: Colors.grey,
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                    ),
                  ),
                );
                periodShown = true;
              }

              // Formatação do valor
              String formattedValue = spot.y % 1 == 0
                  ? spot.y
                      .toInt()
                      .toString() // Sem casas decimais se for inteiro
                  : spot.y.toStringAsFixed(
                      2); // Com uma casa decimal se for quebrado

              children.add(
                TextSpan(
                  text: '$category:  $formattedValue',
                  style: TextStyle(
                    color: color,
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
                  ),
                ),
              );

              return LineTooltipItem(
                '', // Texto principal vazio
                const TextStyle(),
                children: children,
              );
            }).toList();
          },
          tooltipMargin: 16, // Distância do tooltip para os pontos
        ),
      ),
    );
  }

  List<LineChartBarData> _generateLineBars(List<String> periods) {
    final categoryData = <String, List<FlSpot>>{};

    // Adiciona pontos para as categorias selecionadas
    for (var i = 0; i < periods.length; i++) {
      final period = periods[i];
      final categoryMap = widget.dataMap[period]!;

      categoryMap.forEach((category, count) {
        if (selectedCategories[category] ?? true) {
          final existingSpots = categoryData.putIfAbsent(category, () => []);
          if (!existingSpots
              .any((spot) => spot.x == i.toDouble() && spot.y == count)) {
            existingSpots.add(FlSpot(i.toDouble(), count));
          }
        }
      });
    }

    return categoryData.entries.map((entry) {
      final index = _getCategoryIndex(entry.key, widget.dataMap);
      final color = ColorsApp.getColorForIndex(index);
      return LineChartBarData(
        spots: entry.value,
        isCurved: isCurved,
        color: color,
        belowBarData: BarAreaData(show: false),
        dotData: FlDotData(show: true),
        aboveBarData: BarAreaData(show: false),
      );
    }).toList();
  }

  int _getCategoryIndex(
      String category, Map<String, Map<String, double>> dataMap) {
    // Determina o índice da categoria baseado nos dados disponíveis
    return dataMap.values
        .expand((map) => map.keys)
        .toSet()
        .toList()
        .indexOf(category);
  }
}
