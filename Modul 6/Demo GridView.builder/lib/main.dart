// Percobaan 4 - ListView.builder (project: demo_gridview_builder, body diganti)
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Demo ListView.builder',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.amber),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Demo ListView.builder'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({
    super.key,
    required this.title,
    this.fetchNews,
  });

  final String title;
  final Future<http.Response> Function(Uri uri)? fetchNews;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<Map<String, dynamic>> dataBerita = [];
  bool _isLoading = true;
  String? _errorMessage;

  @override
  void initState() {
    super.initState();
    _ambilData();
  }

  Future<void> _ambilData() async {
    try {
      final uri = Uri.parse(
        'https://jakpost.vercel.app/api/category/business/tech',
      );
      final response = widget.fetchNews == null
          ? await http.get(uri).timeout(const Duration(seconds: 20))
          : await widget.fetchNews!(uri);

      if (response.statusCode == 200) {
        final decodedData = jsonDecode(response.body);
        if (decodedData is! Map || decodedData['posts'] is! List) {
          throw const FormatException('Format data berita tidak valid');
        }
        final posts = (decodedData['posts'] as List)
            .whereType<Map>()
            .map((post) => Map<String, dynamic>.from(post))
            .toList();
        if (!mounted) return;
        setState(() {
          dataBerita = posts;
          _isLoading = false;
          _errorMessage = null;
        });
      } else {
        throw Exception('Server merespons dengan kode ${response.statusCode}');
      }
    } catch (error) {
      if (!mounted) return;
      setState(() {
        _isLoading = false;
        _errorMessage = 'Berita gagal dimuat. Periksa koneksi lalu coba lagi.';
      });
      debugPrint('Gagal memuat berita: $error');
    }
  }

  Future<void> _cobaLagi() async {
    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });
    await _ambilData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.amber,
        title: Text(widget.title),
      ),
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    if (_isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (_errorMessage != null) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.wifi_off, size: 40),
              const SizedBox(height: 12),
              Text(_errorMessage!, textAlign: TextAlign.center),
              const SizedBox(height: 12),
              FilledButton.icon(
                onPressed: _cobaLagi,
                icon: const Icon(Icons.refresh),
                label: const Text('Coba lagi'),
              ),
            ],
          ),
        ),
      );
    }

    if (dataBerita.isEmpty) {
      return const Center(child: Text('Belum ada berita untuk ditampilkan.'));
    }

    return ListView.builder(
      itemCount: dataBerita.length,
      itemBuilder: (context, index) {
        final berita = dataBerita[index];
        final title = berita['title'];
        final publishedAt = berita['published_at'];
        final imageUrl = berita['image'];

        return Padding(
          padding: const EdgeInsets.all(8),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              border: Border.all(
                color: Theme.of(context).colorScheme.inversePrimary,
                width: 1,
              ),
            ),
            padding: const EdgeInsets.symmetric(vertical: 4),
            child: ListTile(
              title: Text(
                title is String && title.isNotEmpty ? title : 'Tidak ada judul',
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              subtitle: Text(
                publishedAt is String && publishedAt.isNotEmpty
                    ? publishedAt
                    : 'Tidak ada data tanggal',
                maxLines: 1,
                style: const TextStyle(fontSize: 16),
              ),
              leading: ClipRRect(
                borderRadius: BorderRadius.circular(6),
                child: imageUrl is String && imageUrl.isNotEmpty
                    ? Image.network(
                        imageUrl,
                        fit: BoxFit.cover,
                        width: 100,
                        height: 72,
                        errorBuilder: (context, error, stackTrace) =>
                            _imagePlaceholder(),
                      )
                    : _imagePlaceholder(),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _imagePlaceholder() {
    return Container(
      width: 100,
      height: 72,
      color: Colors.amber.shade100,
      alignment: Alignment.center,
      child: const Icon(Icons.article_outlined),
    );
  }
}