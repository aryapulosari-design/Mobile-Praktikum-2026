import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Music Player UI',
      // a. Gunakan ThemeData.dark() agar tampilan aplikasi terlihat gelap dan elegan
      theme: ThemeData.dark(), 
      home: Scaffold(
        appBar: AppBar(
          // b. Buat judul aplikasi pada AppBar dengan teks "Sedang memutar"
          title: const Text('Sedang memutar'),
          // b. posisikan di tengah dengan centerTitle: true
          centerTitle: true, 
          backgroundColor: Colors.transparent, // Mengikuti tampilan gelap elegan
          elevation: 0,
        ),
        // c. Tempatkan widget Card di bagian tengah layar menggunakan Center
        body: Center( 
          child: Card(
            // Memberi jarak margin agar Card tidak menempel penuh di tepi layar
            margin: const EdgeInsets.symmetric(horizontal: 20),
            // d. Atur properti Card: elevation: 4
            elevation: 4, 
            // d. shape: RoundedRectangleBorder dengan borderRadius: BorderRadius.circular(12)
            shape: RoundedRectangleBorder( 
              borderRadius: BorderRadius.circular(12),
            ),
            // d. padding: EdgeInsets.all(12) di dalam Card untuk memberi ruang
            child: Padding( 
              padding: const EdgeInsets.all(12.0),
              child: Column(
                mainAxisSize: MainAxisSize.min, // Agar tinggi Card menyesuaikan isi
                children: [
                  const SizedBox(height: 20), // Menggunakan SizedBox untuk jarak atas
                  
                  // Ikon Cover Album yang ukurannya cukup besar
                  const Icon(
                    Icons.album,
                    size: 120,
                    color: Colors.blueGrey,
                  ),
                  
                  // Menggunakan SizedBox untuk memberikan jarak tetap yang presisi
                  const SizedBox(height: 30), 
                  
                  // Baris untuk informasi lagu dan tombol Like
                  Row(
                    children: [
                      // Kolom untuk Judul Lagu dan Nama Artis
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start, // Rata kiri
                        children: const [
                          Text(
                            'Di sini ada judul lagu',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          // Menggunakan SizedBox untuk jarak mikro antar teks
                          SizedBox(height: 4), 
                          Text(
                            'Di sini ada nama artis',
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      ),
                      
                      // Menggunakan Spacer untuk mendorong tombol Like secara proporsional ke sudut paling kanan
                      const Spacer(), 
                      
                      // Tombol aksi untuk memberi tanda suka (like)
                      IconButton(
                        icon: const Icon(Icons.favorite_border),
                        color: Colors.red,
                        onPressed: () {
                          // Aksi ketika tombol ditekan dapat ditambahkan di sini
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}