import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class NavItem extends StatelessWidget {
  final String iconUrl;
  final String activeIconUrl;
  final String label;
  final bool isActive;
  final VoidCallback onTap;

  const NavItem({
    super.key,
    required this.iconUrl,
    required this.activeIconUrl,
    required this.label,
    required this.isActive,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final displayUrl = isActive ? activeIconUrl : iconUrl;

    return Row(
      children: [
        GestureDetector(
          onTap: onTap,
          child: Container(
            padding: const EdgeInsets.only(top: 2, bottom: 2),
            height: 60,
            width: 90,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: isActive ? Color(0xffF1E8F2) : Colors.white,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const SizedBox(height: 4),
                SvgPicture.network(
                  displayUrl,
                  width: 24,
                  height: 24,
                  placeholderBuilder:
                      (_) => const SizedBox(
                        width: 24,
                        height: 24,
                        child: CircularProgressIndicator(strokeWidth: 2),
                      ),
                ),
                const SizedBox(height: 4),
                Text(
                  label,
                  style: TextStyle(
                    color: isActive ? Color(0xFF701978) : Color(0xFFACAAAF),
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
