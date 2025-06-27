import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:zoodex_walk/features/homePage/presentation/pages/home_page.dart';
import 'package:zoodex_walk/features/mapPage/presentation/pages/map_page.dart';
import 'package:zoodex_walk/features/ordersPage/presentation/pages/orders_page.dart';
import 'package:zoodex_walk/features/profilePage/presentation/pages/profile_page.dart';
import '../providers/navigation_provider.dart';
import 'custom_bottom_nav.dart';

class AppScaffold extends StatelessWidget {
  const AppScaffold({super.key});

  static const _pages = <Widget>[
    ProfilePage(),
    HomePage(),
    MapPage(),
    OrdersPage(),
  ];

  @override
  Widget build(BuildContext context) {
    final nav = context.watch<NavigationProvider>();
    return Scaffold(
      body: IndexedStack(index: nav.currentIndex, children: _pages),
      bottomNavigationBar: const CustomBottomNav(),
    );
  }
}
