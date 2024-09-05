import 'dart:ui';

import 'package:animation_app/animated_close_icon_button.dart';
import 'package:animation_app/bottom_bar.dart';
import 'package:animation_app/calculate.dart';
import 'package:animation_app/delayed_animation.dart';
import 'package:animation_app/home_page.dart';
import 'package:animation_app/list_obsever.dart';
import 'package:animation_app/search_page.dart';
import 'package:animation_app/shipment.dart';
import 'package:animation_app/tab_widget.dart';
import 'package:animations/animations.dart';
import 'package:flutter/material.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> with TickerProviderStateMixin {
  final showBackButton = ValueNotifier<bool>(false);
  final showTab = ValueNotifier<bool>(false);
  final searchState = ValueNotifier<bool>(false);
  late BottomBarController _bottomBarController;
  late FocusNode focusNode;
  AnimationController? _animationController;
  Animation<double>? _animation;
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
    _animation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: _animationController!,
        curve: const Interval(1, 1.0, curve: Curves.decelerate),
      ),
    );
    _bottomBarController = BottomBarController(null)
      ..onPageChange((index) {
        showTab.value = index == 2;
        if (index != 0) {
          _bottomBarController.hide(shadow: index == 2);
        }
      });
    focusNode = FocusNode();
    focusNode.addListener(() {
      if (focusNode.hasFocus) {
        gotoSearch();
      } else {
        gotoHome();
      }
    });
    showBackButton.addListener(() {});
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Container(
        color: Colors.orange,
        child: WillPopScope(
          onWillPop: () async {
            if (showBackButton.value ||
                _bottomBarController.selectedIndex != 0) {
              gotoHome();
              return showBackButton.value;
            }
            return true;
          },
          child: ValueListenableBuilder(
              valueListenable: MultiValueObserver([showBackButton, showTab]),
              builder: (context, value, _) {
                return TweenAnimationBuilder<double>(
                  curve: Curves.decelerate,
                  tween: Tween(begin: 0, end: showBackButton.value ? 1 : 0),
                  builder: (context, animation, child) {
                    return Scaffold(
                      backgroundColor: Colors.grey[100],
                      appBar: PreferredSize(
                        preferredSize: Size.fromHeight(lerpDouble(
                                155, showTab.value ? 125 : 90, animation) ??
                            0.0),
                        child: AppBar(
                          titleSpacing: 20,
                          toolbarHeight: lerpDouble(85, 0, animation),
                          title: AnimatedOpacity(
                            duration: Duration(
                                milliseconds: showBackButton.value ? 200 : 500),
                            opacity: showBackButton.value ? 0 : 1,
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Row(
                                  children: [
                                    const CircleAvatar(
                                      minRadius: 25,
                                    ),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: [
                                            Transform.rotate(
                                                angle: 7,
                                                child: const Icon(
                                                  Icons.navigation,
                                                  size: 15,
                                                  color: Colors.white,
                                                )),
                                            const Text("Your location",
                                                style: TextStyle(
                                                    fontSize: 14,
                                                    color: Colors.white)),
                                          ],
                                        ),
                                        const Text(
                                          "Wertheimer, Illinois",
                                          style: TextStyle(
                                              fontSize: 18,
                                              color: Colors.white),
                                        )
                                      ],
                                    )
                                  ],
                                ),
                                const Spacer(),
                                SizedBox(
                                  height: 45,
                                  width: 45,
                                  child: MaterialButton(
                                      padding: const EdgeInsets.all(0),
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(100)),
                                      color: Colors.white,
                                      onPressed: () {},
                                      child: const Icon(
                                          Icons.notifications_none_outlined,
                                          color: Colors.black)),
                                )
                              ],
                            ),
                          ),
                          backgroundColor: const Color(0xff44349e),
                          bottom: PreferredSize(
                            preferredSize: const Size.fromHeight(100),
                            child: Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(
                                      bottom: 0, right: 10, left: 10),
                                  child: Row(
                                    children: [
                                      AnimatedContainer(
                                        width: showBackButton.value ? 50 : 0.0,
                                        duration:
                                            const Duration(milliseconds: 300),
                                        child: showBackButton.value
                                            ? SizedBox(
                                                width: 50,
                                                height: 50,
                                                child: AnimatedCloseButton(
                                                  onclick: () {
                                                    gotoHome();
                                                  },
                                                ),
                                              )
                                            : const SizedBox(),
                                      ),
                                      Expanded(
                                        child: ValueListenableBuilder(
                                          valueListenable: searchState,
                                          builder: (context, state, __) =>
                                              InkWell(
                                            splashColor: Colors.transparent,
                                            highlightColor: Colors.transparent,
                                            splashFactory: NoSplash.splashFactory,
                                            onTap: () {
                                              if (!state &&
                                                  _bottomBarController
                                                          .selected.value ==
                                                      0) {
                                                gotoSearch();
                                              }
                                            },
                                            child: IgnorePointer(
                                              ignoring: !state,
                                              child: _buildAppBarSegment(),
                                            ),
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                                AnimatedSwitcher(
                                  transitionBuilder: (child, animation2) =>
                                      SizeTransition(
                                    sizeFactor: animation2,
                                    axis: Axis.vertical,
                                    child: FadeTransition(
                                        opacity: animation2, child: child),
                                  ),
                                  duration: const Duration(milliseconds: 400),
                                  child: showTab.value
                                      ? SizedBox(
                                          key: const ValueKey("1234"),
                                          height: 50,
                                          child: TabWidget(
                                            controller: _tabController,
                                          ),
                                        )
                                      : const SizedBox(
                                          key: ValueKey("4321"),
                                          height: 15,
                                        ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      body: _buildBody(context),
                    );
                  },
                  duration: const Duration(milliseconds: 400),
                );
              }),
        ),
      ),
    );
  }

  Widget _buildBody(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height - 85,
      child: Stack(
        children: [
          _mainBody(),
          Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: BottomBar(controller: _bottomBarController))
        ],
      ),
    );
  }

  Widget _mainBody() {
    return ValueListenableBuilder<dynamic>(
        valueListenable:
            MultiValueObserver([_bottomBarController.selected, searchState]),
        builder: (context, _, __) {
          int index = _bottomBarController.selected.value;
          Widget? child;
          if (searchState.value) {
            child = const SearchPage();
          } else {
            switch (index) {
              case 0:
                child = const HomePage();
              case 1:
                child = CalculatePage(
                  key: const ValueKey("dashboard"),
                  onClose: () {
                    gotoHome();
                  },
                );
              case 2:
                child = ShipmentPage(
                  controller: _tabController,
                );
              case 4:
                child = const SizedBox();
            }
          }

          return PageTransitionSwitcher(
              duration: const Duration(milliseconds: 800),
              child: DelayedAnimation(
                  key: ValueKey(index),
                  delay: 500,
                  duration: const Duration(milliseconds: 1100),
                  child: child),
              transitionBuilder: (
                Widget child,
                Animation<double> animation,
                Animation<double> secondaryAnimation,
              ) {
                return SharedAxisTransition(
                  transitionType: SharedAxisTransitionType.vertical,
                  animation: animation,
                  secondaryAnimation: secondaryAnimation,
                  fillColor: Colors.grey[100],
                  child: child,
                );
              });
        });
  }


  void gotoHome() {
    FocusScope.of(context).requestFocus(FocusNode());
    _bottomBarController.selectedIndex = 0;
    _bottomBarController.show();
    showBackButton.value = false;
    searchState.value = false;
    showTab.value = false;
  }

  void gotoShipment() {
    showTab.value = true;
    searchState.value = false;
  }

  void gotoCalculator() {
    searchState.value = false;
    showTab.value = false;
  }

  void gotoSearch() {
    searchState.value = true;
    showTab.value = false;
    _bottomBarController.hide();
    showBackButton.value = true;
    Future.delayed(const Duration(milliseconds: 800), () {
      FocusScope.of(context).requestFocus(focusNode);
    });
  }

  Widget homeBody() {
    return DelayedAnimation(
      key: const ValueKey("two"),
      delay: 500,
      child: Container(
        height: 600,
      ),
    );
  }



  Widget _buildAppBarSegment() {
    String title = "";
    return ValueListenableBuilder<dynamic>(
        valueListenable: MultiValueObserver([_bottomBarController, showTab]),
        builder: (context, _, __) {
          Widget? child;

          switch (_bottomBarController.selectedIndex) {
            case 0:
              title = "";
            case 1:
              title = "Calculate";
            case 2:
              title = "Shipment history";
            case 3:
              title = "Profile";
          }

          if (title.isEmpty) {
            child = SearchBar(
              key: const ValueKey("search"),
              focusNode: focusNode,
              hintText: "Enter the receipt number ...",
              hintStyle:
                  WidgetStateProperty.all(const TextStyle(color: Colors.grey)),
              backgroundColor: WidgetStateProperty.all(Colors.white),
              padding: WidgetStateProperty.all(
                  const EdgeInsets.symmetric(horizontal: 10)),
              leading: const Padding(
                padding: EdgeInsets.symmetric(horizontal: 5),
                child: Icon(Icons.search, color: Color(0xff44349e)),
              ),
              trailing: [
                SizedBox(
                  height: 45,
                  width: 45,
                  child: MaterialButton(
                      padding: const EdgeInsets.all(0),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(100)),
                      color: Colors.amber[900],
                      onPressed: () {},
                      child: const Icon(Icons.document_scanner,
                          color: Colors.white)),
                )
              ],
            );
          } else {
            Future.delayed(Duration.zero, () {
              showBackButton.value = true;
            });
            child = Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: 50),
                  child: Text(title,
                      key: ValueKey(title),
                      style: const TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.bold)),
                ),
              ],
            );
          }
          return AnimatedSwitcher(
            duration: const Duration(milliseconds: 500),
            child: child,
          );
        });
  }
}
