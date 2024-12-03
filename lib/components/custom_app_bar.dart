import 'package:bi_ufcg/domain/models/centro.dart';
import 'package:bi_ufcg/domain/models/curso.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../shared/ui/styles/app_padding.dart';
import '../../../shared/ui/styles/colors_app.dart';
import '../../../shared/ui/styles/responsive_layout.dart';
import '../../../service/data_service/data.dart';
import '../domain/models/campus.dart';
import '../domain/models/filter_data.dart';

class FilterAppBar extends StatefulWidget {
  final Function(FilterData) onFiltersChanged;

  const FilterAppBar({
    Key? key,
    required this.onFiltersChanged,
  }) : super(key: key);

  @override
  State<FilterAppBar> createState() => _FilterAppBarState();
}

class _FilterAppBarState extends State<FilterAppBar> {
  final Map<String, dynamic> _selectedFilters = {
    "campus": <Campus>[],
    "centros": <Centro>[],
    "cursos": <Curso>[],
    "startTerm": null,
    "endTerm": null,
  };

  final Map<String, bool> _isExpanded = {
    "campus": false,
    "centros": false,
    "cursos": false,
  };

  void _applyFilters() {
    final newFilter = FilterData(
      startTerm: _selectedFilters["startTerm"],
      endTerm: _selectedFilters["endTerm"],
      campus: _selectedFilters["campus"] as List<Campus>,
      centro: _selectedFilters["centros"] as List<Centro>,
      cursos: _selectedFilters["cursos"] as List<Curso>,
      terms: [], // Opcional, pode ser gerado com base no intervalo de períodos
    );

    widget.onFiltersChanged(newFilter);
  }

  void _clearFilters() {
    setState(() {
      _selectedFilters.forEach((key, value) {
        if (value is List) {
          value.clear(); // Limpa as listas de filtros selecionados
        } else {
          _selectedFilters[key] = null; // Reseta os filtros de valor único
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final data = Provider.of<Data>(context);

    return Container(
      color: context.colors.appBarColor,
      padding: const EdgeInsets.symmetric(horizontal: AppPadding.P10),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // _buildLogoRow(context),
          const SizedBox(height: AppPadding.P10),
          _buildPeriodSelection(data.filter.terms ?? []),
          const SizedBox(height: AppPadding.P10),
          ..._buildExpandableSections(data),
          const SizedBox(height: AppPadding.P10),
          _buildActionButtons(),
          const SizedBox(height: AppPadding.P10),
          _buildSelectedFilters(),
          const SizedBox(height: 30),
        ],
      ),
    );
  }

  Widget _buildLogoRow(BuildContext context) {
    return Row(
      children: [
        if (!ResponsiveLayout.isPhoneLimit(context))
          Row(
            children: [
              const CircleAvatar(
                radius: 40,
                backgroundImage: AssetImage("assets/images/escudo-ufcg.png"),
              ),
              const SizedBox(width: AppPadding.P10),
              const CircleAvatar(
                radius: 40,
                backgroundImage: AssetImage("assets/images/logo1-eureca.png"),
              ),
            ],
          ),
      ],
    );
  }

  Widget _buildPeriodSelection(List<String> terms) {
    return Row(
      children: [
        Container(
          height: 100,
          width: 100,
          color: Colors.transparent,
          child: Image.asset(
            "assets/images/escudo-ufcg.png",
            fit: BoxFit.cover,
          ),
        ),
        const SizedBox(width: AppPadding.P10),
        Expanded(
          child: _buildDropdown(
            label: "Periodo Inicial",
            key: "startTerm",
            items: terms,
          ),
        ),
        const SizedBox(width: AppPadding.P10),
        Expanded(
          child: _buildDropdown(
            label: "Periodo Final",
            key: "endTerm",
            items: terms,
          ),
        ),
        const SizedBox(width: AppPadding.P10),
        Container(
          height: 100,
          width: 100,
          color: Colors.transparent,
          child: Image.asset(
            "assets/images/logo1-eureca.png",
            fit: BoxFit.cover,
          ),
        )
        // const CircleAvatar(
        //   backgroundColor: Colors.transparent,
        //   radius: 50,
        //   backgroundImage: AssetImage("assets/images/logo1-eureca.png"),
        // ),
      ],
    );
  }

  Widget _buildDropdown({
    required String label,
    required String key,
    required List<String> items,
  }) {
    return DropdownButtonFormField<String>(
      dropdownColor: Colors.white,
      value: _selectedFilters[key],
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
      items: items.map((item) {
        return DropdownMenuItem(
          value: item,
          child: Text(item), // Apenas o nome do termo
        );
      }).toList(),
      onChanged: (value) {
        setState(() {
          _selectedFilters[key] = value;
        });
      },
    );
  }

  List<Widget> _buildExpandableSections(Data data) {
    final Map<String, dynamic> filterOptions = {
      "campus": data.filter.campus ?? [],
      "centros": data.filter.centro ?? [],
      "cursos": data.filter.cursos ?? [],
    };

    return filterOptions.entries.map((entry) {
      final String key = entry.key;
      final List<dynamic> options = entry.value;

      return ExpansionPanelList(
        elevation: 1,
        expansionCallback: (int index, bool isExpanded) {
          setState(() {
            _isExpanded[key] = !isExpanded;
          });
        },
        children: [
          ExpansionPanel(
            backgroundColor: context.colors.quinary,
            isExpanded: _isExpanded[key]!,
            headerBuilder: (BuildContext context, bool isExpanded) {
              return ListTile(title: Text(key.toUpperCase()));
            },
            body: options.isEmpty
                ? const Padding(
                    padding: EdgeInsets.all(AppPadding.P10),
                    child: Text("No options available."),
                  )
                : Wrap(
                    spacing: 8,
                    children: options.map<Widget>((dynamic item) {
                      final name =
                          (item is Campus || item is Centro || item is Curso)
                              ? item.name + " (${item.id})"
                              : "Unknown";

                      return FilterChip(
                        disabledColor: context.colors.quaternary,
                        selectedColor: context.colors.tertiary,
                        label: Text(
                          name,
                          style: TextStyle(color: Colors.white),
                        ),
                        selected: _selectedFilters[key]!.contains(item),
                        onSelected: (bool selected) {
                          setState(() {
                            if (selected) {
                              _selectedFilters[key]!.add(item);
                            } else {
                              _selectedFilters[key]!.remove(item);
                            }
                          });
                        },
                      );
                    }).toList(),
                  ),
          ),
        ],
      );
    }).toList();
  }

  Widget _buildActionButtons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        ElevatedButton(
          onPressed: _clearFilters,
          child: const Text("Limpar Filtros"),
        ),
        const SizedBox(width: AppPadding.P10),
        ElevatedButton(
          onPressed: _selectAllFilters,
          child: const Text("Selecionar Tudo"),
        ),
        const Spacer(),
        ElevatedButton(
          onPressed: () {
            _applyFilters();
          },
          child: const Text("Filtrar"),
        ),
        Tooltip(
          message: "Exportar dados no formato CSV",
          child: IconButton(
            icon: const Icon(Icons.download, color: Colors.black),
            onPressed: () {
              // Lógica para exportar dados para CSV
            },
          ),
        ),
      ],
    );
  }

