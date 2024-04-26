import 'package:flutter/material.dart';

class StartScreen extends StatefulWidget {
  const StartScreen({super.key});

  @override
  State<StartScreen> createState() => _StartScreenState();
}

class _StartScreenState extends State<StartScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text(
            'Face Search',
            style: TextStyle(
                color: Color(0xFF895EF5),
                fontWeight: FontWeight.bold,
                fontSize: 24.0),
          ),
        ),
        foregroundColor: Colors.white,
        elevation: 2.0,
      ),
    );
  }
}
