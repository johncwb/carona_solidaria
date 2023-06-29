import 'package:brasil_fields/brasil_fields.dart';
import 'package:carona_solidaria/create_trip/widgets/create_button.dart';
import 'package:carona_solidaria/create_trip/widgets/title_fields.dart';
import 'package:carona_solidaria/register/widgets/text_field_widget.dart';
import 'package:carona_solidaria/utils/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import '../home/home_screen.dart';
import '../provider/google_sign_in.dart';

class RegisterCarScreen extends StatefulWidget {
  const RegisterCarScreen({super.key});

  @override
  State<RegisterCarScreen> createState() => _RegisterCarScreenState();
}

class _RegisterCarScreenState extends State<RegisterCarScreen> {
  final TextEditingController modelController = TextEditingController();
  final TextEditingController placaController = TextEditingController();
  final TextEditingController colorController = TextEditingController();
  late final user = FirebaseAuth.instance.currentUser!;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text("Informações do seu veículo"),
        centerTitle: true,
        backgroundColor: AppConstants.primaryColor,
      ),
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    return ListView(
      padding: const EdgeInsets.all(12),
      children: [
        const SizedBox(height: 12),
        const TitleField(title: "Modelo do carro"),
        const SizedBox(height: 12),
        CustomTextFormField(
          textInputType: TextInputType.text,
          textInputFormatter:
              FilteringTextInputFormatter(RegExp(r'[a-z A-Z.]'), allow: true),
          hint: "Informe o modelo do carro",
          label: "Modelo do carro",
          controller: modelController,
        ),
        const SizedBox(height: 12),
        const TitleField(title: "Modelo do carro"),
        const SizedBox(height: 12),
        CustomTextFormField(
          textInputType: TextInputType.text,
          textInputFormatter: PlacaVeiculoInputFormatter(),
          // FilteringTextInputFormatter(RegExp(r'[a-z - A-Z.]'), allow: true),
          hint: "Informe a placa do carro",
          label: "Placa do carro",
          controller: placaController,
        ),
        const SizedBox(height: 12),
        const TitleField(title: "Cor do carro"),
        const SizedBox(height: 12),
        CustomTextFormField(
          textInputType: TextInputType.text,
          textInputFormatter:
              FilteringTextInputFormatter(RegExp(r'[a-z A-Z.]'), allow: true),
          hint: "Informe a cor do carro",
          label: "Cor do carro",
          controller: colorController,
        ),
        const SizedBox(height: 30),
        CreateButton(
          text: "Cadastar carro",
          onTap: () {
            final provider =
                Provider.of<GoogleSignInProvider>(context, listen: false);
            final saveUser = provider.userGoogle!.id;
            var registerCar = provider.saveCar(
              user.displayName!,
              modelController.text,
              placaController.text,
              colorController.text,
              user.uid,
            );
            registerCar.whenComplete(() {
              Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const HomeScreen(
                      isDriver: true,
                      isUser: true,
                    ),
                  ),
                  (route) => false);
            });
          },
        ),
      ],
    );
  }
}
