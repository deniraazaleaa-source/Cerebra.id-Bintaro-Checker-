import 'package:flutter/material.dart';
import 'camera_page.dart';
import 'profile_page.dart';
import 'package:fruitcheck/lokasi_page.dart';
import 'article_list_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            // Header
            const Padding(
              padding: EdgeInsets.only(top: 20, bottom: 10),
              child: Text(
                'Cerebra.id',
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF3C3C3C),
                  fontFamily: 'Poppins',
                ),
              ),
            ),
            const Divider(color: Color(0xFFB6B6B6), thickness: 0.5),

            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: GridView.count(
                  crossAxisCount: 2,
                  mainAxisSpacing: 15,
                  crossAxisSpacing: 15,
                  childAspectRatio: 0.65,
                  children: [
                    // 1. Scanner (hijau)
                    _buildMenuCard(
                      title: 'Scanner',
                      color: const Color(0xFF91BF71),
                      icon: Icons.camera_alt,
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (_) => const CameraPage()),
                        );
                      },
                    ),
                    _buildMenuCard(
                      title: 'Artikel',
                      color: const Color(0xFF94B7D6),
                      icon: Icons.article,
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (_) => const ArticleListPage()),
                        );
                      },
                    ),
                    _buildMenuCard(
                      title: 'Lokasi',
                      color: const Color(0xFF94B7D6),
                      icon: Icons.location_on,
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (_) => LokasiPage()),
                        );
                      },
                    ),
                    _buildMenuCard(
                      title: 'Profil',
                      color: const Color(0xFF91BF71),
                      icon: Icons.person,
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (_) => const ProfilePage()),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMenuCard({
    required String title,
    required Color color,
    required IconData icon,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(30),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 65, color: Colors.white),
            const SizedBox(height: 30),
            Text(
              title,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 25,
                fontWeight: FontWeight.w500,
                fontFamily: 'Poppins',
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class PlaceholderPage extends StatelessWidget {
  final String title;

  const PlaceholderPage({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: Center(
        child: Text(
          'Halaman $title belum tersedia.',
          style: const TextStyle(fontSize: 18),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
