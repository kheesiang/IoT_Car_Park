import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:myapp/main.dart';

/// This file is for widget testing main.dart.

void main() {
  group('Level 1 Widgets Exist Test', () {
    // test that title of page appears
    testWidgets('Finds title', (WidgetTester tester) async {
      await tester.pumpWidget(MyApp());
      expect(find.text('Smart Car Park'), findsOneWidget);
    });
    // test that default state is level 1, and all parking slots appear
    testWidgets('Finds level 1 slots', (WidgetTester tester) async {
      await tester.pumpWidget(MyApp());
      expect(find.text('L1_A1'), findsOneWidget);
      expect(find.text('L1_A2'), findsOneWidget);
      expect(find.text('L1_A3'), findsOneWidget);
      expect(find.text('L1_A4'), findsOneWidget);
      expect(find.text('L1_B1'), findsOneWidget);
      expect(find.text('L1_B2'), findsOneWidget);
      expect(find.text('L1_B3'), findsOneWidget);
      expect(find.text('L1_B4'), findsOneWidget);
    });
    // test that bottom navigation bar appears with the 2 "buttons"
    testWidgets('Finds bottom navigation bar', (WidgetTester tester) async {
      await tester.pumpWidget(MyApp());
      expect(find.text('Level 1'), findsOneWidget);
      expect(find.text('Level 2'), findsOneWidget);
    });
    // test that level 1 entrance widgets appear"
    testWidgets('Finds level 1 entrance widgets', (WidgetTester tester) async {
      await tester.pumpWidget(MyApp());
      expect(find.text('↑ To Level 2'), findsOneWidget);
      expect(find.text('↗ Mall Entrance'), findsOneWidget);
      expect(find.text('↑ Entrance - Exit ↓'), findsOneWidget);
    });
    // test that level 1 information widgets appear"
    testWidgets('Finds level 1 information widgets', (WidgetTester tester) async {
      await tester.pumpWidget(MyApp());
      expect(find.text('Occupied'), findsOneWidget);
      expect(find.text('Free'), findsOneWidget);
    });
  });

  group('Bottom Navigation Bar Test', () {
    // test that floor changes when corresponding button is pressed
    testWidgets('Changes to level 2', (WidgetTester tester) async {
      await tester.pumpWidget(MyApp());
      // we are in level 1 by default
      expect(find.text('L1_A1'), findsOneWidget);
      // tap level 2 button
      await tester.tap(find.byKey(Key('level2')));
      // rebuild the widget
      await tester.pump();
      // we are in level 2 now
      expect(find.text('L2_A1'), findsOneWidget);
    });
  });

  group('Level 2 Widgets Exist Test', () {
    // test that level 2 parking slots appear
    testWidgets('Finds level 2 slots', (WidgetTester tester) async {
      await tester.pumpWidget(MyApp());
      // tap level 2 button
      await tester.tap(find.byKey(Key('level2')));
      // rebuild the widget
      await tester.pump();
      // finds level 2 slots
      expect(find.text('L2_A1'), findsOneWidget);
      expect(find.text('L2_A2'), findsOneWidget);
      expect(find.text('L2_A3'), findsOneWidget);
      expect(find.text('L2_A4'), findsOneWidget);
    });
    // test that level 2 entrance widgets appear
    testWidgets('Finds level 2 entrance widgets', (WidgetTester tester) async {
      await tester.pumpWidget(MyApp());
      // tap level 2 button
      await tester.tap(find.byKey(Key('level2')));
      // rebuild the widget
      await tester.pump();
      // finds level 2 entrance widgets
      expect(find.text('↓ To Level 1'), findsOneWidget);
      expect(find.text('↗ Mall Entrance'), findsOneWidget);
    });
    // test that level 2 information widgets appear
    testWidgets('Finds level 2 information widgets', (WidgetTester tester) async {
      await tester.pumpWidget(MyApp());
      // tap level 2 button
      await tester.tap(find.byKey(Key('level2')));
      // rebuild the widget
      await tester.pump();
      // finds level 2 information widgets
      expect(find.text('Occupied'), findsOneWidget);
      expect(find.text('Free'), findsOneWidget);
    });
  });
}
