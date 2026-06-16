import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'home_page.dart';
import 'login_page.dart';
import 'register_page.dart';

class BeginPage extends StatefulWidget {
  const BeginPage({super.key});

  @override
  State<BeginPage> createState() => _BeginPageState();
}

class _BeginPageState extends State<BeginPage> {
  bool _isPrecached = false;

  @override
  void initState() {
    super.initState();
    _checkLogin();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!_isPrecached) {
      _isPrecached = true;
      try {
        precacheImage(const AssetImage('assets/images/logo.png'), context);
      } catch (e) {
        debugPrint('GAGAL LOAD LOGO: $e');
      }
    }
  }

  Future<void> _checkLogin() async {
    final prefs = await SharedPreferences.getInstance();
    String? activeUser = prefs.getString('activeUser');
    if (activeUser != null && mounted) {
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (_) => const HomePage()),
        (route) => false,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      body: Container(
        width: size.width,
        height: size.height,
        decoration: const BoxDecoration(color: Color(0xFFB9E7F9)),
        child: Stack(
          children: [
            Positioned(
              left: (size.width - 150) / 2,
              top: size.height * 0.20,
              child: ClipOval(
                child: Image.asset(
                  'assets/images/logo.png',
                  width: 150,
                  height: 140,
                  fit: BoxFit.contain,
                ),
              ),
            ),
            Positioned(
              left: 30,
              top: size.height * 0.40,
              right: 30,
              child: FittedBox(
                fit: BoxFit.scaleDown,
                child: const Text(
                  'Cerebra.id',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 45,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF3C3C3C),
                    fontFamily: 'Poppins',
                  ),
                ),
              ),
            ),
            Positioned(
              left: 56,
              top: size.height * 0.55,
              right: 56,
              child: GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const RegisterPage()),
                  );
                },
                child: Container(
                  height: 55,
                  decoration: ShapeDecoration(
                    color: const Color(0xFF91BF71),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30)),
                  ),
                  alignment: Alignment.center,
                  child: const Text(
                    'Daftar',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Poppins'),
                  ),
                ),
              ),
            ),
            Positioned(
              left: 56,
              top: size.height * 0.68,
              right: 56,
              child: GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const LoginPage()),
                  );
                },
                child: Container(
                  height: 55,
                  decoration: ShapeDecoration(
                    color: const Color(0xFF91BF71),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30)),
                  ),
                  alignment: Alignment.center,
                  child: const Text(
                    'Masuk',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Poppins'),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
