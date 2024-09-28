import 'package:bi_ufcg/components/charts_section.dart';

import 'package:bi_ufcg/core/ui/helpers/infoChartStrings.dart';
import 'package:bi_ufcg/core/ui/styles/colors_app.dart';
import 'package:bi_ufcg/core/ui/styles/text_styles.dart';
import 'package:bi_ufcg/service/data_service/data.dart';
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
                          "Perfil Institucional",
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
                ChartsSection(
                    dataMap: data.statusDistribution,
                    title: 'Status da Matrícula',
                    isBarChartGrouped: true,
                    infoMessage: context.infoStrings.statusInfo),
                ChartsSection(
                  dataMap: data.inactivityReasonsDistribution,
                  title: 'Motivos de Evasão (PI = PE)',
                  infoMessage: context.infoStrings.inactivityReasonsInfo,
                ),
                ChartsSection(
                  dataMap: data.inactivityPerPeriodoDeEvasaoDistribution,
                  title: 'Motivos de Evasão por Período de Evasão',
                  infoMessage: context.infoStrings.inactivityPerPeriodoDeEvasao,
                ),
                ChartsSection(
                  dataMap: data.creditCompletedVsFailedDistribution,
                  title: 'Créditos Completados vs Falhados',
                  infoMessage: context.infoStrings.creditCompletedVsFailedInfo,
                  isBarChartGrouped: true,
                ),
                ChartsSection(
                  dataMap: data.evasionStatisticsByEvasionPeriod,
                  title: 'Estátisticas de Evadidos por Período de Evasão',
                  isBarChartGrouped: true,
                  infoMessage:
                      context.infoStrings.evasionStatisticsByEvasionPeriod,
                  showPieChart: false,
                ),
                ChartsSection(
                  dataMap: data.graduationStatisticsByEvasionPeriod,
                  title: 'Estátisticas de Graduados por Período de Egressão ',
                  isBarChartGrouped: true,
                  infoMessage:
                      context.infoStrings.graduationStatisticsByEvasionPeriod,
                  showPieChart: false,
                ),
                ChartsSection(
                  dataMap: data.evasionByColor,
                  title: 'Evasão por Cor',
                  infoMessage: context.infoStrings.evasionByColor,
                ),
                ChartsSection(
                    dataMap: data.evasionByAge,
                    title: 'Evasão Por Idade',
                    infoMessage: context.infoStrings.evasionByAge),
                ChartsSection(
                    dataMap: data.evasionByGender,
                    title: 'Evasão Por Gênero',
                    infoMessage: context.infoStrings.evasionByGender),
                ChartsSection(
                    dataMap: data.evasionByAdmissionType,
                    title: ' Evasão Por Forma de Ingresso',
                    infoMessage: context.infoStrings.evasionByAdmissionType),
                ChartsSection(
                    dataMap: data.evasionBySecondarySchoolType,
                    title: 'Evasão Por Tipo de Ensino Médio',
                    infoMessage: context.infoStrings.evasionBySecondarySchool),
                ChartsSection(
                    dataMap: data.evasionByDisabilities,
                    title: 'Evasão Por Deficiência',
                    infoMessage: context.infoStrings.evasionByDisabilities),
              ],
            ),
          )
        ],
      ),
    );
  }
}
