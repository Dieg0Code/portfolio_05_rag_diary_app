import 'package:flutter/material.dart';

class AnimatedDots extends StatefulWidget {
  const AnimatedDots({super.key});

  @override
  _AnimatedDotsState createState() => _AnimatedDotsState();
}

class _AnimatedDotsState extends State<AnimatedDots>
    with TickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<int> _dotAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    )..repeat();
    _dotAnimation = StepTween(begin: 0, end: 3).animate(_controller);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        String dots = '.' * _dotAnimation.value;
        return Text(
          'Escribiendo$dots',
          style: const TextStyle(fontSize: 16, color: Colors.black54),
        );
      },
    );
  }
}
