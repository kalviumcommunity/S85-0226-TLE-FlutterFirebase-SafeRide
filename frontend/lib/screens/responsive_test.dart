import 'package:flutter/material.dart';
import 'responsive_home.dart';

void main() {
  runApp(const ResponsiveTestApp());
}

class ResponsiveTestApp extends StatelessWidget {
  const ResponsiveTestApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SafeRide Responsive Test',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      home: const ResponsiveHome(),
      debugShowCheckedModeBanner: false,
    );
  }
}
