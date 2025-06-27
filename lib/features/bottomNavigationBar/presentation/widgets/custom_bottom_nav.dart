import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/navigation_provider.dart';
import '../providers/nav_config.dart';
import 'nav_item.dart';

class CustomBottomNav extends StatelessWidget {
  const CustomBottomNav({super.key});

  @override
  Widget build(BuildContext context) {
    final nav = context.watch<NavigationProvider>();

    return Container(
      height: 70,
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            spreadRadius: 5,
            blurRadius: 10,
          ),
        ],
      ),
      padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: List.generate(NavConfig.iconUrls.length, (i) {
          return NavItem(
            iconUrl: NavConfig.iconUrls[i],
            activeIconUrl: NavConfig.activeIconUrls[i],
            label: NavConfig.labels[i],
            isActive: nav.currentIndex == i,
            onTap: () => nav.setIndex(i),
          );
        }),
      ),
    );
  }
}
