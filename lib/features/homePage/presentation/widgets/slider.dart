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
    return Scaffold(
      appBar: AppBar(title: const Text("Curved Carousel Loop")),
      body: Center(
        child: SizedBox(
          height: 500,
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
                    value = (_controller.initialPage - index).toDouble();
                  }

                  // انیمیشن‌ها
                  double scale = 1 - (value.abs() * 0.3);
                  double translateY = value.abs() * 50;
                  double rotation = value * -0.2;

                  return Transform.translate(
                    offset: Offset(0, translateY),
                    child: Transform.rotate(
                      angle: rotation,
                      child: Transform.scale(
                        scale: scale,
                        child: Container(
                          margin: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 20),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            image: DecorationImage(
                              image: NetworkImage(
                                "https://picsum.photos/id/${1000 + realIndex}/400/600",
                              ),
                              fit: BoxFit.cover,
                            ),
                            boxShadow: const [
                              BoxShadow(
                                color: Colors.black26,
                                blurRadius: 5,
                                offset: Offset(0, 5),
                              ),
                            ],
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
    );
  }
}
