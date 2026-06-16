import 'package:flutter/material.dart';

class ChangePasswordPage extends StatefulWidget {
  const ChangePasswordPage({super.key});

  @override
  State<ChangePasswordPage> createState() => _ChangePasswordPageState();
}

class _ChangePasswordPageState extends State<ChangePasswordPage> {
  final _usernameController = TextEditingController();
  final _oldPasswordController = TextEditingController();
  final _newPasswordController = TextEditingController();
  final _confirmNewPasswordController = TextEditingController();

  bool _isOldPasswordVisible = false;
  bool _isNewPasswordVisible = false;
  bool _isConfirmNewPasswordVisible = false;

  @override
  void dispose() {
    _usernameController.dispose();
    _oldPasswordController.dispose();
    _newPasswordController.dispose();
    _confirmNewPasswordController.dispose();
    super.dispose();
  }

  void _ubahPassword() {
    String username = _usernameController.text.trim();
    String oldPassword = _oldPasswordController.text;
    String newPassword = _newPasswordController.text;
    String confirmNewPassword = _confirmNewPasswordController.text;

    if (username.isEmpty ||
        oldPassword.isEmpty ||
        newPassword.isEmpty ||
        confirmNewPassword.isEmpty) {
      _showSnackbar('Harap isi semua kolom!');
      return;
    }

    if (newPassword != confirmNewPassword) {
      _showSnackbar('Kata sandi baru tidak cocok!');
      return;
    }

    _showSnackbar('Kata sandi berhasil diubah!', isSuccess: true);
    Navigator.pop(context);
  }

  void _showSnackbar(String message, {bool isSuccess = false}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: isSuccess ? Colors.green : Colors.red,
      ),
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
          Positioned(
            top: -size.height * 0.12,
            left: 0,
            right: 0,
            child: Container(
              height: size.height * 0.50,
              decoration: const BoxDecoration(
                color: Color(0xFFB9E7F9),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(50),
                  bottomRight: Radius.circular(50),
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
            top: topPadding + 60,
            child: const SizedBox(
              width: 280,
              height: 200,
              child: Text.rich(
                TextSpan(
                  children: [
                    TextSpan(
                      text: 'Ubah\n',
                      style: TextStyle(
                        color: Color(0xFF3C3C3C),
                        fontSize: 55,
                        fontWeight: FontWeight.w700,
                        fontFamily: 'Poppins',
                        height: 1.0,
                      ),
                    ),
                    TextSpan(
                      text: 'Kata\n',
                      style: TextStyle(
                        color: Color(0xFF3C3C3C),
                        fontSize: 55,
                        fontWeight: FontWeight.w700,
                        fontFamily: 'Poppins',
                        height: 1.0,
                      ),
                    ),
                    TextSpan(
                      text: 'Sandi',
                      style: TextStyle(
                        color: Color(0xFF3C3C3C),
                        fontSize: 55,
                        fontWeight: FontWeight.w700,
                        fontFamily: 'Poppins',
                        height: 1.0,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
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
                  const Text('Kata Sandi Lama',
                      style: TextStyle(
                          fontWeight: FontWeight.w400, fontFamily: 'Poppins')),
                  const SizedBox(height: 8),
                  TextField(
                    controller: _oldPasswordController,
                    obscureText: !_isOldPasswordVisible,
                    decoration: InputDecoration(
                      hintText: 'Masukkan Kata Sandi Lama',
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
                        icon: Icon(_isOldPasswordVisible
                            ? Icons.visibility_off
                            : Icons.visibility),
                        onPressed: () => setState(() =>
                            _isOldPasswordVisible = !_isOldPasswordVisible),
                      ),
                    ),
                    style: const TextStyle(fontFamily: 'Poppins'),
                  ),
                  const SizedBox(height: 20),
                  const Text('Kata Sandi Baru',
                      style: TextStyle(
                          fontWeight: FontWeight.w400, fontFamily: 'Poppins')),
                  const SizedBox(height: 8),
                  TextField(
                    controller: _newPasswordController,
                    obscureText: !_isNewPasswordVisible,
                    decoration: InputDecoration(
                      hintText: 'Masukkan Kata Sandi Baru',
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
                        icon: Icon(_isNewPasswordVisible
                            ? Icons.visibility_off
                            : Icons.visibility),
                        onPressed: () => setState(() =>
                            _isNewPasswordVisible = !_isNewPasswordVisible),
                      ),
                    ),
                    style: const TextStyle(fontFamily: 'Poppins'),
                  ),
                  const SizedBox(height: 20),
                  const Text('Konfirmasi Kata Sandi Baru',
                      style: TextStyle(
                          fontWeight: FontWeight.w400, fontFamily: 'Poppins')),
                  const SizedBox(height: 8),
                  TextField(
                    controller: _confirmNewPasswordController,
                    obscureText: !_isConfirmNewPasswordVisible,
                    decoration: InputDecoration(
                      hintText: 'Ulangi Kata Sandi Baru',
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
                        icon: Icon(_isConfirmNewPasswordVisible
                            ? Icons.visibility_off
                            : Icons.visibility),
                        onPressed: () => setState(() =>
                            _isConfirmNewPasswordVisible =
                                !_isConfirmNewPasswordVisible),
                      ),
                    ),
                    style: const TextStyle(fontFamily: 'Poppins'),
                  ),
                  const SizedBox(height: 30),
                  ElevatedButton(
                    onPressed: _ubahPassword,
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
                    child: const Text('Ubah'),
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
