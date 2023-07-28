import 'package:flutter/material.dart';

class NotFound extends StatelessWidget {
  const NotFound({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: IntrinsicHeight(
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('404'),
              SizedBox(width: 8),
              VerticalDivider(
                color: Colors.grey,
                width: 1.0,
              ),
              SizedBox(width: 8),
              Text('NOT FOUND'),
            ],
          ),
        ),
      ),
    );
  }
}
