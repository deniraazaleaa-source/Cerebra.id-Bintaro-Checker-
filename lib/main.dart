import 'package:flutter/material.dart';
import 'package:tflite_flutter/tflite_flutter.dart';
import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;
import 'home_page.dart';
import 'camera_page.dart';
import 'register_page.dart';
import 'login_page.dart';
import 'begin_page.dart';

late Interpreter interpreter;
late List<String> labels;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  interpreter = await Interpreter.fromAsset(
    'assets/models/mobilenet_bintaro.tflite',
  );

  String labelsJson = await rootBundle.loadString('assets/models/labels.json');
  labels = List<String>.from(json.decode(labelsJson));

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'FruitCheck Bintaro',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.green),
      initialRoute: '/',
      routes: {
        '/': (context) => const BeginPage(),
        '/register': (context) => const RegisterPage(),
        '/login': (context) => const LoginPage(),
        '/home': (context) => const HomePage(),
        '/camera': (context) => const CameraPage(),
      },
    );
  }
}
