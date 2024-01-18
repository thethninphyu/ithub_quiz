import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('MyApp widget should render "Hello World"', (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());

    // Verify that the "Hello World" text is rendered on the screen.
    expect(find.text('Hello World'), findsOneWidget);
  });
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Container(
          decoration: const BoxDecoration(color: Colors.white),
          child: const Center(
            child: Text(
              'Hello World',
              textDirection: TextDirection.ltr,
              style: TextStyle(
                fontSize: 32,
                color: Colors.black87,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
