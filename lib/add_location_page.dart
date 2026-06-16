import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AddLocationPage extends StatefulWidget {
  const AddLocationPage({super.key});

  @override
  State<AddLocationPage> createState() => _AddLocationPageState();
}

class _AddLocationPageState extends State<AddLocationPage> {
  final _namaController = TextEditingController();
  final _latController = TextEditingController();
  final _lngController = TextEditingController();

  bool _isLoadingLocation = false;

  @override
  void dispose() {
    _namaController.dispose();
    _latController.dispose();
    _lngController.dispose();
    super.dispose();
  }

  Future<void> _gunakanLokasiSekarang() async {
    setState(() => _isLoadingLocation = true);

    try {
      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          _showSnackbar('Izin lokasi ditolak');
          return;
        }
      }

      if (permission == LocationPermission.deniedForever) {
        _showSnackbar('Izin lokasi ditolak permanen. Buka pengaturan.');
        return;
      }

      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );

      _latController.text = position.latitude.toStringAsFixed(6);
      _lngController.text = position.longitude.toStringAsFixed(6);
    } catch (e) {
      _showSnackbar('Gagal mendapatkan lokasi: $e');
    } finally {
      setState(() => _isLoadingLocation = false);
    }
  }

  Future<void> _simpan() async {
    if (_namaController.text.isEmpty ||
        _latController.text.isEmpty ||
        _lngController.text.isEmpty) {
      _showSnackbar('Harap isi semua kolom!');
      return;
    }

    final lat = double.tryParse(_latController.text);
    final lng = double.tryParse(_lngController.text);
    if (lat == null || lng == null) {
      _showSnackbar('Koordinat harus berupa angka!');
      return;
    }

    final prefs = await SharedPreferences.getInstance();
    final existingJson = prefs.getStringList('pohon_bintaro') ?? [];
    final newEntry = '${_namaController.text}|$lat|$lng';
    existingJson.add(newEntry);
    await prefs.setStringList('pohon_bintaro', existingJson);

    Navigator.pop(context, true);
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
          Positioned(
            left: 10,
            top: topPadding + 10,
            child: IconButton(
              icon: const Icon(Icons.arrow_back, size: 28),
              onPressed: () => Navigator.pop(context),
            ),
          ),
          Positioned(
            top: topPadding + 70,
            left: 0,
            right: 0,
            bottom: 0,
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 40),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const Text(
                    'Tambah Pohon',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 35,
                      fontWeight: FontWeight.w700,
                      color: Color(0xFF3C3C3C),
                      fontFamily: 'Poppins',
                    ),
                  ),
                  const SizedBox(height: 30),
                  const Text('Nama Pohon',
                      style: TextStyle(
                          fontWeight: FontWeight.w400, fontFamily: 'Poppins')),
                  const SizedBox(height: 8),
                  TextField(
                    controller: _namaController,
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
                  ),
                  const SizedBox(height: 20),
                  const Text('Lokasi (Latitude)',
                      style: TextStyle(
                          fontWeight: FontWeight.w400, fontFamily: 'Poppins')),
                  const SizedBox(height: 8),
                  TextField(
                    controller: _latController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      hintText: 'Masukkan Latitude',
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
                  const Text('Lokasi (Longitude)',
                      style: TextStyle(
                          fontWeight: FontWeight.w400, fontFamily: 'Poppins')),
                  const SizedBox(height: 8),
                  TextField(
                    controller: _lngController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      hintText: 'Masukkan Longitude',
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
                  const SizedBox(height: 30),
                  ElevatedButton(
                    onPressed: _simpan,
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
                    child: const Text('Simpan'),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    'Atau',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Colors.black.withOpacity(0.5),
                        fontSize: 13,
                        fontFamily: 'Poppins'),
                  ),
                  const SizedBox(height: 12),
                  OutlinedButton.icon(
                    onPressed:
                        _isLoadingLocation ? null : _gunakanLokasiSekarang,
                    icon: _isLoadingLocation
                        ? const SizedBox(
                            width: 18,
                            height: 18,
                            child: CircularProgressIndicator(strokeWidth: 2))
                        : const Icon(Icons.my_location),
                    label: const Text('Gunakan lokasi saat ini',
                        style: TextStyle(
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w700)),
                    style: OutlinedButton.styleFrom(
                      foregroundColor: Colors.black.withOpacity(0.5),
                      side: const BorderSide(color: Color(0xFF91BF71)),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30)),
                      padding: const EdgeInsets.symmetric(vertical: 12),
                    ),
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
