import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:hello_world/main.dart';

void main() {
  testWidgets('Hello World home renders greeting', (WidgetTester tester) async {
    await tester.pumpWidget(const HelloWorldApp());

    expect(find.text('Hello, World!'), findsOneWidget);
    expect(find.text('Built with Flutter'), findsOneWidget);
    expect(find.byType(AppBar), findsOneWidget);
  });
}
