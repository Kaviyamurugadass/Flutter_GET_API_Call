import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutterproject/main.dart'; 
import 'package:flutterproject/api_list_page.dart'; 

void main() {
  testWidgets('HomePage UI test', (WidgetTester tester) async {
    // Build the widget tree
    await tester.pumpWidget(const MaterialApp(home: MyHomePage(title: 'Home Page')));

    // Verify if the "Home Page" title is present
    expect(find.text('Home Page'), findsOneWidget);

    // Verify if "GET Data" button is present
    expect(find.text('GET Data'), findsOneWidget);

    // Verify if "POST Data" button is present
    expect(find.text('POST Data'), findsOneWidget);

    // Verify if "Go to API List Page" button is present
    expect(find.text('Go to API List Page'), findsOneWidget);

    // Tap the "Go to API List Page" button
    await tester.tap(find.text('Go to API List Page'));
    await tester.pumpAndSettle();

    // Verify that navigation to ApiListPage happens
    expect(find.byType(ApiListPage), findsOneWidget);
  });
}
