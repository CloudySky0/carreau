import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:diamond_app/template.dart'; // Change this to your actual file path

void main() {
  testWidgets("Home screen has a title and a button", (WidgetTester tester) async {
    // Load the widget inside the test environment
    await tester.pumpWidget(MaterialApp(home: HomeScreen()));

    // Verify if "Jewelry Marketplace" title exists
    expect(find.text("Jewelry Marketplace"), findsOneWidget);

    // Verify if the "Home" button exists in BottomNavigationBar
    expect(find.byIcon(Icons.home), findsOneWidget);
  });
}
