import 'package:flutter/material.dart';

class AddLabel extends StatefulWidget {
  const AddLabel({super.key});

  @override
  State<AddLabel> createState() => _AddLabelState();
}

class _AddLabelState extends State<AddLabel> {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: SizedBox(
        height: 400,
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Text(
                "Select Label",
                style: TextStyle(fontSize: 18),
              ),
              Container(
                height: 0.5,
                color: Colors.black,
              ),
              // for(int i = 0; i < labels.length; i ++)
              Checkbox(value: false, onChanged: (val) {})
            ],
          ),
        ),
      ),
    );
  }
}
