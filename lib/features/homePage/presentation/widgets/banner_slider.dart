import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import '../../domain/entities/banner_item.dart';

class BannerSlider extends StatelessWidget {
  final List<BannerItem> items;
  const BannerSlider({super.key, required this.items});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: CarouselSlider(
        options: CarouselOptions(
          height: 200,
          enlargeCenterPage: true,
          enableInfiniteScroll: true,
          viewportFraction: 1,
        ),
        items:
            items.map((item) {
              return GestureDetector(
                onTap: () => Navigator.pushNamed(context, item.url),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: Image.network(item.imagePath, fit: BoxFit.contain),
                ),
              );
            }).toList(),
      ),
    );
  }
}
