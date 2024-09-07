import 'package:bi_ufcg/charts_column_sections/bar_chart_evasion.dart';
import 'package:bi_ufcg/charts_column_sections/institucional_parameters_section/admission_section.dart';
import 'package:bi_ufcg/charts_column_sections/institucional_parameters_section/inactivity_reason_section.dart';
import 'package:bi_ufcg/charts_column_sections/institucional_parameters_section/status_section.dart';
import 'package:bi_ufcg/core/ui/styles/colors_app.dart';
import 'package:bi_ufcg/core/ui/styles/text_styles.dart';
import 'package:flutter/material.dart';

import '../core/ui/styles/app_padding.dart';
import '../charts_column_sections/charts.dart';

class Product {
  String name;
  bool enable;
  Product({this.enable = true, required this.name});
}

class PanelRightScreen extends StatefulWidget {
  const PanelRightScreen({super.key});

  @override
  State<PanelRightScreen> createState() => _PanelRightScreenState();
}

class _PanelRightScreenState extends State<PanelRightScreen> {
  final List<Product> _products = [
    Product(name: "LED Submersible Lights", enable: true),
    Product(name: "Portable Projector", enable: true),
    Product(name: "Bluetooth Speaker", enable: true),
    Product(name: "Smart Watch", enable: true),
    Product(name: "Temporary Tattoos", enable: true),
    Product(name: "Bookends", enable: true),
    Product(name: "Vegetable Chopper", enable: true),
    Product(name: "Neck Massager", enable: true),
    Product(name: "Facial Cleanser", enable: true),
    Product(name: "Back Cushion", enable: true),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(children: [
          Padding(
            padding: const EdgeInsets.only(
                left: AppPadding.P10 / 2,
                top: AppPadding.P10 / 2,
                right: AppPadding.P10 / 2),
            child: Card(
              color: context.colors.panelColor,
              elevation: 3,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(50),
              ),
              child: Container(
                width: double.infinity,
                child: ListTile(
                  title: Text(
                    "Estatisticas por Periodo",
                    style: context.textStyles.title,
                  ),
                  subtitle: Text(
                    "estatisticas",
                    style: context.textStyles.subtitle,
                  ),
                ),
              ),
            ),
          ),
          const AdmissionSection()
        ]),
      ),
    );
  }
}
