import 'dart:async';
import 'dart:math' as math;

import 'package:flutter/material.dart';

import '../../../../app/routes.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  Timer? _navigationTimer;

  @override
  void initState() {
    super.initState();
    _navigationTimer = Timer(const Duration(seconds: 2), () {
      if (!mounted) {
        return;
      }
      Navigator.of(context).pushReplacementNamed(AppRoutes.home);
    });
  }

  @override
  void dispose() {
    _navigationTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 24),
            child: _SplashContent(),
          ),
        ),
      ),
    );
  }
}

class _SplashContent extends StatelessWidget {
  const _SplashContent();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: const [
        Spacer(flex: 10),
        _BrandMark(),
        Spacer(flex: 5),
        _DotLoader(),
        Spacer(flex: 3),
      ],
    );
  }
}

class _BrandMark extends StatelessWidget {
  const _BrandMark();

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: const [
        _OnTimeLogoGlyph(),
        SizedBox(width: 10),
        Padding(
          padding: EdgeInsets.only(bottom: 5),
          child: Text(
            'nTime',
            style: TextStyle(
              fontSize: 35,
              height: 1,
              fontWeight: FontWeight.w500,
              color: Color(0xFF1E1E1E),
              letterSpacing: -1.2,
            ),
          ),
        ),
      ],
    );
  }
}

class _OnTimeLogoGlyph extends StatelessWidget {
  const _OnTimeLogoGlyph();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 40,
      height: 56,
      child: Stack(
        children: const [
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: _LogoStroke(
              color: Color(0xFF1E1E1E),
              rotation: -0.06,
              shadow: [
                BoxShadow(
                  color: Color(0x14000000),
                  blurRadius: 4,
                  offset: Offset(0, 2),
                ),
              ],
            ),
          ),
          Positioned(
            left: 6,
            top: 0,
            child: _LogoStroke(
              color: Color(0xFFFAA328),
              rotation: 0.08,
            ),
          ),
          Positioned(
            left: 14,
            top: 18,
            child: DecoratedBox(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(999)),
              ),
              child: SizedBox(width: 11, height: 28),
            ),
          ),
        ],
      ),
    );
  }
}

class _LogoStroke extends StatelessWidget {
  const _LogoStroke({
    required this.color,
    required this.rotation,
    this.shadow,
  });

  final Color color;
  final double rotation;
  final List<BoxShadow>? shadow;

  @override
  Widget build(BuildContext context) {
    return Transform.rotate(
      angle: rotation,
      child: Container(
        width: 26,
        height: 45,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(999),
          border: Border.all(color: color, width: 8),
          boxShadow: shadow,
        ),
      ),
    );
  }
}

class _DotLoader extends StatefulWidget {
  const _DotLoader();

  @override
  State<_DotLoader> createState() => _DotLoaderState();
}

class _DotLoaderState extends State<_DotLoader>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1100),
    )..repeat();
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
      builder: (context, _) {
        return SizedBox(
          width: 52,
          height: 52,
          child: Stack(
            children: List.generate(8, (index) {
              final angle = ((math.pi * 2) / 8) * index - (math.pi / 2);
              final radius = 17.0;
              final progress = (_controller.value * 8 - index) % 8;
              final isActive = progress >= 0 && progress < 1;

              return Positioned(
                left: 26 + math.cos(angle) * radius - 4,
                top: 26 + math.sin(angle) * radius - 4,
                child: Container(
                  width: isActive ? 8 : 7,
                  height: isActive ? 8 : 7,
                  decoration: BoxDecoration(
                    color: isActive
                        ? const Color(0xFFFAA328)
                        : const Color(0xFFD8DEE8),
                    shape: BoxShape.circle,
                  ),
                ),
              );
            }),
          ),
        );
      },
    );
  }
}
