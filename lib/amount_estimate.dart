import 'dart:async';
import 'dart:ui';

import 'package:animation_app/animated_on_tap.dart';
import 'package:animation_app/delayed_animation.dart';
import 'package:flutter/material.dart';

import 'dashboard.dart';

class AmountEstimateScreen extends StatelessWidget {
  const AmountEstimateScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _build(context),
    );
  }

  Widget _build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          DelayedAnimation(
            delay: 200,
            child: Image.asset("assets/move_mate.png", height: 100,),
          ),
          TweenAnimationBuilder(
              duration: Duration(milliseconds: 1500),
              tween: Tween<double>(begin: 0, end: 1),
              builder: (context, animation, child) {
                return Opacity(
                  opacity: animation,
                  child: Container(
                    transform: Matrix4.translationValues(
                        0, lerpDouble(50, 0, animation) ?? 0.0, 0),
                    child: AspectRatio(
                        aspectRatio: 1.5,
                        child: Image.asset(
                          "assets/parcel_big.png",
                        )),
                  ),
                );
              }),
          DelayedAnimation(
            delay: 100,
            duration: Duration(milliseconds: 1200),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "Total Estimated Total Amount",
                style: TextStyle(fontSize: 20),
              ),
            ),
          ),
          DelayedAnimation(
              duration: Duration(milliseconds: 1200),
              delay: 200, child: GrowingAmount(amount: 1425)),
          DelayedAnimation(
            delay: 300,
            duration: Duration(milliseconds: 1200),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "This amount is estimated this will vary \nif you change your location or weight",
                style: TextStyle(fontSize: 14, color: Colors.grey, height: 1.2),
              ),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          DelayedAnimation(
            delay: 500,
            child: SizedBox(
              height: 55,
              width: double.infinity,
              child: AnimatedOnTap(
                onTap: () {
                  Navigator.pushAndRemoveUntil(
                      context,
                      PageRouteBuilder(
                        pageBuilder: (context, animation, secondaryAnimation) =>
                            const Dashboard(),
                        transitionDuration: Duration(milliseconds: 1000),
                        transitionsBuilder:
                            (context, animation, secondaryAnimation, child) {
                          return FadeTransition(
                            child: child,
                            opacity: animation,
                          );
                        },
                      ),
                      (_) => false);
                },
                child: Container(
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(25),
                    color: Colors.yellow[900],
                  ),
                  child: Text(
                    "Back to home",
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                        fontSize: 18),
                  ),
                ),
              ),
            ),
          ),
          SizedBox(
            height: 50,
          ),
        ],
      ),
    );
  }
}

class GrowingAmount extends StatefulWidget {
  const GrowingAmount(
      {super.key,
      required this.amount,
      this.duration = const Duration(milliseconds: 1000)});
  final int amount;
  final Duration duration;

  @override
  State<GrowingAmount> createState() => _GrowingAmountState();
}

class _GrowingAmountState extends State<GrowingAmount> {
  final amountValue = ValueNotifier(0);

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    int sequence =
        ((widget.amount * 0.8) / (widget.duration.inMilliseconds / 11)).toInt();
    Future.delayed(Duration(milliseconds: 200), () {
      Timer.periodic(Duration(milliseconds: 50), (timer) {
        int current = sequence * timer.tick;
        if ((amountValue.value + current) > widget.amount) {
          amountValue.value = widget.amount;
        } else {
          amountValue.value = amountValue.value + sequence;
        }
        if (amountValue.value == widget.amount) {
          timer.cancel();
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: amountValue,
      builder: (context, value, child) => RichText(
          text: TextSpan(
              children: [
            TextSpan(text: "\$${value}", style: TextStyle(fontSize: 35)),
            TextSpan(text: " USD")
          ],
              style: TextStyle(
                  color: Colors.green,
                  fontWeight: FontWeight.w400,
                  fontSize: 25))),
    );
  }
}
