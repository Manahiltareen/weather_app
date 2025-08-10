import 'package:flutter/material.dart';
import 'dart:math' as math;

class FlipzySplash extends StatefulWidget {
  final Widget nextScreen;

  const FlipzySplash({super.key, required this.nextScreen});

  @override
  State<FlipzySplash> createState() => _FlipzySplashState();
}

class _FlipzySplashState extends State<FlipzySplash> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );
    _animation = Tween<double>(begin: 0, end: math.pi * 2).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeInOutBack,
      ),
    );
    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (_) => widget.nextScreen),
        );
      }
    });

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFf0f0f0),
      body: Center(
        child: AnimatedBuilder(
          animation: _animation,
          builder: (context, child) {
            return Transform(
              alignment: Alignment.center,
              transform: Matrix4.identity()
                ..setEntry(3, 2, 0.001)
                ..rotateX(_animation.value),
              child: Text(
                'FLIPZY',
                style: TextStyle(
                  fontSize: 64,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue[800],
                  letterSpacing: 2,
                  fontFamily: 'OpenSans'
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

