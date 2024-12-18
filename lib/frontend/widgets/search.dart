import 'package:flutter/material.dart';

class Search extends StatelessWidget {
  final void Function(String value) onSearch;
  const Search({super.key, required this.onSearch});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: TextField(
        decoration: InputDecoration(
            prefixIcon: const Icon(Icons.search),
            hintText: "Search...",
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(35.0))),
        onChanged: onSearch,
      ),
    );
  }
}
