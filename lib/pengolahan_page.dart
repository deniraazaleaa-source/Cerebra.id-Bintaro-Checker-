import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class PengolahanPage extends StatelessWidget {
  final String statusBuah;

  const PengolahanPage({super.key, required this.statusBuah});

  Future<void> _launchURL(String url) async {
    if (await canLaunchUrl(Uri.parse(url))) {
      await launchUrl(Uri.parse(url));
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final topPadding = MediaQuery.of(context).padding.top;

    String subtitle;
    String pembukaan;
    String? langkahTitle;
    List<Map<String, String>> langkahList;
    String penutup;
    String? videoUrl;
    String sumberLink;

    switch (statusBuah.toLowerCase()) {
      case 'mentah':
        subtitle = 'Buah Bintaro Mentah';
        pembukaan =
            'Bintaro merupakan tanaman yang sering digunakan sebagai tanaman hias di taman kota. Selain berfungsi sebagai peneduh, buah bintaro memiliki kandungan senyawa aktif seperti alkaloid, flavonoid, tanin, steroid, saponin, dan triterpenoid yang berpotensi sebagai pestisida nabati. Senyawa tersebut bersifat toksik dan repellent sehingga dapat membantu mengendalikan serangga serta mengusir tikus.';
        langkahTitle = 'Cara Pembuatan Pestisida Buah Bintaro';
        langkahList = [
          {
            'judul': 'Alat dan Bahan',
            'isi':
                '• Buah bintaro\n• Pisau\n• Blender\n• Air 5 liter\n• Saringan'
          },
          {
            'judul': 'Langkah Pembuatan',
            'isi': '1. Pecahkan dan potong buah bintaro menjadi bagian kecil.\n'
                '2. Haluskan potongan buah menggunakan blender.\n'
                '3. Campurkan hasil blender dengan 5 liter air.\n'
                '4. Diamkan campuran selama 2 hari.\n'
                '5. Saring campuran dan ambil air hasil rendamannya.\n'
                '6. Semprotkan larutan pada bagian pinggir tanaman sebanyak 2–3 kali per minggu dengan dosis sekitar 250 cc per tangki semprot.'
          },
        ];
        penutup =
            'Buah bintaro dapat dimanfaatkan sebagai pestisida nabati karena mengandung senyawa yang bersifat toksik dan pengusir hama. Proses pembuatannya cukup sederhana, yaitu dengan menghaluskan buah, merendamnya dalam air, kemudian menyaring dan mengaplikasikan larutannya pada tanaman untuk membantu mengendalikan serangga pengganggu.';
        sumberLink =
            'https://agri.kompas.com/read/2023/01/25/101700284/cara-membuat-pestisida-nabati-dari-buah-bintaro-untuk-mengusir-hama';
        videoUrl = null;
        break;

      case 'matang':
        subtitle = 'Buah Bintaro Matang';
        pembukaan =
            'Buah bintaro merupakan salah satu tanaman yang mengandung senyawa aktif seperti alkaloid, saponin, dan steroid yang bersifat toksik serta memiliki aroma yang tidak disukai oleh hama tertentu. Oleh karena itu, buah bintaro sering dimanfaatkan sebagai pengusir tikus alami yang lebih ramah lingkungan dibandingkan penggunaan bahan kimia sintetis.';
        langkahTitle = 'Cara Penggunaan Buah Bintaro sebagai Pengusir Tikus';
        langkahList = [
          {
            'judul': 'Alat dan Bahan',
            'isi': '• Buah bintaro matang\n• Pisau atau alat pemotong'
          },
          {
            'judul': 'Langkah Penggunaan',
            'isi': '1. Siapkan buah bintaro yang sudah matang.\n'
                '2. Potong buah bintaro menjadi beberapa bagian kecil agar aroma dan kandungan aktifnya lebih mudah menyebar.\n'
                '3. Letakkan potongan buah bintaro di lokasi yang sering dilalui atau menjadi sarang tikus, seperti gudang, dapur, atau ruang penyimpanan.\n'
                '4. Ganti potongan buah bintaro secara berkala setiap beberapa hari sekali untuk menjaga efektivitasnya dalam mengusir tikus.'
          },
        ];
        penutup =
            'Buah bintaro dapat dimanfaatkan sebagai pengusir tikus alami karena mengandung senyawa aktif dan aroma yang tidak disukai oleh tikus. Penggunaannya cukup sederhana, yaitu dengan memotong buah bintaro matang dan meletakkannya di area yang sering didatangi tikus. Penggantian secara berkala diperlukan agar efektivitas pengusiran tetap terjaga.';
        sumberLink =
            'https://fumindo.com/artikel/buah-bintaro-untuk-mengusir-tikus/';
        videoUrl = null;
        break;

      case 'kering':
      default:
        subtitle = 'Buah Bintaro Kering';
        pembukaan =
            'Buah bintaro (Cerbera manghas atau Cerbera odollam) merupakan tanaman yang mengandung senyawa toksik, terutama golongan kardiak glikosida. Senyawa tersebut diketahui tidak disukai oleh tikus sehingga buah bintaro sering dimanfaatkan sebagai bahan pengusir hama tikus yang lebih ramah lingkungan dibandingkan rodentisida kimia sintetis.';
        langkahTitle = 'Tata Cara Pengolahan Bintaro Kering';
        langkahList = [
          {
            'judul': '1. Pengumpulan Buah Bintaro',
            'isi':
                'Buah bintaro yang telah matang dikumpulkan dari pohon atau dari buah yang telah jatuh ke tanah. Pemilihan buah yang matang bertujuan memperoleh kandungan senyawa aktif yang optimal. Setelah dikumpulkan, buah dibersihkan dari kotoran yang menempel pada permukaannya.'
          },
          {
            'judul': '2. Pengeringan',
            'isi':
                'Buah bintaro kemudian dikeringkan dengan cara dijemur di bawah sinar matahari hingga kadar airnya berkurang. Proses pengeringan bertujuan mencegah pembusukan serta memudahkan proses pembakaran. Buah yang telah kering umumnya memiliki tekstur lebih keras dan bobot yang lebih ringan dibandingkan buah segar.'
          },
          {
            'judul': '3. Pembakaran',
            'isi':
                'Setelah kering, buah bintaro dibakar secara terkendali hingga menghasilkan asap. Pembakaran dilakukan untuk menghasilkan aroma dan senyawa volatil yang berasal dari buah bintaro. Asap yang dihasilkan diyakini dapat membantu mengusir tikus dari area yang sering dilaluinya. Pemanfaatan hasil pembakaran ini merupakan salah satu bentuk penggunaan tradisional bintaro sebagai pengendali hama tikus.'
          },
          {
            'judul': '4. Peletakan Hasil Pembakaran pada Lubang Tikus Aktif',
            'isi':
                'Abu atau sisa hasil pembakaran diletakkan pada lubang tikus yang masih aktif digunakan. Lubang aktif biasanya ditandai dengan adanya jejak kaki, kotoran tikus, atau tanah yang tampak baru tergali. Penempatan sisa pembakaran pada lubang aktif bertujuan agar aroma bintaro dapat menyebar ke dalam sarang sehingga tikus enggan kembali menggunakan lubang tersebut.'
          },
        ];
        penutup =
            'Pengolahan bintaro kering sebagai pengusir tikus dilakukan melalui empat tahapan utama, yaitu pengumpulan buah bintaro, pengeringan, pembakaran, dan peletakan hasil pembakaran pada lubang tikus yang aktif. Metode ini memanfaatkan sifat alami bintaro yang mengandung senyawa toksik dan repellent terhadap tikus sehingga dapat digunakan sebagai alternatif pengendalian hama yang lebih ramah lingkungan.';
        sumberLink =
            'https://youtu.be/aV5mkfoXuUo?si=yx5qosEjKaOsA8z1'; // Link YouTube
        videoUrl = 'https://youtu.be/aV5mkfoXuUo?si=yx5qosEjKaOsA8z1';
        break;
    }

    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          Positioned(
            top: -size.height * 0.10,
            left: 0,
            right: 0,
            child: Container(
              height: size.height * 0.35,
              decoration: const BoxDecoration(
                color: Color(0xFFB9E7F9),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(20),
                  bottomRight: Radius.circular(20),
                ),
              ),
            ),
          ),
          Positioned(
            left: 10,
            top: topPadding + 10,
            child: IconButton(
              icon: const Icon(Icons.arrow_back, size: 28),
              onPressed: () => Navigator.pop(context),
            ),
          ),
          Positioned(
            left: 38,
            top: topPadding + 50,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Pengolahan',
                  style: TextStyle(
                    fontSize: 40,
                    fontWeight: FontWeight.w700,
                    fontFamily: 'Poppins',
                    color: Colors.black,
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  subtitle,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w400,
                    fontFamily: 'Poppins',
                    color: Colors.black.withOpacity(0.7),
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            top: topPadding + 200,
            left: 38,
            right: 38,
            bottom: 20,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    pembukaan,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      fontFamily: 'Poppins',
                      height: 1.5,
                    ),
                  ),
                  const SizedBox(height: 20),
                  if (langkahTitle != null)
                    Text(
                      langkahTitle,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                        fontFamily: 'Poppins',
                      ),
                    ),
                  const SizedBox(height: 15),
                  ...langkahList.map((step) => Padding(
                        padding: const EdgeInsets.only(bottom: 15),
                        child: _buildStep(step['judul']!, step['isi']!),
                      )),
                  const SizedBox(height: 20),
                  Text(
                    penutup,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      fontFamily: 'Poppins',
                      height: 1.5,
                    ),
                  ),
                  const SizedBox(height: 25),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton.icon(
                      onPressed: () => _launchURL(sumberLink),
                      icon: const Icon(Icons.open_in_browser, size: 22),
                      label: const Text(
                        'Baca Sumber Asli',
                        style: TextStyle(fontFamily: 'Poppins', fontSize: 16),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF91BF71),
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStep(String title, String description) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w600,
            fontFamily: 'Poppins',
          ),
        ),
        const SizedBox(height: 5),
        Text(
          description,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w400,
            fontFamily: 'Poppins',
            height: 1.4,
          ),
        ),
      ],
    );
  }
}
