import 'package:flutter/material.dart';
import 'package:matriks/HomePage.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        appBarTheme: AppBarTheme(
          iconTheme: IconThemeData(color: Colors.white), // Mengubah warna ikon AppBar
        ),
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.deepPurple,
          primary: Colors.white, // Warna teks dasar
          onPrimary: Colors.black, // Warna teks di atas latar putih
        ),
        useMaterial3: true,
      ),
      home: HomePage(),
    );
  }
}