import 'package:carona_solidaria/home/home_screen.dart';
import 'package:carona_solidaria/provider/google_sign_in.dart';
import 'package:carona_solidaria/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../widgets/button_widget.dart';

class LandingScreen extends StatefulWidget {
  const LandingScreen({super.key});

  @override
  State<LandingScreen> createState() => _LandingScreenState();
}

class _LandingScreenState extends State<LandingScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _buildLogo(),
          const SizedBox(height: 100),
          _buildLoginButton(),
          const SizedBox(height: 20),
          _buildRegisterButton(),
          const SizedBox(height: 20),
          _buildguestButton(),
        ],
      ),
    );
  }

  Widget _buildLogo() {
    return Image.asset(
      "assets/images/image_logo.png",
      color: const Color(0xff113d63),
    );
  }

  Widget _buildLoginButton() {
    return ButtonWidgets(
      text: "Login ",
      function: () {
        final provider =
            Provider.of<GoogleSignInProvider>(context, listen: false);
        var login = provider.googleLogin();

        login.whenComplete(() {
          final user = provider.user;
          bool isUser = false;
          if (user.id.isNotEmpty) {
            isUser = true;
          }
          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                builder: (context) => HomeScreen(
                  isDriver: false,
                  isUser: isUser,
                ),
              ),
              (route) => false);
        });
      },
    );
  }

  Widget _buildRegisterButton() {
    return ButtonWidgets(
      text: "Registrar",
      function: () {
        Navigator.pushNamedAndRemoveUntil(
          context,
          '/register',
          (route) => false,
        );
      },
    );
  }

  Widget _buildguestButton() {
    return InkWell(
      onTap: () {
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
            builder: (context) => const HomeScreen(
              isDriver: false,
              isUser: false,
            ),
          ),
          (route) => false,
        );
      },
      child: const Text(
        "Entrar como convidado",
        style: TextStyle(
          color: AppConstants.primaryColor,
          fontSize: 16,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}
