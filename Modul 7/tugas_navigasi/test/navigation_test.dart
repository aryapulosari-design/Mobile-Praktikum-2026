import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tugas_navigasi/main.dart';

void main() {
  testWidgets('named route navigates to Tujuan and returns Home', (
    WidgetTester tester,
  ) async {
    tester.view.physicalSize = const Size(800, 900);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    await tester.pumpWidget(
      MaterialApp(
        theme: ThemeData(splashFactory: NoSplash.splashFactory),
        home: const MyApp(),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.text('Ini Halaman Home'), findsOneWidget);
    await tester.tap(find.text('Ke halaman tujuan'));
    await tester.pumpAndSettle();

    expect(find.text('Ini Halaman Tujuan'), findsOneWidget);
    await tester.tap(find.text('Kembali ke home'));
    await tester.pumpAndSettle();

    expect(find.text('Ini Halaman Home'), findsOneWidget);
  });
}