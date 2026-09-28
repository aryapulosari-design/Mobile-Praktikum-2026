// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;

import 'package:modul_6/main.dart';

void main() {
  testWidgets('menampilkan berita dari API', (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: MyHomePage(
          title: 'Demo ListView.builder',
          fetchNews: (_) async => http.Response(
            '{"posts":[{"title":"Berita contoh","published_at":"Hari ini"}]}',
            200,
          ),
        ),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.text('Berita contoh'), findsOneWidget);
    expect(find.text('Hari ini'), findsOneWidget);
  });

  testWidgets('menampilkan opsi coba lagi saat API gagal', (WidgetTester tester) async {
    var attempts = 0;

    await tester.pumpWidget(
      MaterialApp(
        home: MyHomePage(
          title: 'Demo ListView.builder',
          fetchNews: (_) async {
            attempts++;
            if (attempts == 1) {
              return http.Response('', 503);
            }
            return http.Response('{"posts":[]}', 200);
          },
        ),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.text('Coba lagi'), findsOneWidget);
    await tester.tap(find.text('Coba lagi'));
    await tester.pumpAndSettle();

    expect(find.text('Belum ada berita untuk ditampilkan.'), findsOneWidget);
    expect(attempts, 2);
  });
}
