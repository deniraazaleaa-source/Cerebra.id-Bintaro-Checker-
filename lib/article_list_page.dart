import 'package:flutter/material.dart';
import 'article_detail_page.dart';
import 'add_article_page.dart';

class ArticleListPage extends StatefulWidget {
  const ArticleListPage({super.key});

  @override
  State<ArticleListPage> createState() => _ArticleListPageState();
}

class _ArticleListPageState extends State<ArticleListPage> {
  final List<Map<String, String>> _articles = [
    {
      'judul': 'Buah Bintaro, Kandungan dan Manfaat',
      'preview':
          'Mengupas tuntas kandungan senyawa aktif dalam buah bintaro dan ragam manfaatnya bagi kesehatan dan pertanian.',
      'tanggal': 'Mei 2025',
      'views': '1.5k',
      'url': 'https://poltekkespim.ac.id/buah-bintaro-kandungan-dan-manfaat/',
      'konten': 'Buah bintaro (Cerbera manghas) adalah tanaman tropis yang sering dijumpai di pesisir pantai. '
          'Tanaman ini mengandung berbagai senyawa bioaktif seperti cerberin, saponin, tanin, steroid, dan alkaloid.\n\n'
          'Cerberin merupakan glikosida jantung yang bekerja dengan menghambat saluran ion kalsium, sehingga bersifat toksik bagi hewan berdarah panas, termasuk tikus. '
          'Saponin dan tanin berperan sebagai antifeedant dan insektisida alami.\n\n'
          'Karena kandungan racunnya, buah bintaro tidak boleh dikonsumsi manusia. Namun, justru karena sifat inilah buah bintaro sangat bermanfaat sebagai biopestisida, terutama untuk mengendalikan hama tikus di sawah dan permukiman.',
    },
    {
      'judul': 'Buah Bintaro: Biopestisida Ramah Lingkungan',
      'preview':
          'Penelitian IPB University membuktikan buah bintaro mampu mengusir tikus secara alami tanpa merusak lingkungan.',
      'tanggal': 'April 2025',
      'views': '2.1k',
      'url':
          'https://digitani.ipb.ac.id/buah-bintaro-biopestisida-ramah-lingkungan-untuk-mencegah-serangan-tikus-di-sawah/',
      'konten': 'Tim peneliti dari IPB University telah melakukan riset mendalam mengenai potensi buah bintaro (Cerbera manghas) sebagai biopestisida pengusir tikus.\n\n'
          'Hasil penelitian menunjukkan bahwa ekstrak biji bintaro mampu menyebabkan kematian pada tikus sawah (Rattus argentiventer) dalam waktu 2–3 hari setelah pemberian. '
          'Senyawa cerberin dan saponin bekerja sinergis mengganggu sistem saraf dan pencernaan tikus.\n\n'
          'Cara pembuatan pestisida bintaro:\n'
          '1. Kumpulkan buah bintaro matang (warna coklat kehijauan)\n'
          '2. Belah dan ambil bijinya\n'
          '3. Jemur biji hingga kering\n'
          '4. Tumbuk halus, campur dengan air (1 kg biji : 5 liter air)\n'
          '5. Diamkan 48 jam, saring, dan masukkan ke tangki semprot',
    },
    {
      'judul': 'Buah Bintaro untuk Mengusir Tikus',
      'preview':
          'Panduan praktis mengolah buah bintaro menjadi pengusir tikus ampuh untuk rumah dan pertanian.',
      'tanggal': 'Maret 2025',
      'views': '1.8k',
      'url': 'https://fumindo.com/artikel/buah-bintaro-untuk-mengusir-tikus/',
      'konten': 'Fumindo, perusahaan pest control terkemuka, memberikan tips menggunakan buah bintaro sebagai pengusir tikus alami di rumah dan gudang.\n\n'
          'Bintaro mengandung zat aktif yang tidak disukai tikus. Bahkan, tikus akan menjauh dari area yang terdapat buah bintaro. '
          'Cara termudah: letakkan 2–3 buah bintaro matang di sudut ruangan, dekat lubang tikus, atau di bawah lemari.\n\n'
          'Untuk hasil lebih maksimal, buat ekstrak sederhana:\n'
          '- Ambil 5–10 biji bintaro kering\n'
          '- Haluskan dengan blender\n'
          '- Campur dengan 1 liter air\n'
          '- Diamkan 24 jam, saring\n'
          '- Semprotkan ke area yang sering dilalui tikus',
    },
  ];

  void _addArticle(Map<String, String> article) {
    setState(() {
      _articles.add(article);
    });
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
          'Artikel',
          style: TextStyle(
            fontSize: 25,
            fontWeight: FontWeight.w700,
            color: Color(0xFF3C3C3C),
            fontFamily: 'Poppins',
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: ListView.separated(
        padding: const EdgeInsets.all(20),
        itemCount: _articles.length,
        separatorBuilder: (_, __) => const SizedBox(height: 15),
        itemBuilder: (context, index) {
          final article = _articles[index];
          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => ArticleDetailPage(article: article),
                ),
              );
            },
            child: Container(
              padding: const EdgeInsets.all(15),
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(color: Colors.black.withOpacity(0.20)),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    article['judul']!,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                      fontFamily: 'Poppins',
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    article['preview']!,
                    style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w400,
                      fontFamily: 'Poppins',
                    ),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      Text(
                        article['tanggal']!,
                        style: const TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w400,
                          fontFamily: 'Poppins',
                        ),
                      ),
                      const Spacer(),
                      const Icon(Icons.remove_red_eye,
                          size: 17, color: Colors.black),
                      const SizedBox(width: 5),
                      Text(
                        article['views']!,
                        style: const TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w400,
                          fontFamily: 'Poppins',
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color(0xFF91BF71),
        onPressed: () async {
          final result = await Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const AddArticlePage()),
          );
          if (result != null && result is Map<String, String>) {
            _addArticle(result);
          }
        },
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }
}
