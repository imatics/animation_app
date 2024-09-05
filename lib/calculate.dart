import 'dart:ui';

import 'package:animation_app/amount_estimate.dart';
import 'package:animation_app/animated_on_tap.dart';
import 'package:animation_app/delayed_animation.dart';
import 'package:flutter/material.dart';

class CalculatePage extends StatefulWidget {
  const CalculatePage({super.key, required this.onClose});
  final Function onClose;

  @override
  State<CalculatePage> createState() => _CalculatePageState();
}

class _CalculatePageState extends State<CalculatePage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(const Duration(milliseconds: 50), () {
      setState(() {});
    });
  }

  Widget titleWidget(String text) {
    return Padding(
      padding: const EdgeInsets.only(top: 15, bottom: 5),
      child: Text(
        text,
        style: const TextStyle(
            fontSize: 19,
            fontWeight: FontWeight.w500,
            color: Color(0xFF140E2B)),
      ),
    );
  }

  Widget sunTitleWidget(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Text(
        text,
        style: TextStyle(
            fontSize: 17,
            fontWeight: FontWeight.normal,
            color: Colors.grey[600]),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                titleWidget("Destination"),
                Material(
                  color: Colors.white,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15)),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 15, vertical: 20),
                    child: Column(
                      children: [
                        DelayedAnimation(
                            duration: const Duration(milliseconds: 1500),
                            delay: 200,
                            child: buildInput(
                                "Sender location", "assets/out.png")),
                        const SizedBox(
                          height: 5,
                        ),
                        DelayedAnimation(
                            duration: const Duration(milliseconds: 1500),
                            delay: 300,
                            child: buildInput(
                                "Receiver location", "assets/in.png")),
                        const SizedBox(
                          height: 5,
                        ),
                        DelayedAnimation(
                            duration: const Duration(milliseconds: 1500),
                            delay: 400,
                            child: buildInput(
                                "Approx weight", "assets/wine_stuff.png")),
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                titleWidget("Packaging"),
                sunTitleWidget(
                  "What are you sending?",
                ),
                Material(
                  color: Colors.white,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  child: Row(
                    children: [
                      Image.asset(
                        "assets/parcel.png",
                        height: 50,
                      ),
                      Container(
                        height: 40,
                        color: Colors.grey[400],
                        width: 1,
                        margin: const EdgeInsets.symmetric(vertical: 10),
                      ),
                      const Padding(
                        padding: EdgeInsets.only(left: 10),
                        child: Text(
                          "Box",
                          style: TextStyle(
                              fontWeight: FontWeight.w600, fontSize: 16),
                        ),
                      ),
                      const Spacer(),
                      const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        child: Icon(
                          Icons.keyboard_arrow_down,
                          size: 25,
                          color: Colors.grey,
                        ),
                      )
                    ],
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                titleWidget("Category"),
                sunTitleWidget(
                  "What are you sending?",
                ),
                optionWidget(),
                const SizedBox(
                  height: 30,
                ),
                SizedBox(
                  height: 55,
                  width: double.infinity,
                  child: AnimatedOnTap(
                    onTap: () {
                      Future.delayed(const Duration(milliseconds: 1000),(){
                        Navigator.push(
                            context,
                            PageRouteBuilder(
                              pageBuilder: (context, animation, secondaryAnimation) =>
                              const AmountEstimateScreen(),
                              transitionsBuilder:
                                  (context, animation, secondaryAnimation, child) {
                                return FadeTransition(
                                  child: child,
                                  opacity: animation,
                                );
                              },
                            ));
                      });

                    },
                    child: Container(
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(25),
                        color: Colors.yellow[900],
                      ),
                      child: const Text(
                        "Calculate",
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w500,
                            fontSize: 18),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 150,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  List<String> options = [
    "Documents",
    "Glass",
    "Liquid",
    "Food",
    "Electronic",
    "Product",
    "Others"
  ];

  final selected = ValueNotifier("");
  Widget optionWidget() {
    return Wrap(
      children: options.map((e) {
        return DelayedAnimation(
          delay: 100 * (options.indexOf(e) + 1),
          direction: Axis.horizontal,
          duration: const Duration(milliseconds: 1200),
          child: AnimatedOnTap(
            onTap: () {
              if (selected.value == e) {
                selected.value = "";
              } else {
                selected.value = e;
              }
            },
            child: ValueListenableBuilder<String>(
              valueListenable: selected,
              builder: (context, value, _) => TweenAnimationBuilder<double>(
                tween: Tween(begin: 0, end: value == e ? 1 : 0),
                builder: (context, animation, __) => Container(
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey, width: 0.9),
                      borderRadius: BorderRadius.circular(8),
                      color: Color.lerp(
                          Colors.white, const Color(0xFF140E2B), animation)),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  margin:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      AnimatedSwitcher(
                          transitionBuilder: (child, animation2) =>
                              SizeTransition(
                                sizeFactor: animation2.drive(CurveTween(
                                    curve: const Interval(0.6, 1.0,
                                        curve: Curves.decelerate))),
                                axis: Axis.horizontal,
                                child: FadeTransition(
                                    child: child, opacity: animation2),
                              ),
                          duration: const Duration(milliseconds: 600),
                          child: value == e
                              ? Padding(
                                  padding:
                                      const EdgeInsets.symmetric(horizontal: 4),
                                  child: Icon(
                                    Icons.done,
                                    size: 15,
                                    color: Color.lerp(const Color(0xFF140E2B),
                                        Colors.white, animation),
                                  ),
                                )
                              : const SizedBox()),
                      Text(e,
                          style: TextStyle(
                              fontSize: 16,
                              color: Color.lerp(
                                  const Color(0xFF140E2B), Colors.white, animation))),
                    ],
                  ),
                ),
                duration: const Duration(milliseconds: 800),
              ),
            ),
          ),
        );
      }).toList(),
    );
  }

  Widget buildInput(String hint, String image) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(10),
      ),
      child: TextFormField(
        textAlignVertical: TextAlignVertical.center,
        style: TextStyle(
            fontSize: 18, fontWeight: FontWeight.w400, color: Colors.grey[900]),
        decoration: InputDecoration(
            fillColor: Colors.transparent,
            filled: true,
            contentPadding: EdgeInsets.zero,
            border: InputBorder.none,
            hintText: hint,
            hintStyle: TextStyle(
                color: Colors.grey[500],
                fontWeight: FontWeight.w400,
                fontSize: 18),
            prefixIcon: SizedBox(
              width: 60,
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 6.0, horizontal: 10),
                    child: Image.asset(
                      image,
                      height: 30,
                      width: 30,
                    ),
                  ),
                  Container(
                    height: 30,
                    color: Colors.grey[400],
                    width: 1,
                    margin: const EdgeInsets.symmetric(vertical: 10),
                  ),
                ],
              ),
            )),
      ),
    );
  }
}
