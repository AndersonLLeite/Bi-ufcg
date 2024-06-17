import 'package:bi_ufcg/resource/app_colors.dart';
import 'package:bi_ufcg/resource/app_padding.dart';
import 'package:flutter/material.dart';

import 'responsive_layout.dart';

List<String> _buttonNames = ["Pró-Reitoria", "Coordenação de curso"];
int _currentSelectedButton = 0;

class CustomAppBar extends StatefulWidget {
  const CustomAppBar({super.key});

  @override
  State<CustomAppBar> createState() => _CustomAppBarState();
}

class _CustomAppBarState extends State<CustomAppBar> {
  @override
  Widget build(BuildContext context) {
    return Container(
        color: AppColors.purpleLight,
        child: Row(children: [
          if (ResponsiveLayout.isComputer(context))
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
                radius: 50,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(50),
                  child: Image.asset(
                    "assets/images/ufcgLogo.png",
                  ),
                ),
              ),
            )
          else
            IconButton(
              color: Colors.white,
              iconSize: 30,
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
              icon: const Icon(Icons.menu),
            ),
          const SizedBox(width: AppPadding.P10),
          if (ResponsiveLayout.isComputer(context))
            ...List.generate(
                _buttonNames.length,
                (index) => TextButton(
                    onPressed: () {
                      setState(() {
                        _currentSelectedButton = index;
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
                                    ? Colors.white
                                    : Colors.white70,
                              ),
                            ),
                            Container(
                              margin: const EdgeInsets.all(AppPadding.P10 / 2),
                              width: 60,
                              height: 2,
                              decoration: BoxDecoration(
                                gradient: _currentSelectedButton == index
                                    ? const LinearGradient(
                                        colors: [
                                          AppColors.red,
                                          AppColors.orange,
                                        ],
                                      )
                                    : null,
                              ),
                            ),
                          ]),
                    )))
          else
            Padding(
              padding: const EdgeInsets.all(AppPadding.P10 * 2),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    _buttonNames[_currentSelectedButton],
                    style: const TextStyle(
                      color: Colors.white,
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.all(AppPadding.P10 / 2),
                    width: 60,
                    height: 2,
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          AppColors.red,
                          AppColors.orange,
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
        ]));
  }
}
