import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:grocerystore/screens/components/cart_counter.dart';

void main() {
  testWidgets('CartCounter - Initial State', (WidgetTester tester) async {
    // Build our widget and trigger a frame.
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: CartCounter(
            quantity: '1',
            onIncrease: () {},
            onDecrease: () {},
          ),
        ),
      ),
    );

    // Verify if the initial state is as expected
    expect(find.text('1'), findsOneWidget); // Check if quantity is displayed
    expect(find.byIcon(Icons.remove), findsOneWidget); // Check if decrease button is present
    expect(find.byIcon(Icons.add), findsOneWidget); // Check if increase button is present
  });

  testWidgets('CartCounter - Increase and Decrease', (WidgetTester tester) async {
    int counter = 1; // Initial quantity

    // Build our widget and trigger a frame.
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: CartCounter(
            quantity: counter.toString(),
            onIncrease: () {
              counter++;
            },
            onDecrease: () {
              if (counter > 0) {
                counter--;
              }
            },
          ),
        ),
      ),
    );
    expect(find.text(counter.toString()), findsOneWidget);

    // Tap the increase button and wait for the widget to rebuild
    await tester.tap(find.byIcon(Icons.add));
    await tester.pumpAndSettle();
    expect(find.text((counter + 1).toString()), findsOneWidget);

    // Tap the decrease button and wait for the widget to rebuild
    await tester.tap(find.byIcon(Icons.remove));
    await tester.pumpAndSettle();
    expect(find.text(counter.toString()), findsOneWidget);

    // Tap the decrease button and wait for the widget to rebuild
    await tester.tap(find.byIcon(Icons.remove));
    await tester.pumpAndSettle();
    expect(find.text('0'), findsOneWidget);
  });
}
