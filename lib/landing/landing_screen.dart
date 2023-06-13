import 'package:carona_solidaria/provider/google_sign_in.dart';
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
        provider.googleLogin();
      },
    );
  }

  Widget _buildRegisterButton() {
    return ButtonWidgets(
      text: "Registrar",
      function: () {},
    );
  }

  Widget _buildguestButton() {
    return const Text("Entrar como convidado");
  }
}
