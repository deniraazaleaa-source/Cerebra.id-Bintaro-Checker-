import 'dart:io';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:image/image.dart' as img;
import 'main.dart';
import 'placeholder_page.dart';
import 'pengolahan_page.dart';

class ResultPage extends StatefulWidget {
  final File imageFile;
  const ResultPage({super.key, required this.imageFile});

  @override
  State<ResultPage> createState() => _ResultPageState();
}

class _ResultPageState extends State<ResultPage> {
  String _hasil = "Memproses...";
  String _confidence = "";
  bool _isBintaro = true;

  String capitalize(String s) {
    if (s.isEmpty) return s;
    return s[0].toUpperCase() + s.substring(1);
  }

  @override
  void initState() {
    super.initState();
    _klasifikasi();
  }

  Future<void> _klasifikasi() async {
    final imageBytes = widget.imageFile.readAsBytesSync();
    img.Image? image = img.decodeImage(imageBytes);
    if (image == null) return;

    image = img.adjustColor(image, brightness: 1.1, contrast: 1.1);

    final int maxDim = max(image.width, image.height);
    if (maxDim > 800) {
      final double scale = 800 / maxDim;
      image = img.copyResize(
        image,
        width: (image.width * scale).round(),
        height: (image.height * scale).round(),
      );
    }

    final int minDim = min(image.width, image.height);
    final int cropSize = (minDim * 0.8).round();
    final int x = ((image.width - cropSize) / 2).round();
    final int y = ((image.height - cropSize) / 2).round();
    img.Image cropped =
        img.copyCrop(image, x: x, y: y, width: cropSize, height: cropSize);

    final resized = img.copyResize(cropped, width: 224, height: 224);

    final input = List.generate(
      1,
      (i) => List.generate(
        224,
        (j) => List.generate(
          224,
          (k) {
            final pixel = resized.getPixel(j, k);
            return [
              pixel.r / 255.0,
              pixel.g / 255.0,
              pixel.b / 255.0,
            ];
          },
        ),
      ),
    );

    final output = List.generate(1, (i) => List.filled(3, 0.0));
    interpreter.run(input, output);

    final predictions = output[0];
    final sorted = predictions.asMap().entries.toList()
      ..sort((a, b) => b.value.compareTo(a.value));
    final top1Value = sorted[0].value;
    final top1Index = sorted[0].key;
    final top2Value = sorted[1].value;
    final confidencePercent = top1Value * 100;
    final gap = top1Value - top2Value;

    const double maxConfThreshold = 70.0;
    const double minGap = 0.2;

    if (confidencePercent < maxConfThreshold || gap < minGap) {
      setState(() {
        _isBintaro = false;
        _hasil = "Bukan Buah Bintaro";
        _confidence = "${confidencePercent.toStringAsFixed(1)}% "
            "(selisih ${(gap * 100).toStringAsFixed(1)}%)";
      });
    } else {
      setState(() {
        _isBintaro = true;
        _hasil = labels[top1Index]; // "kering", "matang", "mentah"
        _confidence = '${confidencePercent.toStringAsFixed(1)}%';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    Color statusColor;
    final hasilLower = _hasil.toLowerCase();
    if (hasilLower == 'matang') {
      statusColor = const Color(0xFFEF5759); // merah
    } else if (hasilLower == 'mentah') {
      statusColor = const Color(0xFF91BF71); // hijau
    } else {
      statusColor = const Color(0xFF3C3C3C); // hitam
    }

    bool tampilkanTombol = _isBintaro;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, size: 28),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Scanner',
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
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: size.width * 0.05),
        child: Column(
          children: [
            SizedBox(height: size.height * 0.02),
            Expanded(
              flex: 5,
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: const Color(0xFF724E18),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Image.file(
                    widget.imageFile,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            SizedBox(height: size.height * 0.02),
            Text(
              'Status Buah :',
              style: TextStyle(
                fontSize: size.width * 0.05,
                fontWeight: FontWeight.w600,
                color: const Color(0xFF3C3C3C),
                fontFamily: 'Poppins',
              ),
            ),
            SizedBox(height: size.height * 0.01),
            Text(
              _isBintaro ? capitalize(_hasil) : 'Tidak Dikenali',
              style: TextStyle(
                fontSize: size.width * 0.05,
                fontWeight: FontWeight.w600,
                color: _isBintaro ? statusColor : Colors.red,
                fontFamily: 'Poppins',
              ),
            ),
            SizedBox(height: size.height * 0.02),
            if (tampilkanTombol)
              Container(
                width: size.width * 0.6,
                height: size.height * 0.06,
                padding: const EdgeInsets.symmetric(horizontal: 12),
                decoration: ShapeDecoration(
                  color: const Color(0xFF91BF71),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                alignment: Alignment.center,
                child: FittedBox(
                  fit: BoxFit.scaleDown,
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              PengolahanPage(statusBuah: _hasil),
                        ),
                      );
                    },
                    child: const Text(
                      'Cari saran Pengolahan!',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                        fontFamily: 'Poppins',
                      ),
                    ),
                  ),
                ),
              ),
            SizedBox(height: size.height * 0.02),
            if (_isBintaro)
              Text(
                'Keyakinan: $_confidence',
                style: TextStyle(
                  fontSize: size.width * 0.035,
                  color: Colors.grey,
                ),
              ),
            SizedBox(height: size.height * 0.02),
          ],
        ),
      ),
    );
  }
}
