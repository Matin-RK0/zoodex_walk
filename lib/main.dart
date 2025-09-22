import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:zoodex_walk/di/injection.dart';
import 'package:zoodex_walk/features/bottomNavigationBar/presentation/providers/navigation_provider.dart';
import 'package:zoodex_walk/features/homePage/presentation/providers/banner_provider.dart';
import 'app.dart';

void main() {
  setup();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => getIt<NavigationProvider>()),
        ChangeNotifierProvider(create: (_) => getIt<BannerProvider>()),
      ],
      child: const MyApp(),
    ),
  );
}

