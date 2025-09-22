import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  // کنترلر برای مدیریت صفحات PageView
  final PageController _pageController = PageController();

  // لیستی از مسیر تصاویر برای هر اسلاید
  // شما باید این تصاویر را در پوشه assets قرار دهید
  final List<String> _slideImages = [
    'assets/1.png', // تصویر شما
    'assets/1.png', // تصویر تستی دوم
    'assets/1.png', // تصویر تستی سوم
  ];

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200], // یک رنگ پس‌زمینه برای کل صفحه
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // ویجت PageView برای ساخت اسلایدر
            Expanded(
              child: PageView.builder(
                controller: _pageController,
                itemCount: _slideImages.length,
                itemBuilder: (context, index) {
                  return SlideCard(imagePath: _slideImages[index]);
                },
              ),
            ),
            
            // فاصله بین اسلایدر و نشانگرها
            const SizedBox(height: 25),

            // نشانگرهای صفحه (dots)
            SmoothPageIndicator(
              controller: _pageController,
              count: _slideImages.length,
              effect: const WormEffect(
                dotHeight: 12,
                dotWidth: 12,
                activeDotColor: Colors.orange,
                dotColor: Colors.grey,
              ),
            ),

            const SizedBox(height: 50), // فاصله از پایین صفحه
          ],
        ),
      ),
    );
  }
}

// ویجت سفارشی برای نمایش هر کارت اسلاید
class SlideCard extends StatelessWidget {
  final String imagePath;

  const SlideCard({
    super.key,
    required this.imagePath,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      // فاصله کارت از اطراف
      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 40),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(24),
          gradient: const LinearGradient(
            colors: [
              Color(0xFFFFF7E0), // زرد بسیار روشن
              Color(0xFFFFE0B2), // نارنجی کم‌رنگ
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              spreadRadius: 2,
              blurRadius: 10,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            // نمایش تصویر
            child: Image.asset(
              imagePath,
              fit: BoxFit.contain,
            ),
          ),
        ),
      ),
    );
  }
}