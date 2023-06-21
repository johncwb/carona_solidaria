import 'package:carona_solidaria/home/home_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthCheck extends StatefulWidget {
  const AuthCheck({super.key});

  @override
  State<AuthCheck> createState() => _AuthCheckState();
}

class _AuthCheckState extends State<AuthCheck> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: ((context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            debugPrint("Loading...");
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasData) {
            debugPrint("Load data sucessful!!");
            debugPrint("Name: ${snapshot.data!.displayName}");
            debugPrint("E-mail: ${snapshot.data!.email}");
            return const HomeScreen(isUser: true);
          } else if (snapshot.hasError) {
            debugPrint("Error on load data!");
            return const Center(
              child: Text(
                'Desculpe, algo deu errado! :(',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            );
          } else {
            debugPrint("Tamo aqui caralho");
            return Container(
              height: 50,
              width: 50,
              color: Colors.amber,
            );
          }
        }),
      ),
    );
  }
}
