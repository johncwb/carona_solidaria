import 'package:carona_solidaria/home/home_screen.dart';
import 'package:carona_solidaria/provider/google_sign_in.dart';
import 'package:carona_solidaria/register/register_screen.dart';
import 'package:carona_solidaria/utils/constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
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
          // _buildRegisterButton(),
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
      function: () async {
        final provider =
            Provider.of<GoogleSignInProvider>(context, listen: false);
        var login = provider.googleLogin();
        var userGoogle = provider.userGoogle!.id;
        var val = await provider.checkCollectionExisting(userGoogle);
        var collection = provider.db.collection('users');
        var doc = collection.doc(userGoogle);
        var getDoc = doc.get();
        late String nome;
        late bool isDriver;
        getDoc.then((DocumentSnapshot<Map<String, dynamic>> snapshot) {
          if (snapshot.exists) {
            Map<String, dynamic> data = snapshot.data()!;
            nome = data['name'];
            isDriver = data['isDriver'];
            debugPrint("Nome: $nome\nisDriver: $isDriver");
          }
        });

        if (val) {
          login.whenComplete(() {
            final user = provider.user;
            bool isUser = false;
            if (user.id.isNotEmpty) {
              isUser = true;
            }
            Navigator.pushNamedAndRemoveUntil(
                context, '/register', (route) => false);
            // Navigator.pushAndRemoveUntil(
            //     context,
            //     MaterialPageRoute(
            //       builder: (context) => HomeScreen(
            //         isDriver: isDriver,
            //         isUser: isUser,
            //       ),
            //     ),
            //     (route) => false);
          });
        } else {
          login.whenComplete(() {
            Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                  builder: (context) => const RegisterScreen(),
                ),
                (route) => false);
          });
        }
      },
    );
  }

  // Widget _buildRegisterButton() {
  //   return ButtonWidgets(
  //     text: "Registrar",
  //     function: () async {
  //       final provider =
  //           Provider.of<GoogleSignInProvider>(context, listen: false);
  //       var userGoogle = provider.userGoogle!.id;
  //       var val = await provider.checkCollectionExisting(userGoogle);
  //       var register = provider.googleLogin();
  //       if (!val) {
  //         register.whenComplete(() {
  //           Navigator.pushNamedAndRemoveUntil(
  //             context,
  //             '/register',
  //             (route) => false,
  //           );
  //         });
  //       }

  //       // provider.googleRegister(() {});
  //     },
  //   );
  // }

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
