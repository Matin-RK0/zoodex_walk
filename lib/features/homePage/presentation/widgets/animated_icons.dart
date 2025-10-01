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
  
  late Random _random;

  Offset _baseOffset = Offset.zero;

  late double _circularRadius;
  late double _circularFrequency;
  late double _phase2DurationSeconds;

  static const double cardWidth = 300.0;
  static const double cardHeight = 400.0;

  @override
  void initState() {
    super.initState();
    _random = Random();

    _circularRadius = _random.nextDouble() * 5.0 + 5.0;
    
    _circularFrequency = (_random.nextInt(2) + 1).toDouble(); 
    
    _phase2DurationSeconds = _random.nextDouble() * 2.0 + 3.5; 

    double randomX = _random.nextDouble() * 10 + cardWidth / 2;
    double randomY = _random.nextDouble() * 10 + cardHeight / 2;
    if (_random.nextBool()) randomX *= -1;
    if (_random.nextBool()) randomY *= -1;
    
    _baseOffset = Offset(randomX, randomY); 

    final targetOffsetPhase1 = _baseOffset + Offset(_circularRadius, 0);


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
  }

  void _startPhase2() {
    _phase2Controller.repeat();
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
          double angle = _phase2Controller.value * 2 * pi;
          
          Offset phase2SmallOffset = Offset(
            _circularRadius * cos(angle * _circularFrequency),
            _circularRadius * sin(angle * _circularFrequency),
          );

          currentOffset = _baseOffset + phase2SmallOffset;
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