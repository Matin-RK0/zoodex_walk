import 'package:flutter/material.dart';

class OrdersPage extends StatefulWidget {
  const OrdersPage({super.key});

  @override
  State<OrdersPage> createState() => _OrdersPageState();
}

class _OrdersPageState extends State<OrdersPage> {
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: const Text(
              'پیتزا مارگاریتا',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
            ),
            backgroundColor: Colors.white,
            foregroundColor: Colors.black,
            leading: GestureDetector(
              child: Icon(
                Icons.chevron_left_rounded,
                size: 40,
                color: Color(0xff5F6266),
              ),
              onTap: () {
                if (Navigator.canPop(context)) Navigator.pop(context);
              },
            ),
            actions: [
              GestureDetector(
                onTap: () {},
                child: Icon(
                  Icons.heart_broken_rounded,
                  size: 28,
                  color: Color(0xff5F6266),
                ),
              ),
            ],
            bottom: PreferredSize(
              preferredSize: const Size.fromHeight(8.0),
              child: Divider(
                height: 1.0,
                thickness: 2.0,
                color: Color(0xffefeef0),
                indent: 16,
                endIndent: 16, // می‌توانید رنگ را تغییر دهید
              ),
            ),
          ),
          body: SingleChildScrollView(child: Column(children: [Container()])),
        ),
      ),
    );
  }
}
