import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

// Adjust this import to match your project package name
import 'package:pml/main.dart';

void main() {
  testWidgets('ToDo Riverpod smoke test', (WidgetTester tester) async {
    // Build our app wrapped in ProviderScope (already included in MyApp main.dart)
    await tester.pumpWidget(const MasterPlanApp());

    // Verify that the initial empty state text is displayed
    expect(find.text('Belum ada tugas'), findsOneWidget);
    expect(find.text('ToDo Riverpod'), findsOneWidget);

    // Tap the floating action button to open the add dialog
    await tester.tap(find.byIcon(Icons.add));
    await tester.pumpAndSettle();

    // Verify that the dialog appears
    expect(find.text('Tugas baru'), findsOneWidget);

    // Enter text into the task input field
    await tester.enterText(find.byType(TextField), 'Beli Susu');
    await tester.pumpAndSettle();

    // Tap the 'Tambah' button to submit
    await tester.tap(find.text('Tambah'));
    await tester.pumpAndSettle();

    // Verify that the new task item is visible and empty state is gone
    expect(find.text('Belum ada tugas'), findsNothing);
    expect(find.text('Beli Susu'), findsOneWidget);
  });
}