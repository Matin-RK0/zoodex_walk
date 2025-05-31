import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      surfaceTintColor: Colors.white,
      title: GestureDetector(
        onTap: () {},
        child: Row(
          textDirection: TextDirection.rtl,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(CupertinoIcons.placemark, size: 18, color: Colors.black),
            SizedBox(width: 6),
            Text("کرمان", style: TextStyle(color: Colors.black, fontSize: 14)),
            SizedBox(width: 6),
            Text(
              'انتخاب آدرس ',
              style: TextStyle(color: Colors.red, fontSize: 14),
            ),
            const Icon(Icons.keyboard_arrow_down, size: 30, color: Colors.red),
          ],
        ),
      ),
      centerTitle: true,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
