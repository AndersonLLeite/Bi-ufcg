import 'package:bi_ufcg/core/ui/helpers/messages.dart';
import 'package:bi_ufcg/screen/home/view/home_view_impl.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';

import '../../resource/app_colors.dart';
import '../custom_app_bar.dart';
import '../../charts/responsive_layout.dart';
import '../drawer_screen.dart';
import '../panel_center_screen.dart';
import '../panel_left_screen.dart';
import '../panel_right_screen.dart';
import 'presenter/home_presenter.dart';

class HomePage extends StatefulWidget {
  final HomePresenter presenter;

  const HomePage({Key? key, required this.presenter}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends HomeViewImpl {
  int currentIndex = 1;

  final List<Widget> _icons = const [
    Icon(Icons.add, size: 30),
    Icon(Icons.list, size: 30),
    Icon(Icons.compare_arrows, size: 30),
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size(double.infinity, 100),
        child: (ResponsiveLayout.isTinyLimit(context) ||
                ResponsiveLayout.isTinyHeightLimit(context))
            ? Container()
            : CustomAppBar(presenter: widget.presenter),
      ),
      body: ResponsiveLayout(
        tiny: Container(),
        phone: currentIndex == 0
            ? PanelLeftScreen()
            : currentIndex == 1
                ? const PanelCenterScreen()
                : const PanelRightScreen(),
        tablet: Row(
          children: [
            Expanded(child: PanelLeftScreen()),
            const Expanded(child: PanelRightScreen())
          ],
        ),
        largeTablet: Row(
          children: [
            Expanded(child: PanelLeftScreen()),
            Expanded(child: PanelCenterScreen()),
            Expanded(child: PanelRightScreen())
          ],
        ),
        computer: Row(
          children: [
            Expanded(
                flex: 3,
                child: DrawerScreen(
                    courses: listCourses,
                    homePresenter: widget.presenter,
                    indexSelected: menuIndexSelected,
                    terms: terms)),
            Expanded(flex: 5, child: PanelLeftScreen()),
            Expanded(flex: 5, child: PanelCenterScreen()),
            Expanded(flex: 5, child: PanelRightScreen())
          ],
        ),
      ),
      drawer: DrawerScreen(
          courses: listCourses,
          homePresenter: widget.presenter,
          indexSelected: menuIndexSelected,
          terms: terms),
      bottomNavigationBar: ResponsiveLayout.isPhoneLimit(context)
          ? CurvedNavigationBar(
              backgroundColor: AppColors.purpleDark,
              color: Colors.white24,
              index: currentIndex,
              items: _icons,
              onTap: (index) {
                setState(() {
                  currentIndex = index;
                });
              },
            )
          : const SizedBox(),
    ));
  }
}
