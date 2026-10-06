import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    const Color bgColor = Color(0xFF0288D1);

    return Scaffold(
      backgroundColor: bgColor,
      appBar: AppBar(
        title: const Text(
          'Ini Halaman Home',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: bgColor,
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Banyak aplikasi memiliki beberapa layar untuk menampilkan '
              'informasi yang berbeda. Contohnya, ada layar produk, dan ketika '
              'pengguna mengklik produk, akan muncul layar dengan detail produk '
              'tersebut.',
              style: TextStyle(color: Colors.white, fontSize: 13),
            ),
            const Spacer(),
            Center(
              child: Container(
                width: 140,
                height: 140,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Icon(
                  Icons.home_rounded,
                  size: 100,
                  color: Colors.redAccent,
                ),
              ),
            ),
            const Spacer(),
            const Text(
              'Pertama, kita perlu membuat dua halaman atau "routes" yang ingin '
              'kita tampilkan. Selanjutnya, kita gunakan perintah Navigator.push() '
              'untuk berpindah dari halaman pertama ke halaman kedua. Terakhir, '
              'kita bisa kembali dari halaman kedua ke halaman pertama '
              'menggunakan Navigator.pop().',
              style: TextStyle(color: Colors.white, fontSize: 13),
            ),
            const SizedBox(height: 20),
            Center(
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFF4492B),
                  foregroundColor: Colors.white,
                ),
                onPressed: () {
                  Navigator.pushNamed(context, '/tujuan');
                },
                child: const Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text('Ke halaman tujuan'),
                    SizedBox(width: 4),
                    Icon(Icons.chevron_right, size: 18),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}