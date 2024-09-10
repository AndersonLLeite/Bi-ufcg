import 'package:bi_ufcg/core/ui/styles/colors_app.dart';
import 'package:bi_ufcg/screen/home/view/home_view_impl.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';

import '../../components/custom_app_bar.dart';
import '../../core/ui/styles/responsive_layout.dart';
import '../../components/drawer_screen.dart';
import '../../components/panel_center_screen.dart';
import '../../components/panel_left_screen.dart';
import '../../components/panel_right_screen.dart';
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
            ? const PanelLeftScreen()
            : currentIndex == 1
                ? const PanelCenterScreen()
                : const PanelRightScreen(),
        tablet: const Row(
          children: [
            Expanded(child: PanelLeftScreen()),
            Expanded(child: PanelCenterScreen()),
          ],
        ),
        largeTablet: const Row(
          children: [
            //  Expanded(child: PanelLeftScreen()),
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
            const Expanded(flex: 5, child: PanelLeftScreen()),
            const Expanded(flex: 5, child: PanelCenterScreen()),
            const Expanded(flex: 5, child: PanelRightScreen())
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
              backgroundColor: ColorsApp.instance.secondary,
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
