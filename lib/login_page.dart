import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'home_page.dart';
import 'register_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isPasswordVisible = false;

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _masuk() async {
    String username = _usernameController.text.trim();
    String password = _passwordController.text;

    if (username.isEmpty || password.isEmpty) {
      _showSnackbar('Harap isi semua kolom!');
      return;
    }

    final prefs = await SharedPreferences.getInstance();
    List<String> accounts = prefs.getStringList('accounts') ?? [];

    for (var acc in accounts) {
      var parts = acc.split('|');
      if (parts[0] == username && parts[2] == password) {
        await prefs.setString('activeUser', '${parts[0]}|${parts[1]}');
        if (!mounted) return;
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (_) => const HomePage()),
          (route) => false,
        );
        return;
      }
    }

    _showSnackbar('Username atau kata sandi salah!');
  }

  void _showSnackbar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message), backgroundColor: Colors.red),
    );
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      body: SingleChildScrollView(
        child: SizedBox(
          height: size.height,
          child: Stack(
            children: [
              Positioned(
                top: size.height * 0.20,
                left: 0,
                right: 0,
                bottom: 0,
                child: Container(
                  decoration: const BoxDecoration(
                    color: Color(0xFFB9E7F9),
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30),
                    ),
                  ),
                ),
              ),
              Positioned(
                top: MediaQuery.of(context).padding.top + 10,
                left: 10,
                child: IconButton(
                  icon: const Icon(Icons.arrow_back, size: 28),
                  onPressed: () => Navigator.pop(context),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 40),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    SizedBox(height: size.height * 0.25),
                    const Text(
                      'Masuk',
                      style: TextStyle(
                        fontSize: 50,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF3C3C3C),
                        fontFamily: 'Poppins',
                      ),
                    ),
                    SizedBox(height: size.height * 0.04),
                    const Text('Username',
                        style: TextStyle(
                            fontWeight: FontWeight.w400,
                            fontFamily: 'Poppins')),
                    const SizedBox(height: 8),
                    TextField(
                      controller: _usernameController,
                      decoration: InputDecoration(
                        hintText: 'Masukkan nama',
                        hintStyle: TextStyle(
                            color: Colors.black.withOpacity(0.5),
                            fontFamily: 'Poppins'),
                        filled: true,
                        fillColor: const Color(0xFFB9E7F9),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                            borderSide: const BorderSide(width: 1)),
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                            borderSide: const BorderSide(width: 1)),
                      ),
                      style: const TextStyle(fontFamily: 'Poppins'),
                    ),
                    const SizedBox(height: 20),
                    const Text('Kata Sandi',
                        style: TextStyle(
                            fontWeight: FontWeight.w400,
                            fontFamily: 'Poppins')),
                    const SizedBox(height: 8),
                    TextField(
                      controller: _passwordController,
                      obscureText: !_isPasswordVisible,
                      decoration: InputDecoration(
                        hintText: 'Masukkan Kata Sandi',
                        hintStyle: TextStyle(
                            color: Colors.black.withOpacity(0.5),
                            fontFamily: 'Poppins'),
                        filled: true,
                        fillColor: const Color(0xFFB9E7F9),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                            borderSide: const BorderSide(width: 1)),
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                            borderSide: const BorderSide(width: 1)),
                        suffixIcon: IconButton(
                          icon: Icon(_isPasswordVisible
                              ? Icons.visibility_off
                              : Icons.visibility),
                          onPressed: () => setState(
                              () => _isPasswordVisible = !_isPasswordVisible),
                        ),
                      ),
                      style: const TextStyle(fontFamily: 'Poppins'),
                    ),
                    SizedBox(height: size.height * 0.06),
                    ElevatedButton(
                      onPressed: _masuk,
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
                      child: const Text('Masuk'),
                    ),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text('Tidak punya akun? ',
                            style:
                                TextStyle(fontSize: 12, fontFamily: 'Poppins')),
                        GestureDetector(
                          onTap: () {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const RegisterPage()),
                            );
                          },
                          child: const Text('Buat Akun',
                              style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'Poppins')),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
