import 'package:arfoon_note/server/models/label.dart';
import 'package:flutter/material.dart';

class Labels extends StatelessWidget {
  const Labels({super.key, required this.labels});

  final List<Label> labels;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: [
          Container(
              padding: const EdgeInsets.only(
                  top: 10, left: 15, right: 15, bottom: 5),
              margin: const EdgeInsets.only(top: 10, right: 10),
              decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 2, 1, 24),
                  borderRadius: BorderRadius.circular(25.0)),
              child: const Text(
                "All Notes",
                style:
                    TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              )),
          for (int i = 0; i < labels.length; i++)
            Container(
                padding: const EdgeInsets.only(
                    top: 10, left: 15, right: 15, bottom: 5),
                margin: const EdgeInsets.only(top: 10, right: 10),
                decoration: BoxDecoration(
                    // color: const Color.fromARGB(255, 2, 1, 24),
                    border: Border.all(
                        color: const Color.fromARGB(255, 2, 1, 24), width: 0.5),
                    borderRadius: BorderRadius.circular(25.0)),
                child: Text(
                  labels[i].name,
                  style: const TextStyle(
                      color: Color.fromARGB(255, 2, 1, 24),
                      fontWeight: FontWeight.bold),
                )),
        ],
      ),
    );
  }
}
