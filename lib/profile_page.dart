import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'begin_page.dart';
import 'change_password_page.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  String _username = '';
  String _email = '';

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    final prefs = await SharedPreferences.getInstance();
    String? activeUser = prefs.getString('activeUser');
    if (activeUser != null) {
      var parts = activeUser.split('|');
      setState(() {
        _username = parts[0];
        _email = parts[1];
      });
    }
  }

  Future<void> _logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('activeUser');
    if (!mounted) return;
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (_) => const BeginPage()),
      (route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, size: 28),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Profil',
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
        bottom: const PreferredSize(
          preferredSize: Size.fromHeight(0.5),
          child: Divider(color: Color(0xFFB6B6B6), height: 0.5, thickness: 0.5),
        ),
      ),
      body: Stack(
        children: [
          Positioned(
            left: (size.width - 109) / 2,
            top: 20,
            child: ClipOval(
              child: Image.asset('assets/images/logo.png',
                  width: 109, height: 109, fit: BoxFit.cover),
            ),
          ),
          Positioned(
            left: 0,
            right: 0,
            top: 135,
            child: Text(
              _username.isNotEmpty ? _username : 'Pengguna',
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w700,
                color: Color(0xFF3C3C3C),
                fontFamily: 'Poppins',
              ),
            ),
          ),
          Positioned(
            left: 0,
            right: 0,
            top: 170,
            child: Text(
              _email.isNotEmpty ? _email : 'email@example.com',
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w400,
                color: Color(0xFF3C3C3C),
                fontFamily: 'Poppins',
              ),
            ),
          ),
          Positioned(
            left: (size.width - 290) / 2,
            top: 280,
            child: GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const ChangePasswordPage()),
                );
              },
              child: Container(
                width: 290,
                height: 79,
                decoration: ShapeDecoration(
                  color: const Color(0xFF94B7D6),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30)),
                ),
                alignment: Alignment.center,
                child: const Text(
                  'Ubah Kata Sandi',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                      fontFamily: 'Poppins'),
                ),
              ),
            ),
          ),
          Positioned(
            left: (size.width - 290) / 2,
            top: 390,
            child: GestureDetector(
              onTap: _logout,
              child: Container(
                width: 290,
                height: 79,
                decoration: ShapeDecoration(
                  color: const Color(0xFFEF5759),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30)),
                ),
                alignment: Alignment.center,
                child: const Text(
                  'Keluar',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                      fontFamily: 'Poppins'),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
