import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:geolocator/geolocator.dart';
import 'package:url_launcher/url_launcher.dart';
import 'add_location_page.dart';

class LokasiPage extends StatefulWidget {
  const LokasiPage({super.key});

  @override
  State<LokasiPage> createState() => _LokasiPageState();
}

class _LokasiPageState extends State<LokasiPage> {
  // Controller peta agar bisa kita gerakkan
  final MapController _mapController = MapController();

  // Data pohon bintaro
  List<Map<String, dynamic>> _pohonBintaro = [];

  // Posisi user saat ini
  LatLng? _currentPosition;

  @override
  void initState() {
    super.initState();
    _loadData();
    _getCurrentLocation(); // deteksi posisi user saat halaman dibuka
  }

  // Fungsi mengambil data dari penyimpanan lokal
  Future<void> _loadData() async {
    final prefs = await SharedPreferences.getInstance();
    final storedList = prefs.getStringList('pohon_bintaro') ?? [];

    setState(() {
      _pohonBintaro = [
        // Data statis ITS (bisa dihapus kalau tidak perlu)
        {'nama': 'Pohon Bintaro 1', 'lat': -7.282356, 'lng': 112.793889},
        {'nama': 'Pohon Bintaro 2', 'lat': -7.283500, 'lng': 112.795000},
      ];

      for (var entry in storedList) {
        final parts = entry.split('|');
        if (parts.length == 3) {
          _pohonBintaro.add({
            'nama': parts[0],
            'lat': double.parse(parts[1]),
            'lng': double.parse(parts[2]),
          });
        }
      }
    });
  }

  // Fungsi mendapatkan lokasi user
  Future<void> _getCurrentLocation() async {
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

      setState(() {
        _currentPosition = LatLng(position.latitude, position.longitude);
      });

      // Gerakkan peta ke lokasi user
      _mapController.move(_currentPosition!, 16.0);
    } catch (e) {
      _showSnackbar('Gagal mendapatkan lokasi: $e');
    }
  }

  // Fungsi buka Google Maps
  Future<void> _openGoogleMaps(double lat, double lng) async {
    final url = 'https://www.google.com/maps/dir/?api=1&destination=$lat,$lng';
    if (await canLaunchUrl(Uri.parse(url))) {
      await launchUrl(Uri.parse(url));
    } else {
      _showSnackbar('Tidak dapat membuka Google Maps');
    }
  }

  // Tampilkan detail pohon & tombol arahkan
  void _showPohonDetail(Map<String, dynamic> pohon) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (ctx) {
        return Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                pohon['nama'],
                style: const TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                'Lat: ${pohon['lat']}, Lng: ${pohon['lng']}',
                style:
                    const TextStyle(fontFamily: 'Poppins', color: Colors.grey),
              ),
              const SizedBox(height: 20),
              ElevatedButton.icon(
                onPressed: () {
                  Navigator.pop(ctx);
                  _openGoogleMaps(pohon['lat'], pohon['lng']);
                },
                icon: const Icon(Icons.directions),
                label: const Text('Buka di Google Maps',
                    style: TextStyle(fontFamily: 'Poppins')),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF91BF71),
                  foregroundColor: Colors.white,
                  minimumSize: const Size(double.infinity, 45),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  void _showSnackbar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message), backgroundColor: Colors.red),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, size: 28),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Lokasi',
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
        actions: [
          // Tombol "Lokasi Saya" di kanan atas
          IconButton(
            icon: const Icon(Icons.my_location, size: 28),
            onPressed: _getCurrentLocation,
            tooltip: 'Lokasi Saya',
          ),
        ],
      ),
      body: Stack(
        children: [
          FlutterMap(
            mapController: _mapController,
            options: MapOptions(
              // Pusatkan ke ITS sebagai fallback
              initialCenter: const LatLng(-7.282356, 112.793889),
              initialZoom: 16.0,
              onTap: (_, __) {
                // Kalau user klik area kosong di peta, bisa kita tutup popup yang ada
              },
            ),
            children: [
              TileLayer(
                urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                userAgentPackageName: 'com.fruitcheck.app',
              ),
              // Marker pohon bintaro
              MarkerLayer(
                markers: _pohonBintaro.map((pohon) {
                  return Marker(
                    point: LatLng(pohon['lat'], pohon['lng']),
                    width: 80,
                    height: 80,
                    child: GestureDetector(
                      onTap: () => _showPohonDetail(pohon),
                      child: const Icon(Icons.location_on,
                          color: Colors.red, size: 40),
                    ),
                  );
                }).toList(),
              ),
              // Marker lokasi user (ikon biru)
              if (_currentPosition != null)
                MarkerLayer(
                  markers: [
                    Marker(
                      point: _currentPosition!,
                      width: 80,
                      height: 80,
                      child: const Icon(Icons.my_location,
                          color: Colors.blue, size: 40),
                    ),
                  ],
                ),
            ],
          ),
          // Tombol + (tambah lokasi) tetap di kanan bawah
          Positioned(
            bottom: 20,
            right: 20,
            child: FloatingActionButton(
              backgroundColor: const Color(0xFF91BF71),
              onPressed: () async {
                final result = await Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const AddLocationPage()),
                );
                if (result == true) {
                  _loadData(); // Refresh data
                }
              },
              child: const Icon(Icons.add, color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}