  Widget _buildSelectedFilters() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildFilterSection(
          title: "Campus",
          filters: _selectedFilters["campus"] as List<Campus>,
        ),
        const SizedBox(height: AppPadding.P10),
        _buildFilterSection(
          title: "Centros",
          filters: _selectedFilters["centros"] as List<Centro>,
        ),
        const SizedBox(height: AppPadding.P10),
        _buildFilterSection(
          title: "Cursos",
          filters: _selectedFilters["cursos"] as List<Curso>,
        ),
      ],
    );
  }

  Widget _buildFilterSection({
    required String title,
    required List<dynamic> filters,
  }) {
    if (filters.isEmpty) return const SizedBox();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: filters.map<Widget>((filter) {
            final name = filter.name;
            final id = filter.id;
            return Chip(
              deleteIconColor: Colors.red,
              backgroundColor: context.colors.tertiary,
              label: Text(
                '$name ($id)',
                style: TextStyle(color: Colors.white),
              ),
              onDeleted: () {
                setState(() {
                  filters.remove(filter); // Remove o filtro específico
                });
              },
            );
          }).toList(),
        ),
      ],
    );
  }

  void _selectAllFilters() {
    setState(() {
      final data = Provider.of<Data>(context, listen: false);

      // Fazendo cópias das listas em vez de referenciá-las diretamente
      _selectedFilters['campus'] = List<Campus>.from(data.filter.campus ?? []);
      _selectedFilters['centros'] = List<Centro>.from(data.filter.centro ?? []);
      _selectedFilters['cursos'] = List<Curso>.from(data.filter.cursos ?? []);

      // Atribuindo valores individuais diretamente
      _selectedFilters['startTerm'] = data.filter.terms?.first;
      _selectedFilters['endTerm'] = data.filter.terms?.last;
    });
  }
}
