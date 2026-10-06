import 'package:demo_navigasi/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('named route opens Tujuan and returns to Home', (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        theme: ThemeData(splashFactory: NoSplash.splashFactory),
        home: const MyApp(),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.text('Ini Halaman Home'), findsOneWidget);
    await tester.tap(find.text('Ke Halaman Tujuan'));
    await tester.pumpAndSettle();

    expect(find.text('Ini Halaman Tujuan'), findsOneWidget);
    await tester.tap(find.text('Kembali ke Home'));
    await tester.pumpAndSettle();

    expect(find.text('Ini Halaman Home'), findsOneWidget);
  });
}