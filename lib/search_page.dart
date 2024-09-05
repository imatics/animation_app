import 'package:animation_app/delayed_animation.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SearchPage extends StatelessWidget {
  const SearchPage({super.key});

  @override
  Widget build(BuildContext context) {
    return _searchBody(context);
  }


  Widget _searchBody(BuildContext context) {
    return DelayedAnimation(
      duration: const Duration(milliseconds: 800),
      delay: 50,
      child: SizedBox(
        height: MediaQuery.of(context).size.height - 85,
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
          child: Material(
            color: Colors.white,
            elevation: 1,
            shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            child: ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: 4,
              itemBuilder: (context, index) => _listItem(index, context),
              separatorBuilder: (context, index) {
                if (index >= 0 && index < 3) {
                  return Divider(
                    color: Colors.grey[300],
                    endIndent: 20,
                    indent: 20,
                  );
                }
                return const SizedBox();
              },
            ),
          ),
        ),
      ),
    );
  }


  Widget _listItem(int index, BuildContext context) {
    return DelayedAnimation(
      delay: index * 50,
      duration: const Duration(milliseconds: 500),
      child: Padding(
        padding: const EdgeInsets.only(top: 15, left: 15, right: 15, bottom: 15),
        child: Row(
          children: [
            Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Theme.of(context).primaryColor,
              ),
              padding: const EdgeInsets.all(10),
              child: const Icon(Icons.backpack),
            ),
            const SizedBox(
              width: 10,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Macbook pro 2",
                  style: TextStyle(fontWeight: FontWeight.w600),
                ),
                const SizedBox(
                  height: 3,
                ),
                RichText(
                  text: const TextSpan(children: [
                    TextSpan(text: "#NHEU3384903 • "),
                    TextSpan(text: "Barcelona → "),
                    TextSpan(text: "Paris"),
                  ], style: TextStyle(color: Colors.grey, fontSize: 15)),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
