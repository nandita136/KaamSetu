import 'package:flutter/material.dart';
import 'screens/splash_screen.dart';

void main() {
  runApp(const KaamSetuApp());
}

class KaamSetuApp extends StatelessWidget {
  const KaamSetuApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'KaamSetu',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
        useMaterial3: true,
        scaffoldBackgroundColor: const Color(0xFFF5F5F5),
      ),
      home: const SplashScreen(),
    );
  }
}