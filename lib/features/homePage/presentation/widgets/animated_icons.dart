import 'dart:math';
import 'package:flutter/material.dart';

class TwoPhaseIconMover extends StatefulWidget {
  final String imageAssetPath;
  final double imageSize;

  const TwoPhaseIconMover({
    super.key,
    required this.imageAssetPath,
    this.imageSize = 30.0,
  });

  @override
  State<TwoPhaseIconMover> createState() => _TwoPhaseIconMoverState();
}

class _TwoPhaseIconMoverState extends State<TwoPhaseIconMover>
    with TickerProviderStateMixin {
  late AnimationController _phase1Controller;
  late Animation<Offset> _phase1Animation;

  late AnimationController _phase2Controller;
  late Animation<Offset> _phase2Animation; // Tween جدید برای حرکت تصادفی فاز ۲
  
  late Random _random;

  Offset _baseOffset = Offset.zero;
  Offset _currentPhase2Offset = Offset.zero; 
  Offset _lastPhase2Offset = Offset.zero; 

  late double _circularRadius;
  late double _phase2DurationSeconds;

  static const double cardWidth = 300.0;
  static const double cardHeight = 400.0;

  @override
  void initState() {
    super.initState();
    _random = Random();

    _circularRadius = _random.nextDouble() * 5.0 + 5.0;
    
    _phase2DurationSeconds = _random.nextDouble() * 0.5 + 1.0; 

    const double cardHalfWidth = cardWidth / 2;
    const double cardHalfHeight = cardHeight / 2;
    const double outerMargin = 30.0;

    double randomX = 0;
    double randomY = 0;

    final bool forceHorizontal = _random.nextBool(); 

    if (forceHorizontal) {
        double xMagnitude = _random.nextDouble() * outerMargin + cardHalfWidth; 

        double randomFractionY = _random.nextDouble() * 2 - 1;
        randomY = randomFractionY * cardHalfHeight;
        
        if (_random.nextBool()) xMagnitude *= -1;

        randomX = xMagnitude;

    } else {
        double yMagnitude = _random.nextDouble() * outerMargin + cardHalfHeight;

        double randomFractionX = _random.nextDouble() * 2 - 1;
        randomX = randomFractionX * cardHalfWidth;

        if (_random.nextBool()) yMagnitude *= -1;

        randomY = yMagnitude;
    }
    
    _baseOffset = Offset(randomX, randomY); 

    // تعریف اولین نقطه آفست کوچک فاز ۲ که فاز ۱ به آن می‌رسد
    final Offset initialPhase2Offset = Offset(_circularRadius, 0);
    
    // نقطه پایان فاز ۱ (نقطه شروع حرکت تصادفی)
    final targetOffsetPhase1 = _baseOffset + initialPhase2Offset;

    // مقداردهی اولیه آفست‌های فاز ۲ برای اطمینان از شروع نرم فاز ۲ (FIX)
    _currentPhase2Offset = initialPhase2Offset; 
    _lastPhase2Offset = initialPhase2Offset; 


    _phase1Controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    );

    _phase1Animation = Tween<Offset>(
      begin: Offset.zero,
      end: targetOffsetPhase1,
    ).animate(CurvedAnimation(
      parent: _phase1Controller,
      curve: Curves.easeInOutBack,
    ));

    _phase1Controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _startPhase2();
      }
    });

    _phase1Controller.forward();

    _phase2Controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: (_phase2DurationSeconds * 1000).toInt()),
    );
    
    _phase2Controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _startPhase2(); // تکرار تصادفی
      }
    });
  }

  // ایجاد حرکت نرم و تصادفی درون شعاع دایره
  void _startPhase2() {
    // _lastPhase2Offset اکنون مقداردهی شده است (یا از initState یا از انتهای انیمیشن قبلی)
    _lastPhase2Offset = _currentPhase2Offset;

    // تولید نقطه هدف تصادفی جدید (آفست از مرکز دایره)
    double theta = _random.nextDouble() * 2 * pi;
    double r = _random.nextDouble() * _circularRadius;
    
    Offset nextPhase2Offset = Offset(
      r * cos(theta),
      r * sin(theta),
    );
    
    // تعریف انیمیشن بین نقطه فعلی و نقطه هدف جدید
    // شروع انیمیشن فاز ۲ اکنون از نقطه‌ای است که فاز ۱ به آن رسیده‌ است
    _phase2Animation = Tween<Offset>(
      begin: _lastPhase2Offset,
      end: nextPhase2Offset,
    ).animate(CurvedAnimation(
      parent: _phase2Controller,
      curve: Curves.easeInOutSine, // منحنی نرم برای حرکت
    ));

    _phase2Controller.forward(from: 0.0);
  }

  @override
  void dispose() {
    _phase1Controller.dispose();
    _phase2Controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: Listenable.merge([_phase1Controller, _phase2Controller]),
      builder: (context, child) {
        Offset currentOffset;

        if (_phase1Controller.status != AnimationStatus.completed) {
          currentOffset = _phase1Animation.value;
        } else {
          // در فاز ۲، آفست فعلی درون دایره از انیمیشن جدید گرفته می‌شود
          _currentPhase2Offset = _phase2Animation.value;
          currentOffset = _baseOffset + _currentPhase2Offset;
        }

        return Transform.translate(
          offset: currentOffset,
          child: child,
        );
      },
      child: Image.asset(
        widget.imageAssetPath,
        width: widget.imageSize,
        height: widget.imageSize,
      ),
    );
  }
}
