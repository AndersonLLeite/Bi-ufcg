import 'package:flutter/material.dart';
import '../resource/app_colors.dart';
import '../resource/app_padding.dart';
import '../widget/responsive_layout.dart';

class ButtonsInfo {
  String title;
  IconData icon;

  ButtonsInfo({required this.title, required this.icon});
}

List<ButtonsInfo> _buttonInfo = [
  ButtonsInfo(title: "Ciência da Computação", icon: Icons.computer),
];

int _currentIndex = 0;

class DrawerScreen extends StatefulWidget {
  const DrawerScreen({super.key});

  @override
  State<DrawerScreen> createState() => _DrawerScreenState();
}

class _DrawerScreenState extends State<DrawerScreen> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      elevation: 0,
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(AppPadding.P10),
          child: Column(
            children: [
              ListTile(
                title: const Text(
                  'Admin Menu',
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
                trailing: !ResponsiveLayout.isComputer(context)
                    ? IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: const Icon(Icons.close, color: Colors.white))
                    : null,
              ),
              ...List.generate(
                  _buttonInfo.length,
                  (index) => Column(
                        children: [
                          Container(
                            decoration: index == _currentIndex
                                ? BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    gradient: LinearGradient(colors: [
                                      AppColors.red.withOpacity(0.9),
                                      AppColors.orange.withOpacity(0.9),
                                    ]))
                                : null,
                            child: ListTile(
                              title: Text(
                                _buttonInfo[index].title,
                                style: const TextStyle(color: Colors.white),
                              ),
                              leading: Padding(
                                padding: const EdgeInsets.all(AppPadding.P10),
                                child: Icon(
                                  _buttonInfo[index].icon,
                                  color: Colors.white,
                                ),
                              ),
                              onTap: () {
                                setState(() {
                                  _currentIndex = index;
                                });
                              },
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                            ),
                          ),
                          const Divider(
                            color: Colors.white,
                            thickness: 0.1,
                          ),
                        ],
                      ))
            ],
          ),
        ),
      ),
    );
  }
}
