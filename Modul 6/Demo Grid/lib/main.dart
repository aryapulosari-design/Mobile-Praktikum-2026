// Percobaan 1 - GridView (project: demo_gridview)
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Demo GridView',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        scaffoldBackgroundColor: const Color(0xFFF5F6F2),
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF087E78)),
      ),
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Demo GridView'),
          backgroundColor: const Color(0xFFF5F6F2),
          foregroundColor: const Color(0xFF202A2A),
        ),
        body: GridView.builder(
          padding: const EdgeInsets.fromLTRB(16, 12, 16, 24),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: 14,
            crossAxisSpacing: 14,
            childAspectRatio: 0.94,
          ),
          itemCount: _menuItems.length,
          itemBuilder: (context, index) => _tile(_menuItems[index]),
        ),
      ),
    );
  }

  Widget _tile(_MenuItem item) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: item.color,
        borderRadius: BorderRadius.circular(14),
      ),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 18, 16, 14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Center(
                child: SvgPicture.asset(item.asset, fit: BoxFit.contain),
              ),
            ),
            const SizedBox(height: 10),
            Text(
              item.title,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                color: Color(0xFF202A2A),
                fontSize: 16,
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

const _menuItems = [
  _MenuItem('Kehadiran', 'assets/icons/attendance.svg', Color(0xFFD9EFEB)),
  _MenuItem('Jadwal Kuliah', 'assets/icons/schedule.svg', Color(0xFFE2EAF6)),
  _MenuItem('Tugas', 'assets/icons/tasks.svg', Color(0xFFF5E8C9)),
  _MenuItem('Pengumuman', 'assets/icons/announcements.svg', Color(0xFFF4DEDA)),
  _MenuItem('Nilai', 'assets/icons/grades.svg', Color(0xFFE8E2F3)),
  _MenuItem('Catatan', 'assets/icons/notes.svg', Color(0xFFDCEBE1)),
];

class _MenuItem {
  const _MenuItem(this.title, this.asset, this.color);

  final String title;
  final String asset;
  final Color color;
}