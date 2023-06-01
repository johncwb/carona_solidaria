import 'package:carona_solidaria/home/home_screen.dart';
import 'package:carona_solidaria/landing/landing_screen.dart';
import 'package:carona_solidaria/services/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AuthCheck extends StatefulWidget {
  const AuthCheck({super.key});

  @override
  State<AuthCheck> createState() => _AuthCheckState();
}

class _AuthCheckState extends State<AuthCheck> {
  @override
  Widget build(BuildContext context) {
    AuthServices auth = Provider.of<AuthServices>(context);

    if (auth.isLoading) {
      return loading();
    } else if (auth.usuario == null) {
      return const LandingScreen();
    } else {
      const HomeScreen();
    }
    return Container();
  }

  Widget loading() {
    return const Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
