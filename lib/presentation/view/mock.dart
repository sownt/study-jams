import 'package:flutter/material.dart';

// For testing
class Mock extends StatelessWidget {
  const Mock({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Autocomplete<String>(
          optionsBuilder: (textEditingValue) {
            return List.empty();
          },
        ),
      ),
    );
  }

}