import 'package:flutter/material.dart';

class AddArticlePage extends StatefulWidget {
  const AddArticlePage({super.key});

  @override
  State<AddArticlePage> createState() => _AddArticlePageState();
}

class _AddArticlePageState extends State<AddArticlePage> {
  final _judulController = TextEditingController();
  final _kontenController = TextEditingController();

  @override
  void dispose() {
    _judulController.dispose();
    _kontenController.dispose();
    super.dispose();
  }

  void _unggah() {
    if (_judulController.text.isEmpty || _kontenController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text('Harap isi judul dan konten!'),
            backgroundColor: Colors.red),
      );
      return;
    }

    final article = {
      'judul': _judulController.text.trim(),
      'preview': _kontenController.text.trim().length > 100
          ? '${_kontenController.text.trim().substring(0, 100)}...'
          : _kontenController.text.trim(),
      'tanggal': 'Juni 2025',
      'views': '0',
      'url': 'https://example.com',
    };

    Navigator.pop(context, article);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, size: 28),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Unggah Artikel',
          style: TextStyle(
            fontSize: 25,
            fontWeight: FontWeight.w700,
            fontFamily: 'Poppins',
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text('Judul Artikel',
                style: TextStyle(
                    fontWeight: FontWeight.w400, fontFamily: 'Poppins')),
            const SizedBox(height: 8),
            TextField(
              controller: _judulController,
              decoration: InputDecoration(
                hintText: 'Tambahkan Judul',
                hintStyle: TextStyle(
                    color: Colors.black.withOpacity(0.5),
                    fontFamily: 'Poppins'),
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: const BorderSide(width: 1)),
                enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: const BorderSide(width: 1)),
              ),
            ),
            const SizedBox(height: 20),
            const Text('Konten',
                style: TextStyle(
                    fontWeight: FontWeight.w400, fontFamily: 'Poppins')),
            const SizedBox(height: 8),
            Expanded(
              child: TextField(
                controller: _kontenController,
                maxLines: null,
                expands: true,
                textAlignVertical: TextAlignVertical.top,
                decoration: InputDecoration(
                  hintText: 'Ketik sesuatu....',
                  hintStyle: TextStyle(
                      color: Colors.black.withOpacity(0.5),
                      fontFamily: 'Poppins'),
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: const BorderSide(width: 1)),
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: const BorderSide(width: 1)),
                ),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _unggah,
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF91BF71),
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30)),
                padding: const EdgeInsets.symmetric(vertical: 16),
                textStyle: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Poppins'),
              ),
              child: const Text('Unggah'),
            ),
          ],
        ),
      ),
    );
  }
}
