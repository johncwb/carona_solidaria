import 'package:carona_solidaria/widgets/button_widget.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
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
    return const ButtonWidgets(text: "Login ");
  }

  Widget _buildRegisterButton() {
    return const ButtonWidgets(text: "Registrar");
  }

  Widget _buildguestButton() {
    return const Text("Entrar como convidado");
  }
}
