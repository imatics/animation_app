import 'package:animation_app/delayed_animation.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:collection/collection.dart';

class ShipmentPage extends StatefulWidget {
  const ShipmentPage({super.key, required this.controller});
  final TabController controller;

  @override
  State<ShipmentPage> createState() => _ShipmentPageState();
}

class _ShipmentPageState extends State<ShipmentPage> {
  List<Status> all = [
    Status.pending,
    Status.pending,
    Status.inProgress,
    Status.loading,
    Status.loading,
    Status.loading,
    Status.inProgress
  ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    widget.controller.addListener((){
      if(mounted){
        setState(() {});
      }
    });
  }

  Widget titleWidget(String text) {
    return Padding(
      padding: const EdgeInsets.only(top: 15, bottom: 10),
      child: Text(
        text,
        style: TextStyle(
            fontSize: 19, fontWeight: FontWeight.w500, color: Colors.grey[800]),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.only(left: 15, right: 15, bottom: 80),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          titleWidget("Shipment"),
          if (widget.controller.index == 0)
            ...all.mapIndexed((index, e) => DelayedAnimation(
              key: ValueKey("${widget.controller.index} -- ${100 * index}"),
                  delay: (100 * index),
                  duration: const Duration(milliseconds: 1200),
                  child: listItem(context, e),
                )),
          if (widget.controller.index == 1)
            ...getList(context, 3, Status.completed),
          if (widget.controller.index == 2)
            ...getList(context, 1, Status.loading),
          if (widget.controller.index == 3)
            ...getList(context, 4, Status.pending),
        ],
      ),
    );
  }


List<Widget> getList(BuildContext context, int count, Status status) {
  return List<Widget>.generate(
      count,
      (e) => DelayedAnimation(
            delay: (100 * e),
            key: ValueKey("${widget.controller.index} -- ${100 * e}"),
            duration: const Duration(milliseconds: 1200),
            child: listItem(context, Status.inProgress),
          )).toList();
}

Widget listItem(BuildContext context, Status status) {
  return Container(
    margin: const EdgeInsets.only(bottom: 10),
    child: Material(
      elevation: 0.2,
      borderRadius: BorderRadius.circular(10),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Row(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  margin:
                      const EdgeInsets.symmetric(vertical: 5),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(10)),
                  child: Row(
                    children: [
                      Icon(
                        status.icon,
                        color: status.color.withOpacity(0.5),
                        size: 18,
                      ),
                      SizedBox(
                        width: 3,
                      ),
                      Text(
                        status.label,
                        style: TextStyle(color: status.color, fontSize: 15, fontWeight: FontWeight.w500),
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 4),
                  child: Text(
                    "Arriving Today!",
                    style: TextStyle(
                        fontSize: 19,
                        color: Colors.grey[800],
                        fontWeight: FontWeight.w600),
                  ),
                ),
                Text(
                  "Your delivery, #NEJ20089934122231 \nfrom Atlanta, is arriving today!",
                  style: TextStyle(
                      fontSize: 15,
                      color: Colors.grey[600],
                      fontWeight: FontWeight.normal),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: RichText(
                    text: TextSpan(children: [
                      TextSpan(
                          text: "\$230 USD • ",
                          style: TextStyle(
                              color: Theme.of(context).primaryColor,
                              fontSize: 16,
                              fontWeight: FontWeight.w600)),
                      TextSpan(text: "Sep 20,2023"),
                    ], style: TextStyle(color: Colors.grey[900]!)),
                  ),
                )
              ],
            ),
            Expanded(
              child: Image.asset(
                "assets/parcel_big.png",
                height: 120,
                width: 120,
              ),
            )
          ],
        ),
      ),
    ),
  );
}
}

enum Status {
  pending(
      label: "Pending", icon: Icons.ac_unit_sharp, color: Color(0xFFFF8F00)),
  loading(label: "Loading", icon: Icons.ac_unit_sharp, color: Colors.blue),
  inProgress(label: "In progress", icon: Icons.refresh, color: Colors.indigo),
  completed(label: "Completed", icon: Icons.done, color: Colors.green);

  const Status({required this.label, required this.icon, required this.color});

  final String label;
  final IconData icon;
  final Color color;
}
