import 'package:bi_ufcg/components/generic_section.dart';
import 'package:bi_ufcg/core/ui/helpers/infoChartStrings.dart';
import 'package:bi_ufcg/core/ui/styles/colors_app.dart';
import 'package:bi_ufcg/core/ui/styles/text_styles.dart';
import 'package:bi_ufcg/service/data/data.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../core/ui/styles/app_padding.dart';

class PanelRightScreen extends StatefulWidget {
  const PanelRightScreen({super.key});

  @override
  State<PanelRightScreen> createState() => _PanelRightScreenState();
}

class _PanelRightScreenState extends State<PanelRightScreen> {
  @override
  Widget build(BuildContext context) {
    final data = Provider.of<Data>(context);

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
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
                      title: Text("Perfil do Discente",
                          style: context.textStyles.title),
                      subtitle: Text(
                        "Parametros sociais",
                        style: context.textStyles.subtitle,
                      ),
                    ),
                  )),
            ),
            ChartsSection(
              dataMap: data.genderDistribution,
              title: 'Gênero',
              infoMessage: context.infoStrings.genderInfo,
              isBarChartGrouped: true,
            ),
            ChartsSection(
              dataMap: data.ageAtEnrollmentDistribution,
              title: 'Idade No Momento Da Matrícula',
              infoMessage: context.infoStrings.ageAtEnrollmentInfo,
            ),
            ChartsSection(
              dataMap: data.ageDistribution,
              title: 'Idade Atual',
              infoMessage: context.infoStrings.ageInfo,
            ),
            ChartsSection(
              dataMap: data.affirmativePolicyDistribution,
              title: 'Política de Ação Afirmativa',
              infoMessage: context.infoStrings.affirmativePolicyInfo,
            ),
            ChartsSection(
              dataMap: data.colorDistribution,
              title: 'Cor/Raça',
              infoMessage: context.infoStrings.colorInfo,
            ),
            ChartsSection(
              dataMap: data.originDistribution,
              title: 'Naturalidade',
              infoMessage: context.infoStrings.originInfo,
            ),
            ChartsSection(
              dataMap: data.disabilitiesDistribution,
              title: 'Deficiência',
              infoMessage: context.infoStrings.disabilityInfo,
            ),
          ],
        ),
      ),
    );
  }
}
