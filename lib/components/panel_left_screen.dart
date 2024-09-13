import 'package:bi_ufcg/components/generic_section.dart';
import 'package:bi_ufcg/charts_column_sections/institucional_parameters_section/admission_section.dart';
import 'package:bi_ufcg/charts_column_sections/institucional_parameters_section/inactivity_reason_section.dart';
import 'package:bi_ufcg/charts_column_sections/institucional_parameters_section/secondary_school_section.dart';
import 'package:bi_ufcg/charts_column_sections/institucional_parameters_section/status_section.dart';
import 'package:bi_ufcg/charts_column_sections/social_parameters_section/gender_section.dart';
import 'package:bi_ufcg/components/infoChartStrings.dart';
import 'package:bi_ufcg/core/ui/styles/colors_app.dart';
import 'package:bi_ufcg/core/ui/styles/text_styles.dart';
import 'package:bi_ufcg/service/data/data.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../core/ui/styles/app_padding.dart';
import '../core/ui/styles/responsive_layout.dart';

class PanelLeftScreen extends StatefulWidget {
  const PanelLeftScreen({super.key});

  @override
  State<PanelLeftScreen> createState() => _PanelLeftScreenState();
}

class _PanelLeftScreenState extends State<PanelLeftScreen> {
  @override
  Widget build(BuildContext context) {
    final data = Provider.of<Data>(context);

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
                  borderRadius: const BorderRadius.only(
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
                          "Estatísticas do Perfil Acadêmico e Institucional",
                          style: context.textStyles.subtitle,
                        ),
                      ),
                    ),
                  ),
                ),
                GenericSection(
                    dataMap: data.statusDistribution,
                    title: 'Status da Matrícula',
                    isBarChartGrouped: true,
                    infoMessage: context.infoStrings.statusInfo),
                GenericSection(
                  dataMap: data.inactivityReasonsDistribution,
                  title: 'Motivo de evasão (PI = PE)',
                  infoMessage: context.infoStrings.inactivityReasonsInfo,
                ),
                GenericSection(
                  dataMap: data.inactivityPerPeriodoDeEvasaoDistribution,
                  title: 'Motivos de evasão (Por periodo de evasão)',
                  infoMessage: context.infoStrings.inactivityPerPeriodoDeEvasao,
                ),
                GenericSection(
                  dataMap: data.admissionTypeDistribution,
                  title: 'Forma de Ingresso',
                  infoMessage: context.infoStrings.admissionInfo,
                ),
                GenericSection(
                  dataMap: data.secondarySchoolTypeDistribution,
                  title: 'Ensino Médio',
                  infoMessage: context.infoStrings.secondarySchoolInfo,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
