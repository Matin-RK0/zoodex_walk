import 'package:flutter/material.dart';

class CurvedCarousel extends StatefulWidget {
  const CurvedCarousel({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _CurvedCarouselState createState() => _CurvedCarouselState();
}

class _CurvedCarouselState extends State<CurvedCarousel> {
  final int itemCount = 6; // تعداد آیتم واقعی
  final int fakeItemCount = 1000; // آیتم‌های مجازی برای لوپ
  late final PageController _controller;

  @override
  void initState() {
    super.initState();
    // از وسط شروع می‌کنیم تا بتونیم هم جلو و هم عقب بریم
    _controller = PageController(
      viewportFraction: 0.6,
      initialPage: fakeItemCount ~/ 2,
    );
  }

  @override
  void dispose() {
    _controller.dispose(); // خیلی مهم برای جلوگیری از memory leak
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          surfaceTintColor: Colors.white,
          centerTitle: true,
          title: const Text(
            'کارت هدیه',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
          ),
          backgroundColor: Colors.white,
          foregroundColor: Colors.black,
          leading: GestureDetector(
            child: const Icon(
              Icons.chevron_left_rounded,
              size: 40,
              color: Color(0xff5F6266),
            ),
            onTap: () {
              if (Navigator.canPop(context)) Navigator.pop(context);
            },
          ),
        ),
        body: Column(
          children: [
            SizedBox(height: 32),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [Icon(Icons.card_giftcard)],
            ),

            Padding(
              padding: const EdgeInsets.symmetric(vertical: 12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'کارت هدیه ات رو انتخاب کن',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Center(
                child: SizedBox(
                  height: 400,
                  width: double.infinity,
                  child: PageView.builder(
                    controller: _controller,
                    itemCount: fakeItemCount,
                    itemBuilder: (context, index) {
                      // اندیس واقعی برای تصاویر
                      final realIndex = index % itemCount;

                      return AnimatedBuilder(
                        animation: _controller,
                        builder: (context, child) {
                          double value = 0.0;

                          if (_controller.hasClients &&
                              _controller.position.haveDimensions) {
                            value = _controller.page! - index;
                          } else {
                            value =
                                (_controller.initialPage - index).toDouble();
                          }

                          // انیمیشن‌ها
                          double scale = 1 - (value.abs() * 0.3);
                          double translateY = value.abs() * 50;
                          double rotation = value * 0.3;

                          return Transform.translate(
                            offset: Offset(0, translateY),
                            child: Transform.rotate(
                              angle: rotation,
                              child: Transform.scale(
                                scale: scale,
                                child: Container(
                                  margin: const EdgeInsets.symmetric(
                                    horizontal: 10,
                                    vertical: 20,
                                  ),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    gradient: const LinearGradient(
                                      begin: Alignment.topLeft,
                                      end: Alignment.bottomRight,
                                      colors: [
                                        Color(0xffFEF1C7), 
                                        Color(0xffFFFFF8), 
                                      ],
                                    ),
                                    boxShadow: const [
                                      BoxShadow(
                                        color: Colors.black26,
                                        blurRadius: 5,
                                        offset: Offset(0, 1),
                                      ),
                                    ],
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(40.0),
                                    child: Center(
                                      child: Image(image: AssetImage('assets/10.png')),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      );
                    },
                  ),
                ),
              ),
            ),
          ],
        ),
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.all(24.0),
          child: SizedBox(
            width: double.infinity,
            height: 50,
            child: ElevatedButton(
              onPressed: () {
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xff3a4ba8),
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
              ),
              child: Text("ادامه", style: TextStyle(fontSize: 18)),
            ),
          ),
        ),
      ),
    );
  }
}
