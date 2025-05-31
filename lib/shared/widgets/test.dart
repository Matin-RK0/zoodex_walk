import 'package:flutter/material.dart';

class CustomGradientCardWithCircles extends StatelessWidget {
  /// پارامترهای داینامیک: عنوان و زیرعنوان و تابع برگشت
  final String title;
  final String subtitle;
  final VoidCallback? onBackPressed;

  const CustomGradientCardWithCircles({
    super.key,
    this.title = 'زودکس پلاس',
    this.subtitle = 'مدت زمان باقی‌مانده: 23 روز',
    this.onBackPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Container(
        height: 100,
        decoration: BoxDecoration(
          border: Border.all(width: 1, color: Color(0xFFF8B401)),
          gradient: const LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFFFFFFFF), Color(0xFFF8B401)],
          ),
          borderRadius: BorderRadius.circular(16),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(16),
          child: Stack(
            children: [
              Positioned(
                top: 25,
                right: -300,
                child: Container(
                  width: 780,
                  height: 780,
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.15),
                    shape: BoxShape.circle,
                  ),
                ),
              ),
              Positioned(
                top: 55,
                right: -260,
                child: Container(
                  width: 680,
                  height: 680,
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.15),
                    shape: BoxShape.circle,
                  ),
                ),
              ),
              Positioned(
                top: 85,
                right: -220,
                child: Container(
                  width: 580,
                  height: 580,
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.15),
                    shape: BoxShape.circle,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 18.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    IconButton(
                      onPressed: onBackPressed,
                      icon: Icon(
                        Icons.chevron_left_rounded,
                        color: Colors.grey.shade600,
                        size: 40,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            title,
                            textAlign: TextAlign.right,
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.black87,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            subtitle,
                            textAlign: TextAlign.right,
                            style: const TextStyle(
                              fontSize: 16,
                              color: Colors.black87,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
