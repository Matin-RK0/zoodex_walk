import 'package:flutter/material.dart';
import 'dart:math';

class SwipeFlipCardExample extends StatefulWidget {
  const SwipeFlipCardExample({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _SwipeFlipCardExampleState createState() => _SwipeFlipCardExampleState();
}

class _SwipeFlipCardExampleState extends State<SwipeFlipCardExample>
    with SingleTickerProviderStateMixin {
      
  late AnimationController _animationController;
  late Animation<double> _animation;
  double _dragPosition = 0;
  
  // متغیری برای ذخیره آخرین موقعیت کامل (0.0, 1.0, 2.0, ...)
  double _baseRotation = 0; 
  
  // تعریف _maxRotation به صورت نهایی (final) در سطح کلاس
  final double _maxRotation = 0.8; 

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 800),
    );

    _animation = Tween<double>(begin: 0, end: 0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    )..addListener(() {
      setState(() {
        _dragPosition = _animation.value;
      });
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }
  
  // **تابع کمکی جدید برای اجرای انیمیشن**
  void _animateTo(double endValue) {
    // از موقعیت فعلی به endValue انیمیشن اجرا شود
    _animation = Tween<double>(begin: _dragPosition, end: endValue).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    )..addListener(() {
      setState(() {
        _dragPosition = _animation.value;
      });
    });
      
    _animationController.forward(from: 0);
    
    _baseRotation = endValue;
  }
  
  void _toggleCard() {
    // 1. انیمیشن در حال اجرا را متوقف کنید
    _animationController.stop();
    
    // 2. موقعیت کامل فعلی (0.0, 1.0, 2.0, ...) را پیدا کنید
    double currentBase = _dragPosition.round().toDouble();
    
    // 3. اگر انیمیشن در حال حاضر در حالت Front (مثل 0.0, 2.0) بود، 
    // به حالت Back (1.0, 3.0) یا برعکس بروید.
    // به عبارت دیگر، مقدار کامل بعدی را پیدا کنید
    double nextValue;
    
    // اگر کارت تقریباً در نمای جلوی یک طرف است، به طرف دیگر بچرخانید
    if ((_dragPosition - currentBase).abs() < 0.01) {
      // برو به عدد صحیح بعدی در جهت چرخش پیش‌فرض (مثلاً +1)
      nextValue = currentBase + 1.0;
    } else {
      // اگر در میانه بود یا نزدیک به حالت قبلی، به نزدیکترین حالت کامل برگردید.
      // این بخش برای جلوگیری از پرش‌های غیرمنتظره در حین کشیدن است
      nextValue = currentBase;
    }
    
    _animateTo(nextValue);
  }

  void _onPanStart(DragStartDetails details) {
    _animationController.stop();
    
    // اصلاح کلیدی ۱: تعیین موقعیت کامل شروع
    // مقدار فعلی را به نزدیک‌ترین عدد صحیح گرد می‌کنیم. (مثلاً 1.0)
    _baseRotation = _dragPosition.round().toDouble();
    
    // _dragPosition را از موقعیت فعلی انیمیشن شروع می‌کنیم تا پرشی رخ ندهد.
    _dragPosition = _animation.value;
  }

  void _onPanUpdate(DragUpdateDetails details) {
    setState(() {
      // 1. محاسبه موقعیت جدید (با فرض چرخش معکوس: -=)
      _dragPosition -= details.delta.dx / 200;
      
      // 2. اصلاح کلیدی ۲: اعمال محدودیت (Clamp) بر اساس _baseRotation
      // _dragPosition فقط در محدوده [Base - 0.7, Base + 0.7] مجاز به حرکت است.
      _dragPosition = _dragPosition.clamp(
        _baseRotation - _maxRotation, 
        _baseRotation + _maxRotation,
      );
    });
  }

  void _onPanEnd(DragEndDetails details) {
    // محاسبه مقدار نهایی که باید به آن چرخید (نزدیک‌ترین عدد صحیح)
    double endValue;
    if ((_dragPosition - _baseRotation).abs() >= 0.5) {
      // برو به عدد صحیح بعدی در جهت حرکت
      endValue = _baseRotation + (_dragPosition - _baseRotation).sign;
    } else {
      // برگرد به عدد صحیح فعلی
      endValue = _baseRotation;
    }

    _animateTo(endValue);
  }

  @override
  Widget build(BuildContext context) {
    final angle = _dragPosition * pi;
    final normalizedAngle = angle.abs() % (2 * pi);
    final isFrontSide = normalizedAngle <= pi / 2 || normalizedAngle >= 3 * pi / 2;

    return Scaffold(
      appBar: AppBar(
        title: Text("Limited Interactive Flip Card"),
        backgroundColor: Colors.black87,
      ),
      backgroundColor: Colors.grey[900],
      body: Center(
        child: GestureDetector(
          onTap: _toggleCard, // **👈 تغییر اصلی ۱: اضافه کردن on Tap**
          onPanStart: _onPanStart,
          onPanUpdate: _onPanUpdate,
          onPanEnd: _onPanEnd,
          child: Transform(
            alignment: Alignment.center,
            transform: Matrix4.identity()
              ..setEntry(3, 2, 0.001)
              ..rotateY(angle),
            child: _buildCard(isFrontSide),
          ),
        ),
      ),
    );
  }

  Widget _buildCard(bool isFront) {
    return Container(
      width: 250,
      height: 400,
      decoration: BoxDecoration(
        color: isFront ? Colors.deepPurple : Colors.orange,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.5),
            blurRadius: 12,
            offset: Offset(0, 6),
          ),
        ],
      ),
      child: Transform(
        alignment: Alignment.center,
        // این Transform باعث می‌شود متن روی کارت پشت، برعکس دیده نشود
        transform: Matrix4.identity()..rotateY(isFront ? 0 : pi), 
        child: Center(
          child: Text(
            isFront ? "Front Side" : "Back Side",
            style: TextStyle(
              color: Colors.white,
              fontSize: 28,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}