// Percobaan 2 - ListView (project: demo_listview)
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Demo ListView',
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: const Color(0xFFF5F6F2),
        appBar: AppBar(
          title: const Text('Demo ListView'),
          backgroundColor: const Color(0xFFF5F6F2),
          foregroundColor: const Color(0xFF202A2A),
        ),
        body: ListView(
          padding: const EdgeInsets.fromLTRB(16, 12, 16, 24),
          children: [
            listTile(
              const Color(0xFFD9EFEB),
              const Color(0xFFB8DFD9),
              'Kehadiran',
              'Presensi kehadiran kuliah',
              'assets/icons/attendance.svg',
            ),
            listTile(
              const Color(0xFFE2EAF6),
              const Color(0xFFC9D9EF),
              'Jadwal',
              'Jadwal perkuliahan',
              'assets/icons/schedule.svg',
            ),
            listTile(
              const Color(0xFFF5E8C9),
              const Color(0xFFF0DDAF),
              'Tugas',
              'Tugas perkuliahan di luar kelas',
              'assets/icons/tasks.svg',
            ),
            listTile(
              const Color(0xFFF4DEDA),
              const Color(0xFFEBCBC4),
              'Pengumuman',
              'Informasi terkait perkuliahan',
              'assets/icons/announcements.svg',
            ),
            listTile(
              const Color(0xFFE8E2F3),
              const Color(0xFFDAD1E9),
              'Nilai',
              'Nilai ujian dan tugas',
              'assets/icons/grades.svg',
            ),
            listTile(
              const Color(0xFFDCEBE1),
              const Color(0xFFC9DFD0),
              'Catatan',
              'Pengingat kegiatan perkuliahan',
              'assets/icons/notes.svg',
            ),
          ],
        ),
      ),
    );
  }

  Container listTile(Color warna, Color warnaAvatar, String judul,
      String subjudul, String gambar) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      child: ListTile(
        tileColor: warna,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 7),
        title: Text(
          judul,
          style: const TextStyle(
            color: Color(0xFF202A2A),
            fontSize: 18,
            fontWeight: FontWeight.w700,
          ),
        ),
        subtitle: Text(
          subjudul,
          style: const TextStyle(fontSize: 14, color: Color(0xFF536463)),
        ),
        leading: CircleAvatar(
          radius: 29,
          backgroundColor: warnaAvatar,
          child: Padding(
            padding: const EdgeInsets.all(5),
            child: SvgPicture.asset(
              gambar,
              fit: BoxFit.contain,
            ),
          ),
        ),
        trailing: Icon(
          Icons.star_rounded,
          color: const Color(0xFFB77945),
        ),
      ),
    );
  }
}