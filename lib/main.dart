import 'package:bi_ufcg/widget_tree.dart';
import 'package:flutter/material.dart';

import 'resource/app_colors.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Admin Panel',
      theme: ThemeData(
          scaffoldBackgroundColor: AppColors.purpleDark,
          primarySwatch: Colors.blue,
          canvasColor: AppColors.purpleLight),
      home: WidgetTree(),
    );
  }
}
