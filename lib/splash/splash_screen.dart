import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

import '../utils/connection_checker/connection_checker.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  late final StreamSubscription<InternetConnectionStatus> listener;
  @override
  void initState() {
    listener = InternetConnectionChecker().onStatusChange.listen((status) {
      final notifier = ConnectionNotifier.of(context);
      notifier.value =
          status == InternetConnectionStatus.connected ? true : false;
      if (notifier.value) {
        Navigator.popAndPushNamed(context, '/home');
      }
    });

    // Timer(
    //   const Duration(milliseconds: 3000),
    //   () {
    //     Navigator.popAndPushNamed(context, '/home');
    //   },
    // );
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
