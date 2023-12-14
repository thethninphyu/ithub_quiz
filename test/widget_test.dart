import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ithub_quiz/ui/admin_screen/module/question_create/answer_row_widget.dart';

void main() {
  testWidgets('Testing remove arrow object', (WidgetTester tester) async {
    // Variable to hold the index passed to onDelete callback
    int deletedIndex = -1;
    bool isChecked = false;

    // Build the AnswerRow widget
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: AnswerRow(
            index: 0,
            onDelete: (int value) {
              deletedIndex = value;
            },
            isChecked: (bool newChecked) {
              isChecked = newChecked;
            },
            onControllerChanged: (TextEditingController) {},
          ),
        ),
      ),
    );

    // Tap the remove button
    await tester.tap(find.byIcon(Icons.remove_circle));

    // Wait for the frame to be rebuilt
    await tester.pump();

    // Verify that onDelete callback is called with the correct index
    expect(deletedIndex, 0);

     // Find the checkbox and check its state
    Finder checkboxFinder = find.byType(Checkbox);
    expect(tester.widget<Checkbox>(checkboxFinder).value, isChecked);
  });
}
