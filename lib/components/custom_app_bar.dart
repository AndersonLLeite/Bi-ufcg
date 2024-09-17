import 'package:bi_ufcg/core/ui/styles/app_padding.dart';
import 'package:bi_ufcg/core/ui/styles/colors_app.dart';
import 'package:bi_ufcg/screen/home/presenter/home_presenter.dart';
import 'package:flutter/material.dart';

import '../core/ui/styles/responsive_layout.dart';

List<String> _buttonNames = ["Cursos", "Periodos"];
int _currentSelectedButton = 0;

class CustomAppBar extends StatefulWidget {
  final HomePresenter presenter;
  const CustomAppBar({super.key, required this.presenter});

  @override
  State<CustomAppBar> createState() => _CustomAppBarState();
}

class _CustomAppBarState extends State<CustomAppBar> {
  @override
  Widget build(BuildContext context) {
    return Container(
        color: context.colors.appBarColor,
        child: Row(children: [
          ...List.generate(
              _buttonNames.length,
              (index) => TextButton(
                  onPressed: () {
                    setState(() {
                      _currentSelectedButton = index;
                      widget.presenter.changeIndexMenu(index);
                      if (!ResponsiveLayout.isComputer(context)) {
                        Scaffold.of(context).openDrawer();
                      }
                    });
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(AppPadding.P10 * 2),
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            _buttonNames[index],
                            style: TextStyle(
                              color: _currentSelectedButton == index
                                  ? context.colors.textButtonAppBarSelectedColor
                                  : context
                                      .colors.textButtonAppBarUnselectedColor,
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.all(AppPadding.P10 / 2),
                            width: 60,
                            height: 2,
                            decoration: BoxDecoration(
                              gradient: _currentSelectedButton == index
                                  ? LinearGradient(
                                      colors: [
                                        context.colors.tertiary,
                                        context.colors.quaternary,
                                      ],
                                    )
                                  : null,
                            ),
                          ),
                        ]),
                  ))),
          const SizedBox(width: AppPadding.P10),
          if (!ResponsiveLayout.isPhoneLimit(context))
            Row(
              children: [
                Container(
                  margin: const EdgeInsets.all(AppPadding.P10),
                  height: double.infinity,
                  decoration: const BoxDecoration(boxShadow: [
                    BoxShadow(
                      color: Colors.black45,
                      offset: Offset(0, 0),
                      spreadRadius: 1,
                      blurRadius: 10,
                    )
                  ], shape: BoxShape.circle),
                  child: CircleAvatar(
                    backgroundColor: Colors.transparent,
                    radius: 40,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(50),
                      child: Image.asset(
                        "assets/images/escudo-ufcg.png",
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: AppPadding.P10),
                Container(
                  margin: const EdgeInsets.all(AppPadding.P10),
                  height: double.infinity,
                  decoration: const BoxDecoration(boxShadow: [
                    BoxShadow(
                      color: Colors.black45,
                      offset: Offset(0, 0),
                      spreadRadius: 1,
                      blurRadius: 10,
                    )
                  ], shape: BoxShape.circle),
                  child: CircleAvatar(
                    backgroundColor: Colors.transparent,
                    radius: 40,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(50),
                      child: Image.asset(
                        "assets/images/logo1-eureca.png",
                      ),
                    ),
                  ),
                ),
              ],
            ),
        ]));
  }
}
