import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';



class AnimatedCloseButton extends StatefulWidget {
  const AnimatedCloseButton({super.key, this.waitTime, required this.onclick});
  final Function() onclick;
  final Duration? waitTime;

  @override
  State<AnimatedCloseButton> createState() => _AnimatedCloseButtonState();
}

class _AnimatedCloseButtonState extends State<AnimatedCloseButton> {

  final _animationValue = ValueNotifier<double>(0.0);
  @override
  void initState() {
    super.initState();
    Future.delayed(widget.waitTime??const Duration(milliseconds: 200), () {
      if (mounted) {
        _animationValue.value = 1;
      }
    });
  }


  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<double>(
      valueListenable: _animationValue,
      builder: (context, value, child) => TweenAnimationBuilder<double>(
        tween: Tween(begin: 0, end: value),
        duration: const Duration(milliseconds: 300),
        curve: Curves.decelerate,
        builder: (context, animation, child) {
          double x = lerpDouble(-15, 0, animation) ?? 0.0;
          double y = lerpDouble(-10, 0, animation) ?? 0.0;
          return Container(
            transform: Matrix4.translationValues(x, y, 0),
            child: Opacity(
              opacity: animation,
              child: BackButton(
                color: Colors.white,
                onPressed: widget.onclick,
              ),
            ),
          );
        },
      ),
    );
  }
}
