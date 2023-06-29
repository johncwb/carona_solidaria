import 'package:brasil_fields/brasil_fields.dart';
import 'package:carona_solidaria/create_trip/widgets/text_field_custom.dart';
import 'package:carona_solidaria/create_trip/widgets/title_fields.dart';
import 'package:carona_solidaria/utils/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import '../home/home_screen.dart';
import '../provider/google_sign_in.dart';
import 'widgets/create_button.dart';

class CreateTrip extends StatefulWidget {
  const CreateTrip({super.key});

  @override
  State<CreateTrip> createState() => _CreateTripState();
}

class _CreateTripState extends State<CreateTrip> {
  late final user = FirebaseAuth.instance.currentUser!;
  final TextEditingController destinyController = TextEditingController();
  final TextEditingController meetingController = TextEditingController();
  final TextEditingController phoneControlle =
      TextEditingController(text: "(00)0 0000-0000");
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: AppConstants.primaryColor,
        title: const Text("Criar Viagem"),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    return ListView(
      padding: const EdgeInsets.all(12),
      children: [
        const SizedBox(height: 16),
        const TitleField(title: "Informe o destino"),
        const SizedBox(height: 16),
        CustomTextFormField(
            label: "Endereço",
            hint: "Informe o destino",
            textInputType: TextInputType.streetAddress,
            controller: destinyController,
            textInputFormatter: FilteringTextInputFormatter(
                RegExp(r'[a-z A-Z.]'),
                allow: true)),
        const SizedBox(height: 16),
        const TitleField(title: "Informe um ponto de encontro"),
        const SizedBox(height: 16),
        CustomTextFormField(
            label: "Ponto de encontro",
            hint: "Informe um ponto de encontro",
            textInputType: TextInputType.text,
            controller: meetingController,
            textInputFormatter: FilteringTextInputFormatter(
                RegExp(r'[a-z A-Z.]'),
                allow: true)),
        const SizedBox(height: 16),
        const TitleField(title: "Informe um número para contato"),
        const SizedBox(height: 16),
        CustomTextFormField(
          label: "Número para contato",
          hint: "Informe um número para contato",
          textInputType: TextInputType.phone,
          controller: phoneControlle,
          textInputFormatter: FilteringTextInputFormatter.digitsOnly,
        ),
        const SizedBox(height: 32),
        CreateButton(
          text: "Criar Viagem",
          onTap: () {
            final provider =
                Provider.of<GoogleSignInProvider>(context, listen: false);
            final createTrip = provider.createTrip(
              user.displayName!,
              destinyController.text,
              meetingController.text,
              phoneControlle.text,
            );
            createTrip.whenComplete(() {
              Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const HomeScreen(
                      isDriver: false,
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
