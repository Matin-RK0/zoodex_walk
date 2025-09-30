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

  double _baseRotation = 0;

  final double _maxRotation = 0.8;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 600),
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

  void _animateTo(double endValue) {
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
    _animationController.stop();

    double currentBase = _dragPosition.round().toDouble();
    double nextValue;

    if ((_dragPosition - currentBase).abs() < 0.01) {
      nextValue = currentBase + 1.0;
    } else {
      nextValue = currentBase;
    }

    _animateTo(nextValue);
  }

  void _onPanStart(DragStartDetails details) {
    _animationController.stop();

    _baseRotation = _dragPosition.round().toDouble();
    _dragPosition = _animation.value;
  }
  
  void _onPanUpdate(DragUpdateDetails details) {
    setState(() {
      _dragPosition -= details.delta.dx / 320;

      _dragPosition = _dragPosition.clamp(
        _baseRotation - _maxRotation,
        _baseRotation + _maxRotation,
      );
    });
  }

  void _onPanEnd(DragEndDetails details) {
    double endValue;
    if ((_dragPosition - _baseRotation).abs() >= 0.5) {
      endValue = _baseRotation + (_dragPosition - _baseRotation).sign;
    } else {
      endValue = _baseRotation;
    }

    _animateTo(endValue);
  }

  @override
  Widget build(BuildContext context) {
    final angle = _dragPosition * pi;
    final normalizedAngle = angle.abs() % (2 * pi);
    final isFrontSide =
        normalizedAngle <= pi / 2 || normalizedAngle >= 3 * pi / 2;

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          surfaceTintColor: Colors.white,
          centerTitle: true,
          title: const Text(
            'پیش نمایش',
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
        body: Center(
          child: GestureDetector(
            onTap: _toggleCard,
            onPanStart: _onPanStart,
            onPanUpdate: _onPanUpdate,
            onPanEnd: _onPanEnd,
            child: Transform(
              alignment: Alignment.center,
              transform:
                  Matrix4.identity()
                    ..setEntry(3, 2, 0.001)
                    ..rotateY(angle),
              child: _buildCard(isFrontSide),
            ),
          ),
        ),
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.all(24.0),
          child: SizedBox(
            width: double.infinity,
            height: 50,
            child: ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xff3a4ba8),
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
              ),
              child: Text("ویرایش", style: TextStyle(fontSize: 18)),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildCard(bool isFront) {
    return Container(
       margin: const EdgeInsets.symmetric(horizontal: 70, vertical: 140),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xffFEF1C7), Color(0xffFFFFF8)],
        ),
        boxShadow: const [
          BoxShadow(color: Colors.black26, blurRadius: 5, offset: Offset(0, 1)),
        ],
      ),
      child: Transform(
        alignment: Alignment.center,
        transform: Matrix4.identity()..rotateY(isFront ? 0 : pi),
        child: Center(
          child: isFront ? Padding(
            padding: const EdgeInsets.all(40),
            child: Image.asset(    
              'assets/10.png',
              fit: BoxFit.cover,
            ),
          ) : Text('تولدت مبارک فلانی',
            style: TextStyle(
              color: Colors.black,
              fontSize: 26,
            ),
          )
        ),
      ),
    );
  }
}
