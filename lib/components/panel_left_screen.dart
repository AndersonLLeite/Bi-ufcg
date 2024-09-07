import 'package:bi_ufcg/charts_column_sections/institucional_parameters_section/admission_section.dart';
import 'package:bi_ufcg/charts_column_sections/institucional_parameters_section/inactivity_reason_section.dart';
import 'package:bi_ufcg/charts_column_sections/institucional_parameters_section/secondary_school_section.dart';
import 'package:bi_ufcg/charts_column_sections/institucional_parameters_section/status_section.dart';
import 'package:bi_ufcg/core/ui/styles/colors_app.dart';
import 'package:bi_ufcg/core/ui/styles/text_styles.dart';
import 'package:flutter/material.dart';

import '../core/ui/styles/app_padding.dart';
import '../charts_column_sections/charts.dart';
import '../charts_column_sections/pie_chart.dart';
import '../core/ui/styles/responsive_layout.dart';

class Todo {
  String name;
  bool enable;
  Todo({this.enable = true, required this.name});
}

class PanelLeftScreen extends StatefulWidget {
  const PanelLeftScreen({super.key});

  @override
  State<PanelLeftScreen> createState() => _PanelLeftScreenState();
}

class _PanelLeftScreenState extends State<PanelLeftScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          if (ResponsiveLayout.isComputer(context))
            Container(
              color: context.colors.panelColor,
              width: 50,
              child: Container(
                decoration: BoxDecoration(
                  color: context.colors.titleSectioColor,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(50),
                  ),
                ),
              ),
            ),
          SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                      left: AppPadding.P10 / 2,
                      top: AppPadding.P10 / 2,
                      right: AppPadding.P10 / 2),
                  child: Card(
                    color: context.colors.primary,
                    elevation: 3,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50),
                    ),
                    child: SizedBox(
                      width: double.infinity,
                      child: ListTile(
                        title: Text(
                          "Perfil institucional",
                          style: context.textStyles.title,
                        ),
                        subtitle: Text(
                          "Estatísticas de Perfil Acadêmico e Institucional",
                          style: context.textStyles.subtitle,
                        ),
                      ),
                    ),
                  ),
                ),
                const StatusSection(),
                const InactivityReasonSection(),
                const AdmissionSection(),
                const SecondarySchoolSection(),
              ],
            ),
          )
        ],
      ),
    );
  }
}
