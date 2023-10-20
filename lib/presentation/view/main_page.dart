import 'package:android_studyjams/presentation/controller/main_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MainPage extends StatefulWidget {
  MainPage({super.key});

  @override
  State<StatefulWidget> createState() => _MainState();
}

class _MainState extends State<MainPage> {
  bool selected = false;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: Center(
        child: SizedBox(
          width: size.width,
          height: size.height,
          child: Stack(
            children: [
              AnimatedPositioned(
                width: selected ? size.width / 3 : size.width / 2,
                height: 56.0,
                top: selected ? size.height / 2 : 24,
                left: selected ? size.width / 3 : 24,
                duration: const Duration(seconds: 1),
                curve: Curves.fastOutSlowIn,
                child: GestureDetector(
                  onTap: () {
                    setState(() {
                      selected = !selected;
                    });
                  },
                  child: const ColoredBox(
                    color: Colors.blue,
                    child: Center(child: Text('Tap me')),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
