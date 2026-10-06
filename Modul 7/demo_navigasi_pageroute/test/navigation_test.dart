import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:demo_navigasi_pageroute/home.dart';

void main() {
  testWidgets('navigates to Tujuan and returns Home', (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        theme: ThemeData(splashFactory: NoSplash.splashFactory),
        home: const Home(),
      ),
    );

    expect(find.text('Ini adalah halaman Home'), findsOneWidget);
    await tester.tap(find.text('Ke Halaman Tujuan'));
    await tester.pumpAndSettle();

    expect(find.text('Ini adalah halaman Tujuan'), findsOneWidget);
    await tester.tap(find.text('Kembali ke Home'));
    await tester.pumpAndSettle();

    expect(find.text('Ini adalah halaman Home'), findsOneWidget);
  });
}