import 'package:animation_app/list_obsever.dart';
import 'package:flutter/material.dart';

class BottomBar extends StatefulWidget {
  const BottomBar({super.key, required this.controller});

  final BottomBarController controller;

  @override
  State<BottomBar> createState() => _BottomBarState();
}

class _BottomBarState extends State<BottomBar> {
  List<MenuItem> menuItems = [
    MenuItem("Home", Icons.home_outlined),
    MenuItem("Calculate", Icons.calculate_outlined),
    MenuItem("Shipment", Icons.ac_unit),
    MenuItem("Profile", Icons.person_outlined),
  ];

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width / menuItems.length;
    return ValueListenableBuilder<dynamic>(
      valueListenable: MultiValueObserver<dynamic>(
          [widget.controller._selectedItem, widget.controller._showState, widget.controller._shadowState]),
      builder: (context, selectedIndex, _) {
        double positionX = widget.controller.selectedIndex * width;
        return Container(
          decoration: BoxDecoration(
              gradient: widget.controller._shadowState.value? const LinearGradient(
                  colors: [Colors.white10, Colors.white60, Colors.white,  Colors.white],
              begin: Alignment.topCenter, end: Alignment.bottomCenter): null),
          child: AnimatedOpacity(
            duration: const Duration(milliseconds: 500),
            opacity: widget.controller._showState.value ? 1 : 0,
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 500),
              curve: Curves.decelerate,
              transform: Matrix4.translationValues(
                  0, widget.controller._showState.value ? 0 : 90, 0),
              decoration: BoxDecoration(
                border:
                    Border(top: BorderSide(color: Colors.grey[200]!, width: 1)),
                color: Colors.white,
              ),
              child: Container(
                height: 75,
                child: Column(
                  children: [
                    Row(
                      children: [
                        AnimatedContainer(
                          duration: Duration(milliseconds: 200),
                          height: 4,
                          color: Theme.of(context).primaryColor,
                          transform: Matrix4.translationValues(positionX, 0, 0),
                          width: width,
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: menuItems.map((e) {
                        int index = menuItems.indexOf(e);
                        bool selected = index == selectedIndex;
                        return Expanded(
                          child: Material(
                            color: Colors.transparent,
                            child: InkWell(
                              onTap: () {
                                widget.controller.selectedIndex = index;
                              },
                              child: TweenAnimationBuilder(
                                tween: ColorTween(
                                    begin: Colors.grey,
                                    end: selected
                                        ? Theme.of(context).primaryColor
                                        : Colors.grey),
                                duration: Duration(milliseconds: 200),
                                builder: (context, color, _) => Column(
                                  children: [
                                    Padding(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 10),
                                        child: Icon(
                                          e.icon,
                                          size: 25,
                                          color: color,
                                        )),
                                    Text(
                                      e.title,
                                      style: TextStyle(color: color),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                        );
                      }).toList(),
                    )
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

class MenuItem {
  final String title;
  final IconData icon;
  MenuItem(this.title, this.icon);
}

class BottomBarController extends ValueNotifier {
  final _showState = ValueNotifier(true);
  final _shadowState = ValueNotifier(false);
  final _selectedItem = ValueNotifier(0);
  final List<Function(int)> _onItemSelectedListeners = [];

  BottomBarController(super.value);

  void hide({Duration delay = const Duration(milliseconds: 400), bool shadow = false}) {
    Future.delayed(delay, () {
      _showState.value = false;
      _shadowState.value = shadow;
      notifyListeners();
    });
  }

  void show({Duration delay = const Duration(milliseconds: 400)}) {
    Future.delayed(delay, () {
      _showState.value = true;
    });
  }


  void onPageChange(Function(int) listener) {
    _onItemSelectedListeners.add(listener);
  }

  int get selectedIndex => _selectedItem.value;

  ValueNotifier<int> get selected => _selectedItem;

  set selectedIndex(int index) {
    notifyListeners();
    _selectedItem.value = index;
    for (var e in _onItemSelectedListeners) {
      e.call(index);
    }
  }
}
