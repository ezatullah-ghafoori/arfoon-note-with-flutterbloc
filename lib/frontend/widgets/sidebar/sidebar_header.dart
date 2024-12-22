import 'package:flutter/material.dart';

class SidebarHeader extends StatelessWidget {
  const SidebarHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const SizedBox(
            height: 20,
          ),
          Row(
            children: [
              SizedBox(width: 50, child: Image.asset('assets/images/logo.png')),
              const SizedBox(
                width: 10,
              ),
              const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Arfoon Note",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    "Think, Note, Archive.",
                    style: TextStyle(color: Color.fromARGB(106, 0, 0, 0)),
                  ),
                ],
              )
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          MaterialButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Image.asset('assets/images/notes.png'),
                    const Text("All Notes"),
                  ],
                ),
                const Icon(Icons.arrow_forward_ios),
              ],
            ),
          )
        ],
      ),
    );
  }
}
