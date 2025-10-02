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
  late Animation<double> _phase1RotationAnimation; // انیمیشن چرخش فاز ۱

  late AnimationController _phase2Controller;
  late Animation<Offset> _phase2Animation;
  late Animation<double> _rotationAnimation;

  late Random _random;

  Offset _baseOffset = Offset.zero;
  Offset _currentPhase2Offset = Offset.zero;
  Offset _lastPhase2Offset = Offset.zero;

  late double _circularRadius;
  late double _phase2DurationSeconds;
  
  double _currentRotation = 0.0;
  double _initialRotation = 0.0; // زاویه تصادفی اولیه

  static const double cardWidth = 310.0;
  static const double cardHeight = 410.0;

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

    // محدودهٔ کلی (حداکثر فاصله از مرکز)
    final double maxX = cardHalfWidth + outerMargin;
    final double maxY = cardHalfHeight + outerMargin;

    // ردگیری تلاش‌ها برای جلوگیری از لوپ بی‌نهایت (fail-safe)
    int tries = 0;
    do {
      // انتخاب تصادفی در بازه [-maxX, maxX] و [-maxY, maxY]
      randomX = (_random.nextDouble() * 2 - 1) * maxX;
      randomY = (_random.nextDouble() * 2 - 1) * maxY;
      tries++;

      if (tries > 100) {
        // اگر خیلی تلاش کردیم (نباید پیش بیاد)، یکی از محورها را اجباری خارج می‌کنیم
        if (randomX.abs() <= cardHalfWidth && randomY.abs() <= cardHalfHeight) {
          if (_random.nextBool()) {
            randomX = (randomX >= 0 ? 1 : -1) * maxX;
          } else {
            randomY = (randomY >= 0 ? 1 : -1) * maxY;
          }
        }
        break;
      }
    } while (randomX.abs() <= cardHalfWidth && randomY.abs() <= cardHalfHeight);

    // الآن حتماً نقطه خارج از کارت است
    _baseOffset = Offset(randomX, randomY);

    // شروع فاز ۱ (حرکت از مرکز تا نزدیکی مقصد)
    final Offset initialPhase2Offset = Offset(_circularRadius, 0);
    final targetOffsetPhase1 = _baseOffset + initialPhase2Offset;

    _currentPhase2Offset = initialPhase2Offset;
    _lastPhase2Offset = initialPhase2Offset;

    _phase1Controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    );

    _phase1Animation = Tween<Offset>(
      begin: Offset.zero,
      end: targetOffsetPhase1,
    ).animate(
      CurvedAnimation(parent: _phase1Controller, curve: Curves.easeInOutBack),
    );

    // --- تنظیم چرخش تصادفی اولیه و انیمیشن فاز ۱ ---
    _initialRotation = _random.nextDouble() * 2 * pi; // زاویه تصادفی اولیه (0 تا 360 درجه)
    
    _phase1RotationAnimation = Tween<double>(
      begin: _initialRotation,
      // در طول فاز ۱ یک چرخش کامل یا بخشی از آن را اضافه می‌کنیم
      end: _initialRotation + (_random.nextBool() ? 2 * pi : -2 * pi), 
    ).animate(
      CurvedAnimation(parent: _phase1Controller, curve: Curves.easeInOut),
    );
    // --------------------------------------------------

    _phase1Controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        // زاویه چرخش در انتهای فاز ۱ را به عنوان زاویه شروع فاز ۲ تنظیم می‌کنیم
        _currentRotation = _phase1RotationAnimation.value; 
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
        _currentRotation = _rotationAnimation.value;
        _startPhase2();
      }
    });
    
    _rotationAnimation = Tween<double>(
      begin: 0.0,
      end: 0.0, 
    ).animate(
      CurvedAnimation(parent: _phase2Controller, curve: Curves.easeInOutSine),
    );
  }

  void _startPhase2() {
    _lastPhase2Offset = _currentPhase2Offset;

    double theta = _random.nextDouble() * 2 * pi;
    double r = _random.nextDouble() * _circularRadius;

    Offset nextPhase2Offset = Offset(r * cos(theta), r * sin(theta));

    _phase2Animation = Tween<Offset>(
      begin: _lastPhase2Offset,
      end: nextPhase2Offset,
    ).animate(
      CurvedAnimation(parent: _phase2Controller, curve: Curves.easeInOutSine),
    );

    // تعیین انیمیشن برای چرخش فاز ۲
    final double angleDelta = (_random.nextDouble() * 2 - 1) * pi;
    
    _rotationAnimation = Tween<double>(
      begin: _currentRotation,
      end: _currentRotation + angleDelta,
    ).animate(
      CurvedAnimation(parent: _phase2Controller, curve: Curves.easeInOutSine),
    );

    _phase2DurationSeconds = _random.nextDouble() * 1.0 + 2.0;
    _phase2Controller.duration = Duration(milliseconds: (_phase2DurationSeconds * 1000).toInt());

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
        double rotationAngle;

        if (_phase1Controller.status != AnimationStatus.completed) {
          // فاز ۱: جابجایی و چرخش فاز ۱
          currentOffset = _phase1Animation.value;
          rotationAngle = _phase1RotationAnimation.value; // استفاده از انیمیشن چرخش فاز ۱
        } else {
          // فاز ۲: جابجایی و چرخش فاز ۲
          _currentPhase2Offset = _phase2Animation.value;
          currentOffset = _baseOffset + _currentPhase2Offset;
          rotationAngle = _rotationAnimation.value; 
        }

        return Transform.translate(
          offset: currentOffset,
          child: Transform.rotate(
            angle: rotationAngle, // چرخش بر حسب رادیان
            child: child,
          ),
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