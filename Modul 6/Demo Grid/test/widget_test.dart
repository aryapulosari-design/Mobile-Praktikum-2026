// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:modul_6/main.dart';

void main() {
  testWidgets('menu menampilkan enam aset ilustrasi', (WidgetTester tester) async {
    tester.view.physicalSize = const Size(500, 1000);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    await tester.pumpWidget(const MyApp());
    await tester.pumpAndSettle();

    expect(find.text('Kehadiran'), findsOneWidget);
    expect(find.text('Jadwal Kuliah'), findsOneWidget);
    expect(find.text('Tugas'), findsOneWidget);
    expect(find.text('Pengumuman'), findsOneWidget);
    expect(find.text('Nilai'), findsOneWidget);
    expect(find.text('Catatan'), findsOneWidget);
    expect(find.byType(SvgPicture), findsNWidgets(6));
  });
}
