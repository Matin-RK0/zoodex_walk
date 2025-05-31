import 'package:flutter/material.dart';
import 'package:zoodex_walk/core/theme/app_theme.dart';
import 'package:zoodex_walk/features/bottomNavigationBar/presentation/widgets/app_scaffold.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(      
      debugShowCheckedModeBanner: false,
      title: "Zoodex Walk",
      theme: customLightTheme,          
      home: AppScaffold(),
    );
  }
}