import 'package:bi_ufcg/charts_column_sections/social_parameters_section/age_section.dart';
import 'package:bi_ufcg/charts_column_sections/social_parameters_section/gender_section.dart';
import 'package:bi_ufcg/charts_column_sections/social_parameters_section/policy_section.dart';
import 'package:bi_ufcg/core/ui/styles/colors_app.dart';
import 'package:bi_ufcg/core/ui/styles/text_styles.dart';
import 'package:flutter/material.dart';

import '../core/ui/styles/app_padding.dart';

class PanelCenterScreen extends StatefulWidget {
  const PanelCenterScreen({super.key});

  @override
  State<PanelCenterScreen> createState() => _PanelCenterScreenState();
}

class _PanelCenterScreenState extends State<PanelCenterScreen> {
  @override
  Widget build(BuildContext context) {
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
            const AgeSection(),
            const GenderSection(),
            const PolicySection()
          ],
        ),
      ),
    );
  }
}
