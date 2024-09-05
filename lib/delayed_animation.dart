import 'package:flutter/material.dart';

class DelayedAnimation extends StatefulWidget {
  final Widget? child;
  final int? delay;
  final Duration duration;
  final Axis direction;

  const DelayedAnimation({
    super.key,
    @required this.child,
    @required this.delay,
   this.duration = const Duration(milliseconds: 600),
   this.direction = Axis.vertical
  });

  @override
  _DelayedAnimationState createState() => _DelayedAnimationState();
}

class _DelayedAnimationState extends State<DelayedAnimation>
    with SingleTickerProviderStateMixin {
  AnimationController? _animationController;
  Animation<double>? _animation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: widget.duration,
    );
    _animation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: _animationController!,
        curve: Interval(widget.delay! / 1000, 1.0, curve: Curves.decelerate),
      ),
    );
    _animationController!.forward();
  }

  @override
  void dispose() {
    _animationController!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animationController!,
      builder: (context, child) {
        double x = 0.0;
        double y = 0.0;

        if(widget.direction == Axis.vertical){
          y = 50.0 * (1 - _animation!.value);
        }else{
          x = 50.0 * (1 - _animation!.value);
        }
        return Opacity(
          opacity: _animation!.value,
          child: Transform.translate(
            offset: Offset(x, y),
            child: child,
          ),
        );
      },
      child: widget.child,
    );
  }
}
