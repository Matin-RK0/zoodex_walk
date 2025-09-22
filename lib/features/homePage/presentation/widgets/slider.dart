import 'package:flutter/material.dart';

class CurvedCarousel extends StatefulWidget {
  @override
  _CurvedCarouselState createState() => _CurvedCarouselState();
}

class _CurvedCarouselState extends State<CurvedCarousel> {
  final PageController _controller = PageController(viewportFraction: 0.6, initialPage: 2);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Curved Carousel")),
      body: Center(
        child: SizedBox(
          height: 500,
          width: double.infinity,
          child: PageView.builder(
            controller: _controller,
            itemCount: 6,
            itemBuilder: (context, index) {
              return AnimatedBuilder(
                animation: _controller,
                builder: (context, child) {
                  double value = 0.0;

                  // محاسبه مقدار صفحه
                  if (_controller.hasClients && _controller.position.haveDimensions) {
                    value = _controller.page! - index;
                  } else {
                    value = (_controller.initialPage - index).toDouble();
                  }

                  // بزرگ‌تر شدن کارت وسط
                  double scale = 1 - (value.abs() * 0.3);

                  // شیفت کارت‌ها به بالا
                  double translateY = value.abs() * 50;

                  // چرخش کارت‌ها به چپ و راست
                  double rotation = value * -0.2; // رادیان، مثبت راست، منفی چپ

                  return Transform.translate(
                    offset: Offset(0, translateY),
                    child: Transform.rotate(
                      angle: rotation,
                      child: Transform.scale(
                        scale: scale,
                        child: Container(
                          margin: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                          decoration: BoxDecoration(
                            color: Colors.blue,
                            borderRadius: BorderRadius.circular(20),
                            image: DecorationImage(
                              image: NetworkImage(
                                  "https://picsum.photos/id/${1000 + index}/400/600"),
                              fit: BoxFit.cover,
                            ),
                            boxShadow: [
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