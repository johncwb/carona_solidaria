import 'package:carona_solidaria/login/widgets/text_form_widget.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final formKey = GlobalKey<FormState>();
  final email = TextEditingController();
  final password = TextEditingController();

  bool isLogin = true;
  late String title;
  late String actionButton;
  late String toggleButton;

  @override
  void initState() {
    super.initState();
    setFormAction(true);
  }

  setFormAction(bool action) {
    setState(
      () {
        isLogin = action;
        if (isLogin) {
          title = "Bem Vindo";
          actionButton = 'Login';
          toggleButton = 'Ainda não tem conta? Cadastre-se agora.';
        } else {
          title = "Crie sua conta";
          actionButton = 'Cadastrar';
          toggleButton = 'Voltar ao Login.';
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    return SafeArea(
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Form(
            key: formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 36,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                _buildEmail(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildEmail() {
    return TextFormWidget(
      label: 'E-mail',
      hint: 'E-mail',
      controller: email,
      keyboardType: TextInputType.emailAddress,
      validator: (value) {
        if (value.isEmpty) {
          return 'Preencha seu email corretamente';
        }
        return null;
      },
    );
  }
}
