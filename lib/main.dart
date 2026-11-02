import 'package:flutter/material.dart';

void main() {
  runApp(const CyberLabApp());
}

class CyberLabApp extends StatelessWidget {
  const CyberLabApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'CyberLab',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const CyberLabHome(),
    );
  }
}

class CyberLabHome extends StatelessWidget {
  const CyberLabHome({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('CyberLab Dashboard'),
      ),
      body: const Center(
        child: Text(
          'Welcome to CyberLab!',
          style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
