import 'package:flutter/material.dart';

class TujuanPage extends StatelessWidget {
  const TujuanPage({super.key});

  @override
  Widget build(BuildContext context) {
    const Color bgColor = Color(0xFFF4492B);

    return Scaffold(
      backgroundColor: bgColor,
      appBar: AppBar(
        title: const Text(
          'Ini Halaman Tujuan',
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
              'Untuk berpindah ke halaman baru, gunakan metode Navigator.push(). '
              'Metode push akan menambahkan Route ke dalam tumpukan Route yang '
              'dikelola oleh Navigator. Route ini dapat dibuat secara kustom atau '
              'menggunakan MaterialPageRoute, yang memiliki animasi transisi '
              'sesuai dengan platform yang digunakan.',
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
                  Icons.beach_access_rounded,
                  size: 100,
                  color: Colors.green,
                ),
              ),
            ),
            const Spacer(),
            const Text(
              'Untuk menutup halaman kedua dan kembali ke halaman pertama, '
              'gunakan metode Navigator.pop(). Metode pop() akan menghapus Route '
              'saat ini dari tumpukan Route yang dikelola oleh Navigator.',
              style: TextStyle(color: Colors.white, fontSize: 13),
            ),
            const SizedBox(height: 20),
            Center(
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF0288D1),
                  foregroundColor: Colors.white,
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.chevron_left, size: 18),
                    SizedBox(width: 4),
                    Text('Kembali ke home'),
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