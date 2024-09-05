import 'package:flutter/cupertino.dart';

class AnimatedOnTap extends StatefulWidget {
  const AnimatedOnTap(
      {super.key,
      required this.child,
      required this.onTap,
      this.duration = const Duration(milliseconds: 1500)});
  final Widget child;
  final Duration duration;
  final Function onTap;

  @override
  State<AnimatedOnTap> createState() => _AnimatedOnTapState();
}

class _AnimatedOnTapState extends State<AnimatedOnTap>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;
  bool shrinkState = true;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: widget.duration,
    );
    _animation = TweenSequence(<TweenSequenceItem<double>>[
      TweenSequenceItem(tween: Tween<double>(begin: 1, end: 0.95), weight: 20),
      TweenSequenceItem(
          tween: Tween<double>(begin: 0.95, end: 1.06), weight: 40),
      TweenSequenceItem(tween: Tween<double>(begin: 1.06, end: 1), weight: 30),
    ]).animate(CurvedAnimation(
      parent: _animationController,
      curve: const Interval(0, 1.0, curve: Curves.decelerate),
    ));
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        _animationController.reset();
        _animationController.forward();
        widget.onTap.call();
      },
      child: ScaleTransition(scale: _animation, child: widget.child),
    );
  }
}
