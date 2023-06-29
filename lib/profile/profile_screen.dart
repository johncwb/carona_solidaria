import 'package:carona_solidaria/utils/constants.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:simple_star_rating/simple_star_rating.dart';

import '../provider/google_sign_in.dart';
import 'widgets/edit_profile_button.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  late final user = FirebaseAuth.instance.currentUser!;

  @override
  Widget build(BuildContext context) {
    debugPrint("Bem Vindo\n ${user.displayName}");
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back),
        ),
        automaticallyImplyLeading: false,
        backgroundColor: AppConstants.primaryColor,
        title: const Text("Perfil"),
      ),
      body: _bemVindo(),
    );
  }

  Widget _bemVindo() {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 15),
                CircleAvatar(
                  radius: 60,
                  backgroundImage: NetworkImage(user.photoURL!),
                ),
                const SizedBox(height: 15),
                _ratingStar(),
                const SizedBox(height: 15),
                _buildInfo("Nome: ", "${user.displayName}"),
                const SizedBox(height: 15),
                _buildInfo("E-mail: ", "${user.email}"),
                const SizedBox(height: 15),
                _buildInfo("Você é: ", "Passageiro"),
                const SizedBox(height: 15),
                const EditProfileButton(),
                const SizedBox(height: 15),
                InkWell(
                  onTap: () {
                    setState(() {
                      onTapLogout();
                    });
                  },
                  child: const Text(
                    'Sair da conta!',
                    style: TextStyle(
                      color: Colors.red,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildInfo(String? label, String? info) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        border: Border.all(
          width: 1.5,
          color: const Color(0xff113d63),
        ),
        borderRadius: const BorderRadius.all(
          Radius.circular(20.0),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label!),
          Text(info!),
        ],
      ),
    );
  }

  onTapLogout() {
    setState(() {
      final provider =
          Provider.of<GoogleSignInProvider>(context, listen: false);
      provider.googleLogOut();
      Navigator.of(context).pushNamedAndRemoveUntil(
        '/landing',
        (route) => false,
      );
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Você foi desconectado."),
          duration: Duration(seconds: 2),
        ),
      );
    });
  }

  Widget _ratingStar() {
    return SimpleStarRating(
      allowHalfRating: true,
      starCount: 5,
      rating: 4.5,
      isReadOnly: true,
    );
  }
}
