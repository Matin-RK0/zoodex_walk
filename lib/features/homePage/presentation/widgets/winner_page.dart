import 'dart:math';

import 'package:flutter/material.dart';
import 'package:zoodex_walk/features/homePage/presentation/widgets/animated_icons.dart';

class GiftCardScreen extends StatefulWidget {
  const GiftCardScreen({super.key});

  @override
  State<GiftCardScreen> createState() => _GiftCardScreenState();
}

class _GiftCardScreenState extends State<GiftCardScreen> {
  // استفاده از مسیرهای جدید و حذف سایز ثابت
  static const List<Map<String, dynamic>> _uniqueAssets = [
    {'path': 'assets/star.png'}, 
    {'path': 'assets/curve.png'}, 
  ];

  List<Widget> _buildImageSpawners(int spawnCount) {
    List<Widget> spawners = [];
    final Random random = Random();
    
    for (var asset in _uniqueAssets) {
      spawners.addAll(
        List.generate(
          spawnCount,
          (index) {
            // محاسبه سایز تصادفی بین 20.0 تا 30.0
            final double randomSize = random.nextDouble() * 30.0 + 20.0;
            
            return TwoPhaseIconMover(
              key: ValueKey('${asset['path']}_$index'), 
              imageAssetPath: asset['path'] as String,
              imageSize: randomSize, // اعمال سایز تصادفی
            );
          },
        ),
      );
    }
    
    return spawners;
  }

  @override
  Widget build(BuildContext context) {
    const double cardWidth = 300;
    const double cardHeight = 400;
    
    const int desiredSpawnCount = 4; 

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          surfaceTintColor: Colors.white,
          centerTitle: true,
          title: const Text(
            'پیش نمایش کارت هدیه',
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
        body: Stack(
          alignment: Alignment.center,
          children: <Widget>[
            ..._buildImageSpawners(desiredSpawnCount),
            
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 40.0),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  const SizedBox(height: 50),
                  const Text(
                    'یه نفر به یاد تو بوده...',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 30),

                  Expanded(
                    child: Center(
                      child: Container(
                        width: cardWidth,
                        height: cardHeight,
                        padding: const EdgeInsets.all(30),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.pink.withOpacity(0.2),
                              spreadRadius: 2,
                              blurRadius: 15,
                              offset: const Offset(0, 8),
                            ),
                          ],
                          gradient: const LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            colors: [Color(0xFFFBE4FF), Color(0xFFE0B0FF)],
                            stops: [0.0, 1.0],
                          ),
                        ),
                        child: SizedBox(
                          height: 350,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            mainAxisSize: MainAxisSize.max,
                            children: <Widget>[
                              const Text(
                                '۲,۰۰۰,۰۰۰ تومان',
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w900,
                                  color: Colors.black87,
                                ),
                              ),
                              Image.asset(
                                'assets/12.png', 
                                height: 200,
                              ),
                              const Column(
                                children: [
                                  Text(
                                    'از فریبا قطبی',
                                    style: TextStyle(
                                      fontSize: 16,
                                      color: Colors.black54,
                                    ),
                                  ),
                                  Text(
                                    'به دینا ناظمی',
                                    style: TextStyle(
                                      fontSize: 16,
                                      color: Colors.black54,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 30),
                  const Text(
                    'این کارت هدیه مخصوص تو فرستاده شده.',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 16, color: Colors.black54),
                  ),
                  const SizedBox(height: 50), 
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}