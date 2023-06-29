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
  final FirebaseAuth _auth = FirebaseAuth.instance;

  late GoogleSignInAccount userObj;

  Future<UserCredential> signInWithGoogle() async {
    // final GoogleSignInAccount? _googleUser = await googleSignIn.signIn();
    userGoogle = await googleSignIn.signIn();
    final GoogleSignInAuthentication googleAuth =
        await userGoogle!.authentication;
    final OAuthCredential credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );
    Map<String, dynamic> data = {
      'id': userGoogle?.id,
      'name': userGoogle?.displayName,
      'isDriver': false,
    };
    db
        .collection('users')
        .doc(userGoogle?.id)
        .set(data)
        .then((value) => debugPrint("Dados adicionados com sucesso!"))
        .catchError(
            (error) => debugPrint("Erro ao adicionar os dados: $error"));
    return await _auth.signInWithCredential(credential);
  }

  Future createTrip(
    String name,
    String destiny,
    String meetingPoint,
    String phone,
  ) async {
    Map<String, dynamic> data = {
      'name': name,
      'destiny': destiny,
      'meetinPoint': meetingPoint,
      'phone': phone,
    };
    db
        .collection('trips')
        .doc()
        .set(data)
        .then((value) => debugPrint("Dados adicionados com sucesso!"))
        .catchError(
            (error) => debugPrint("Erro ao adicionar os dados: $error"));
  }

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

  Future googleRegister() async {
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
        await FirebaseFirestore.instance.collection('users');
    collectionReference.doc(userGoogle?.id).set({
      'id': userGoogle?.id,
      'name': userGoogle?.displayName,
      'isDriver': isDriver,
    });
  }

  Future saveCar(String motorista, String modeloCarro, String placa,
      String color, String id) async {
    final CollectionReference collectionReference =
        FirebaseFirestore.instance.collection('users');

    collectionReference.doc(id).set({
      "Motorista": motorista,
      "modeloCarro": modeloCarro,
      "placa": placa,
      "corDoCarro": color,
    });
  }
}
