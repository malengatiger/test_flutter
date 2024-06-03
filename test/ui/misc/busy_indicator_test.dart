import 'package:busha_app/misc/busy_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_analog_clock/flutter_analog_clock.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('BusyIndicator Widget Tests', () {
    testWidgets('BusyIndicator has elapsed time', (WidgetTester tester) async {
      await tester.pumpWidget(const MaterialApp(home: BusyIndicator()));

      expect(find.text('Elapsed Time:'), findsOneWidget);
    });

    testWidgets('BusyIndicator displays caption', (WidgetTester tester) async {
      const caption = 'Loading...';
      await tester
          .pumpWidget(const MaterialApp(home: BusyIndicator(caption: caption)));

      expect(find.text(caption), findsOneWidget);
    });

    testWidgets('BusyIndicator displays clock when showClock is true',
        (WidgetTester tester) async {
      await tester
          .pumpWidget(const MaterialApp(home: BusyIndicator(showClock: true)));

      // Verify that the AnalogClock widget is present
      expect(find.byType(AnalogClock), findsOneWidget);
      expect(find.byType(CircularProgressIndicator), findsOneWidget);
    });

    testWidgets('BusyIndicator has a CircularProgressIndicator and Clock',
        (WidgetTester tester) async {
      await tester
          .pumpWidget(const MaterialApp(home: BusyIndicator(showClock: false)));

      // Verify that the AnalogClock widget is not present
      expect(find.byType(AnalogClock), findsNothing);
      expect(find.byType(CircularProgressIndicator), findsOneWidget);
    });

    testWidgets('BusyIndicator does not display clock when showClock is false',
        (WidgetTester tester) async {
      await tester.pumpWidget(
          const MaterialApp(home: BusyIndicator(showTimerOnly: true)));

      // Verify that only the elapsed time and progress indicator are present
      expect(find.byType(CircularProgressIndicator), findsOne);
      // Verify that other elements like caption and clock are not present
      expect(find.byType(AnalogClock), findsNothing);
    });
  });
}
