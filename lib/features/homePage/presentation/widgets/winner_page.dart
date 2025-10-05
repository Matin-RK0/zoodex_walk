import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:zoodex_walk/features/homePage/presentation/widgets/animated_icons.dart';

class GiftCardScreen extends StatefulWidget {
  const GiftCardScreen({super.key});

  @override
  State<GiftCardScreen> createState() => _GiftCardScreenState();
}

class _GiftCardScreenState extends State<GiftCardScreen> {
  @override
  Widget build(BuildContext context) {
    const double cardWidth = 300;
    const double cardHeight = 400;

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        extendBodyBehindAppBar: true,
        
        appBar: AppBar(
          surfaceTintColor: Colors.white,
          centerTitle: true,
          title: const Text(
            'پیش نمایش کارت هدیه',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
          ),
          backgroundColor: Colors.transparent,
          elevation: 0,
          foregroundColor: Colors.black,
          systemOverlayStyle: const SystemUiOverlayStyle(
            statusBarIconBrightness: Brightness.dark, 
            statusBarBrightness: Brightness.light,    
          ),
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
            // ** تغییر ساختاری: ترکیب هر دو دایره در یک فیلتر بلور واحد **
            ClipRect( // ClipRect برای اطمینان از اعمال فیلتر بلور روی ناحیه مشخص
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 76, sigmaY: 76),
                child: Container(
                  // Container با ابعاد بزرگ برای اطمینان از پوشش کل صفحه (محتوای Stack)
                  width: MediaQuery.of(context).size.width, 
                  height: MediaQuery.of(context).size.height,
                  color: Colors.transparent, // نیاز به رنگ شفاف
                  child: Stack(
                    children: [
                      // دایره‌ی اول: با حفظ موقعیت اولیه
                      Positioned(
                        top: -100,
                        left: -100,
                        child: Container( // دیگر BackdropFilter ندارد
                          width: 500,
                          height: 500,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            gradient: RadialGradient(
                              colors: [
                                const Color(0xFFFAD9FF).withOpacity(0.6),
                                const Color(0xFFFAD9FF).withOpacity(0.0),
                              ],
                              stops: const [0.5, 1.0],
                            ),
                          ),
                        ),
                      ),
                      
                      // دایره‌ی دوم: موقعیت و ابعاد دایره‌ی دوم از کد قبلی شما
                      Positioned(
                        top: 200,
                        left: 100,
                        child: Container( // دیگر BackdropFilter ندارد
                          width: 500,
                          height: 400,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            gradient: RadialGradient(
                              colors: [
                                const Color(0xFFFAD9FF).withOpacity(0.6),
                                const Color(0xFFFAD9FF).withOpacity(0.0),
                              ],
                              stops: const [0.5, 1.0],
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        top: 250,
                        left: -100,
                        child: Container( // دیگر BackdropFilter ندارد
                          width: 500,
                          height: 500,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            gradient: RadialGradient(
                              colors: [
                                const Color(0xFFFAD9FF).withOpacity(0.6),
                                const Color(0xFFFAD9FF).withOpacity(0.0),
                              ],
                              stops: const [0.5, 1.0],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            // ** پایان تغییر ساختاری **
            
            TwoPhaseIconMover(
              imageAssetPaths: const ['assets/curve.png', 'assets/star.png'],
              containerWidth: 300,
              containerHeight: 400,
              itemCount: 10,
            ),

            Padding(
              padding: const EdgeInsets.symmetric(vertical: 40.0),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  const SizedBox(height: 100), 

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
                              color: const Color(0x1A000000),
                              offset: const Offset(0, 3),
                              blurRadius: 8,
                              spreadRadius: 0,
                            ),
                          ],
                          gradient: const LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            colors: [Color(0xFFFBE4FF), Color(0xFFFFFBFF)],
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
                              Image.asset('assets/12.png', height: 200),
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