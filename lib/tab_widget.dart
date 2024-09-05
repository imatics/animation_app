import 'package:animation_app/delayed_animation.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TabWidget extends StatefulWidget {
  const TabWidget({super.key, required this.controller});
  final TabController controller;

  @override
  State<TabWidget> createState() => _TabWidgetState();
}

class _TabWidgetState extends State<TabWidget> {
  final indexSelected = ValueNotifier<int>(0);
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(milliseconds: 100), () {
      indexSelected.value = widget.controller.index;
    });
    widget.controller.addListener(() {
      indexSelected.value = widget.controller.index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return tabBar();
  }

  Widget tabBar() {
    Map<String, int> tabData = {
      "All": 9,
      "Completed": 3,
      "In progress": 1,
      "Pending": 4
    };
    return DelayedAnimation(
        delay: 400,
        direction: Axis.horizontal,
        duration: Duration(milliseconds: 1200),
        child: TabBar(
            controller: widget.controller,
            isScrollable: true,
            tabAlignment: TabAlignment.start,
            indicatorWeight: 1,
            physics: const AlwaysScrollableScrollPhysics(),
            indicatorColor: Colors.yellow[900],
            tabs: tabData.keys.map((e) {
              return ValueListenableBuilder(
                  valueListenable: indexSelected,
                  builder: (context, selected, child) {
                    return TweenAnimationBuilder<double>(
                      tween: Tween(
                          begin: 0,
                          end: tabData.keys.elementAt(indexSelected.value) == e
                              ? 1
                              : 0),
                      duration: const Duration(milliseconds: 500),
                      builder:
                          (BuildContext context, double value, Widget? child) {
                        Color textColor =
                            Color.lerp(Colors.white60, Colors.white, value) ??
                                Colors.white;
                        Color containerColor = Color.lerp(
                                Colors.white60, Colors.amber[800], value) ??
                            Colors.white;
                        return Tab(
                          icon: Container(),
                          child: Row(
                            children: [
                              Text(
                                e,
                                style: TextStyle(color: textColor),
                              ),
                              Container(
                                margin: const EdgeInsets.only(left: 10),
                                padding: const EdgeInsets.symmetric(
                                    vertical: 0, horizontal: 10),
                                decoration: BoxDecoration(
                                    color: containerColor,
                                    borderRadius: BorderRadius.circular(20)),
                                child: Text(
                                  "${tabData[e]}",
                                  style: TextStyle(color: textColor),
                                ),
                              )
                            ],
                          ),
                        );
                      },
                    );
                  });
            }).toList()));
  }
}
