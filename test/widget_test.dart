import 'package:example_family_notifier_provider_mock/src/my_home_page/my_home_page.dart';
import 'package:example_family_notifier_provider_mock/src/my_home_page/my_home_page_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:mocktail/mocktail.dart';

late MockMyHomePageController mockController;

class MockMyHomePageController extends Mock
    implements MyHomePageController {}

final mockControllerProvider = NotifierProvider.autoDispose
    .family<MyHomePageController, int, int>(() => mockController);

void main() {
  mockController = MockMyHomePageController();
  var counter = 3;
  when(() => mockController.arg).thenReturn(counter);
  when(() => mockController.state).thenReturn(counter);
  when(() => mockController.build(counter)).thenReturn(counter);
  when(() => mockController.incrementCounter()).thenAnswer((_) {});

  testWidgets('Mock MyHomePageController Test', (WidgetTester tester) async {
    await tester.pumpWidget(ProviderScope(
      overrides: [
        myHomePageControllerProvider(0)
            .overrideWithProvider(mockControllerProvider(0)),],
      child: const MaterialApp(
        home: MyHomePage(title: 'Test Title'),
      ),
    ));

    // Verify that our counter starts at 3.
    expect(find.text('$counter'), findsOneWidget);

    // Tap the '+' icon and trigger a frame.
    await tester.tap(find.byIcon(Icons.add));
    await tester.pump();

    // Verify that our counter has incremented.
    verify(() => mockController.incrementCounter()).called(1);
  });
}
