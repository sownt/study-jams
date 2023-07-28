import 'package:android_studyjams/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('Test homepage', (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());
    expect(find.widgetWithIcon(IconButton, Icons.check), findsOneWidget);
  });
}