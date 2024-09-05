import 'package:animation_app/delayed_animation.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

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
      child: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 15,
        ),
        child: Column(
          children: [
            // SizedBox(height: 10,),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  titleWidget("Tracking"),
                  Material(
                    elevation: 1,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15)),
                    color: Colors.white,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      child: Column(
                        children: [
                          const SizedBox(
                            height: 15,
                          ),
                          Row(
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    "Shipment number",
                                    style: TextStyle(
                                        fontWeight: FontWeight.w400,
                                        color: Colors.grey,
                                        fontSize: 12),
                                  ),
                                  Text("NEJ20089934122231",
                                      style: TextStyle(
                                          fontSize: 19,
                                          fontWeight: FontWeight.w600,
                                          color: Colors.grey[800])),
                                ],
                              ),
                              const Spacer(),
                              Container(
                                width: 60,
                                height: 60,
                                child: Image.asset(
                                  "assets/forklift.png",
                                  fit: BoxFit.fill,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          Divider(color: Colors.grey[200]),
                          const SizedBox(
                            height: 10,
                          ),
                          Row(
                            children: [
                              Row(children: [
                                Column(
                                  children: [
                                    Container(
                                      margin: const EdgeInsets.only(right: 10),
                                      width: 46,
                                      height: 40,
                                      color: Colors.grey,
                                      child: Image.asset(
                                        "assets/send_imge.png",
                                        fit: BoxFit.fill,
                                      ),
                                    ),
                                    const SizedBox(height: 30),
                                    Container(
                                      margin: const EdgeInsets.only(right: 10),
                                      width: 46,
                                      height: 40,
                                      color: Colors.grey,
                                      child: Image.asset(
                                        "assets/send_imge.png",
                                        fit: BoxFit.fill,
                                      ),
                                    ),
                                  ],
                                ),
                                Column(
                                  children: [
                                    labelValuePair("Sender", "Atlanta, 5243"),
                                    const SizedBox(height: 25),
                                    labelValuePair("Receiver", "Chicago 6342"),
                                  ],
                                ),
                              ]),
                              const Spacer(),
                              Column(
                                children: [
                                  labelValuePair("Time", "2 days - 3 days",
                                      showStatus: true),
                                  const SizedBox(height: 25),
                                  labelValuePair(
                                      "Status", "Waiting to collect"),
                                ],
                              ),
                              const SizedBox(
                                width: 20,
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Divider(
                            color: Colors.grey[200],
                            height: 5,
                          ),
                          TextButton(style: ButtonStyle(iconColor: WidgetStateProperty.all(Colors.amber[900])),
                              onPressed: () {},
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Icon(Icons.add, size: 20,),
                                  Text("Add Stop", style: TextStyle(color: Colors.amber[900]),),
                                ],
                              ))
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Container(
                alignment: Alignment.centerLeft,
                child: titleWidget("Available Vehicles"),
              ),
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width,
              height: 200,
              child: ListView(
                padding: const EdgeInsets.only(left: 15),
                scrollDirection: Axis.horizontal,
                shrinkWrap: true,
                children: [
                  vehicleCard("Ocean freight", "international", "assets/ship.png"),
                  vehicleCard("Cargo freight", "Reliable", "assets/truck.png"),
                  vehicleCard("Air freight", "international", "assets/plane.png"),
                ],
              ),
            ),
            const SizedBox(
              height: 100,
            ),
          ],
        ),
      ),
    );
  }
}

Widget vehicleCard(String title, String subText, String image) {
  return DelayedAnimation(
    delay: 100,
    direction: Axis.horizontal,
    duration: const Duration(milliseconds: 1200),
    child: SizedBox(
      height: 150,
      width: 150,
      child: Card(
        color: Colors.white,
        elevation: 0.2,
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 10, top: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title,
                      style: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.w400,
                          color: Colors.grey[700])),
                  Text(subText, style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w400,
                      color: Colors.grey[500]),),
                ],
              ),
            ),
            Positioned(
              bottom: 0,
              top: 50,
              right: 0,
              left: 0,
              child: DelayedAnimation(
                delay: 300,
                direction: Axis.horizontal,
                duration: Duration(milliseconds: 700),
                child: Container(
                  width: 150,
                  child: Image.asset(image),

                ),
              ),
            ),
          ],
        ),
      ),
    ),
  );
}

Widget labelValuePair(String label, String value, {bool showStatus = false}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        label,
        style: const TextStyle(
            fontWeight: FontWeight.w400, color: Colors.grey, fontSize: 12),
      ),
      Row(
        children: [
          if (showStatus)
            Container(
              margin: const EdgeInsets.only(right: 5),
              height: 6,
              width: 6,
              decoration:
                  const BoxDecoration(shape: BoxShape.circle, color: Colors.green),
            ),
          Text(
            value,
            style: TextStyle(
                fontWeight: FontWeight.w400,
                color: Colors.grey[900],
                fontSize: 14),
          ),
        ],
      )
    ],
  );
}
