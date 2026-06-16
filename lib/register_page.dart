import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'home_page.dart';
import 'login_page.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _usernameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  bool _isPasswordVisible = false;
  bool _isConfirmPasswordVisible = false;

  @override
  void dispose() {
    _usernameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  Future<void> _daftar() async {
    String username = _usernameController.text.trim();
    String email = _emailController.text.trim();
    String password = _passwordController.text;
    String confirmPassword = _confirmPasswordController.text;

    if (username.isEmpty ||
        email.isEmpty ||
        password.isEmpty ||
        confirmPassword.isEmpty) {
      _showSnackbar('Harap isi semua kolom!');
      return;
    }

    if (password != confirmPassword) {
      _showSnackbar('Kata sandi tidak cocok!');
      return;
    }

    // Simpan akun ke SharedPreferences
    final prefs = await SharedPreferences.getInstance();
    List<String> accounts = prefs.getStringList('accounts') ?? [];

    // Cek apakah username sudah ada
    for (var acc in accounts) {
      var parts = acc.split('|');
      if (parts[0] == username) {
        _showSnackbar('Username sudah digunakan!');
        return;
      }
    }

    // Format: username|email|password
    accounts.add('$username|$email|$password');
    await prefs.setStringList('accounts', accounts);

    // Simpan sebagai user yang sedang login
    await prefs.setString('activeUser', '$username|$email');

    // Langsung masuk ke HomePage
    if (!mounted) return;
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (_) => const HomePage()),
      (route) => false,
    );
  }

  void _showSnackbar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message), backgroundColor: Colors.red),
    );
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final topPadding = MediaQuery.of(context).padding.top;

    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          // Background biru atas
          Positioned(
            top: -size.height * 0.12,
            left: 0,
            right: 0,
            child: Container(
              height: size.height * 0.45,
              decoration: const BoxDecoration(
                color: Color(0xFFB9E7F9),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(50),
                  bottomRight: Radius.circular(50),
                ),
              ),
            ),
          ),
          // Panah kembali
          Positioned(
            left: 10,
            top: topPadding + 10,
            child: IconButton(
              icon: const Icon(Icons.arrow_back, size: 28),
              onPressed: () => Navigator.pop(context),
            ),
          ),
          // Judul "Buat Akun"
          Positioned(
            left: 38,
            top: topPadding + 75,
            child: const SizedBox(
              width: 220,
              height: 166,
              child: Text.rich(
                TextSpan(
                  children: [
                    TextSpan(
                      text: 'Buat\n',
                      style: TextStyle(
                        fontSize: 50,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF3C3C3C),
                        fontFamily: 'Poppins',
                        height: 1.0,
                      ),
                    ),
                    TextSpan(
                      text: 'Akun',
                      style: TextStyle(
                        fontSize: 50,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF3C3C3C),
                        fontFamily: 'Poppins',
                        height: 1.0,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          // Form input
          Positioned(
            top: topPadding + 75 + 166 + 20,
            left: 0,
            right: 0,
            bottom: 0,
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 40),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const Text('Username',
                      style: TextStyle(
                          fontWeight: FontWeight.w400, fontFamily: 'Poppins')),
                  const SizedBox(height: 8),
                  TextField(
                    controller: _usernameController,
                    decoration: InputDecoration(
                      hintText: 'Masukkan nama',
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
                    style: const TextStyle(fontFamily: 'Poppins'),
                  ),
                  const SizedBox(height: 20),
                  const Text('Email',
                      style: TextStyle(
                          fontWeight: FontWeight.w400, fontFamily: 'Poppins')),
                  const SizedBox(height: 8),
                  TextField(
                    controller: _emailController,
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      hintText: 'Masukkan Email',
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
                    style: const TextStyle(fontFamily: 'Poppins'),
                  ),
                  const SizedBox(height: 20),
                  const Text('Kata Sandi',
                      style: TextStyle(
                          fontWeight: FontWeight.w400, fontFamily: 'Poppins')),
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
                      fillColor: Colors.white,
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
                  const SizedBox(height: 20),
                  const Text('Konfirmasi Kata Sandi',
                      style: TextStyle(
                          fontWeight: FontWeight.w400, fontFamily: 'Poppins')),
                  const SizedBox(height: 8),
                  TextField(
                    controller: _confirmPasswordController,
                    obscureText: !_isConfirmPasswordVisible,
                    decoration: InputDecoration(
                      hintText: 'Ulangi Kata Sandi',
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
                      suffixIcon: IconButton(
                        icon: Icon(_isConfirmPasswordVisible
                            ? Icons.visibility_off
                            : Icons.visibility),
                        onPressed: () => setState(() =>
                            _isConfirmPasswordVisible =
                                !_isConfirmPasswordVisible),
                      ),
                    ),
                    style: const TextStyle(fontFamily: 'Poppins'),
                  ),
                  const SizedBox(height: 30),
                  ElevatedButton(
                    onPressed: _daftar,
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
                    child: const Text('Daftar'),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text('Sudah punya akun? ',
                          style:
                              TextStyle(fontSize: 12, fontFamily: 'Poppins')),
                      GestureDetector(
                        onTap: () {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const LoginPage()),
                          );
                        },
                        child: const Text('Masuk',
                            style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'Poppins')),
                      ),
                    ],
                  ),
                  const SizedBox(height: 30),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
