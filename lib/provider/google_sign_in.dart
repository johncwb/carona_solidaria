// ignore_for_file: unnecessary_null_comparison

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class GoogleSignInProvider extends ChangeNotifier {
  final googleSignIn = GoogleSignIn();

  GoogleSignInAccount? userGoogle;

  GoogleSignInAccount get user => userGoogle!;

  FirebaseFirestore db = FirebaseFirestore.instance;

  //Função para fazer o login com o google
  Future googleLogin() async {
    //capturando dados do login
    final googleUser = await googleSignIn.signIn();
    if (googleUser == null) return;
    userGoogle = googleUser;

    final googleAuth = await googleUser.authentication;

    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    debugPrint("googleUserId: ${googleUser.id}");
    Map<String, dynamic> data = {
      'id': userGoogle?.id,
      'name': userGoogle?.displayName,
      'isDriver': false,
    };

    db
        .collection('users')
        .doc(googleUser.id)
        .set(data)
        .then((value) => debugPrint("Dados adicionados com sucesso!"))
        .catchError(
            (error) => debugPrint("Erro ao adicionar os dados: $error"));

    await FirebaseAuth.instance.signInWithCredential(credential);
  }

  Future googleRegister(Function? fun) async {
    final googleUser = await googleSignIn.signIn();

    bool exists = await checkCollectionExisting(googleUser!.id);
    if (exists) {
      fun!();
    } else {
      //capturando dados do login
      final googleUser = await googleSignIn.signIn();
      if (googleUser == null) return;
      userGoogle = googleUser;

      final googleAuth = await googleUser.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      debugPrint("googleUserId: ${googleUser.id}");
      Map<String, dynamic> data = {
        'id': userGoogle?.id,
        'name': userGoogle?.displayName,
        'isDriver': false,
      };

      db
          .collection('users')
          .doc(googleUser.id)
          .set(data)
          .then((value) => debugPrint("Dados adicionados com sucesso!"))
          .catchError(
              (error) => debugPrint("Erro ao adicionar os dados: $error"));

      await FirebaseAuth.instance.signInWithCredential(credential);
    }
  }

  Future googleLogOut() async {
    FirebaseAuth auth = FirebaseAuth.instance;
    await auth.signOut();
    debugPrint("Usuário desconectado");
  }

  Future<bool> checkCollectionExisting(String collectionName) async {
    final CollectionReference collectionReference =
        FirebaseFirestore.instance.collection('users');
    collectionReference.doc(collectionName);
    final QuerySnapshot querySnapshot =
        await collectionReference.limit(1).get();

    return querySnapshot.size > 0;
  }

  Future saveUser(bool isDriver) async {
    final CollectionReference collectionReference =
        FirebaseFirestore.instance.collection('users');
    collectionReference.doc(userGoogle!.id).set({
      'id': userGoogle?.id,
      'name': userGoogle?.displayName,
      'isDriver': false,
    });
  }
}
