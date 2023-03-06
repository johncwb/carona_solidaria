import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    Timer(
      const Duration(milliseconds: 5000),
      () {
        Navigator.popAndPushNamed(context, '/home');
      },
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff113d63),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            _buildIconRow(),
            const SizedBox(height: 20),
            _buildTitle(),
            const SizedBox(height: 15),
            _buildSubtitle(),
          ],
        ),
      ),
    );
  }

  Widget _buildIconRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [Image.asset("assets/images/image_logo.png")],
    );
  }

  Widget _buildTitle() {
    return Text(
      "Carona Solidária",
      style: GoogleFonts.anton(
        color: Colors.white,
        fontSize: 42,
      ),
    );
  }

  Widget _buildSubtitle() {
    return Text(
      "Universidade Tuiuti do Paraná",
      style: GoogleFonts.anton(
        color: Colors.white,
        fontWeight: FontWeight.w300,
      ),
    );
  }
}
