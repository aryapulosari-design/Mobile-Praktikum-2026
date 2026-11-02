import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'screen_arguments.dart';
import 'tujuan.dart';

class Home extends StatefulWidget {
  const Home({super.key, this.client});

  final http.Client? client;

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late final http.Client _client;
  late final bool _ownsClient;
  Map<String, String>? _game;
  String? _error;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _ownsClient = widget.client == null;
    _client = widget.client ?? http.Client();
    _loadGame();
  }

  @override
  void dispose() {
    if (_ownsClient) {
      _client.close();
    }
    super.dispose();
  }

  Future<void> _loadGame() async {
    setState(() {
      _isLoading = true;
      _error = null;
    });

    try {
      final response = await _client.get(
        Uri.https('www.freetogame.com', '/api/game', {'id': '475'}),
      );
      if (response.statusCode != 200) {
        throw Exception('Server mengembalikan HTTP ${response.statusCode}.');
      }

      final decoded = jsonDecode(response.body);
      if (decoded is! Map<String, dynamic>) {
        throw const FormatException('Format data game tidak valid.');
      }

      final thumbnail = _requiredString(decoded, 'thumbnail');
      var cover = thumbnail;
      final screenshots = decoded['screenshots'];
      if (screenshots is List && screenshots.isNotEmpty) {
        final firstScreenshot = screenshots.first;
        if (firstScreenshot is Map<String, dynamic> &&
            firstScreenshot['image'] is String &&
            (firstScreenshot['image'] as String).isNotEmpty) {
          cover = firstScreenshot['image'] as String;
        }
      }

      if (!mounted) return;
      setState(() {
        _game = {
          'title': _requiredString(decoded, 'title'),
          'thumbnail': thumbnail,
          'shortDescription': _requiredString(decoded, 'short_description'),
          'description': _requiredString(decoded, 'description'),
          'genre': _requiredString(decoded, 'genre'),
          'platform': _requiredString(decoded, 'platform'),
          'publisher': _requiredString(decoded, 'publisher'),
          'release': _requiredString(decoded, 'release_date'),
          'cover': cover,
        };
        _isLoading = false;
      });
    } on Exception catch (error) {
      if (!mounted) return;
      setState(() {
        _error = 'Gagal mengambil data game: $error';
        _isLoading = false;
      });
    }
  }

  String _requiredString(Map<String, dynamic> data, String key) {
    final value = data[key];
    if (value is! String || value.isEmpty) {
      throw FormatException('Data "$key" tidak tersedia.');
    }
    return value;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0081C9),
      body: SafeArea(
        child: Center(
          child: _isLoading
              ? const CircularProgressIndicator(color: Colors.white)
              : _error != null
              ? Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(24),
                      child: Text(
                        _error!,
                        textAlign: TextAlign.center,
                        style: const TextStyle(color: Colors.white),
                      ),
                    ),
                    OutlinedButton(
                      onPressed: _loadGame,
                      child: const Text('Coba lagi'),
                    ),
                  ],
                )
              : _buildGameCard(_game!),
        ),
      ),
    );
  }

  Widget _buildGameCard(Map<String, String> game) {
    return SingleChildScrollView(
      child: GestureDetector(
        onTap: () {
          Navigator.pushNamed(
            context,
            Tujuan.routeName,
            arguments: ScreenArguments(
              game['cover']!,
              game['title']!,
              game['description']!,
              game['shortDescription']!,
            ),
          );
        },
        child: Container(
          padding: const EdgeInsets.all(15),
          margin: const EdgeInsets.all(15),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(15),
          ),
          child: Column(
            children: [
              Image.network(
                game['thumbnail']!,
                height: 190,
                width: double.infinity,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) => const SizedBox(
                  height: 190,
                  child: Center(child: Icon(Icons.broken_image, size: 48)),
                ),
              ),
              const SizedBox(height: 15),
              Text(
                game['title']!,
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 24),
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Genre: ${game['genre']}'),
                      Text('Platform: ${game['platform']}'),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Publisher: ${game['publisher']}'),
                      Text('Release: ${game['release']}'),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 10),
              const Text('Ketuk kartu untuk melihat detail'),
            ],
          ),
        ),
      ),
    );
  }
}
