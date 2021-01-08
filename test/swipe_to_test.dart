import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:swipe_to/src/SwipeTo.dart';

Widget prepareWidgetForTesting(Widget child) => MaterialApp(
      home: Material(
        child: Center(
          child: child,
        ),
      ),
    );

void main() {
  testWidgets('SwipeTo swipeRight test', (WidgetTester tester) async {
    final logs = <String>[];

    await tester.pumpWidget(
      prepareWidgetForTesting(
        SwipeTo(
          child: ListTile(title: Text('Hey')),
          onRightSwipe: () {
            logs.add('Hey');
          },
        ),
      ),
    );

    expect(logs.isEmpty, true);

    await tester.drag(find.byType(SwipeTo), Offset(40.0, 0.0));
    expect(find.byIcon(Icons.reply), findsOneWidget);

    await tester.pumpAndSettle();

    expect(logs.isEmpty, false);
  });

  testWidgets('SwipeTo swipeLeft test', (WidgetTester tester) async {
    final logs = <String>[];

    await tester.pumpWidget(
      prepareWidgetForTesting(
        SwipeTo(
          child: ListTile(title: Text('Hey')),
          onLeftSwipe: () {
            logs.add('Hey');
          },
        ),
      ),
    );

    expect(logs.isEmpty, true);

    await tester.drag(find.byType(SwipeTo), Offset(-40.0, 0.0));
    expect(find.byIcon(Icons.reply), findsOneWidget);

    await tester.pumpAndSettle();

    expect(logs.isEmpty, false);
  });
}
