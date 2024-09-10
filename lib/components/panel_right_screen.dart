import 'package:bi_ufcg/charts_column_sections/institucional_parameters_section/admission_section.dart';
import 'package:bi_ufcg/core/ui/styles/colors_app.dart';
import 'package:bi_ufcg/core/ui/styles/text_styles.dart';
import 'package:flutter/material.dart';

import '../core/ui/styles/app_padding.dart';

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
              child: SizedBox(
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
