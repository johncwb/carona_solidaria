import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class GoogleSignInProvider extends ChangeNotifier {
  final googleSignIn = GoogleSignIn();

  GoogleSignInAccount? _user;

  GoogleSignInAccount get user => _user!;

  FirebaseFirestore db = FirebaseFirestore.instance;

  //Função para fazer o login com o google
  Future googleLogin() async {
    //capturando dados do login
    final googleUser = await googleSignIn.signIn();
    if (googleUser == null) return;
    _user = googleUser;

    final googleAuth = await googleUser.authentication;

    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );
    debugPrint("acessToken: ${googleAuth.accessToken}");
    debugPrint("idToken: ${googleAuth.idToken}");
    CollectionReference collection =
        FirebaseFirestore.instance.collection('users');
    await collection.add(({
      'id': _user?.id,
      'name': _user?.displayName,
      'isDriver': false,
    }));
    await FirebaseAuth.instance.signInWithCredential(credential);
  }

  Future googleRegister() async {
    final googleUser = await googleSignIn.signIn();
    if (googleUser == null) return;
    _user = googleUser;

    final googleAuth = await googleUser.authentication;

    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );
    var id = db.collection(_user!.id);
    // ignore: unnecessary_null_comparison
    if (id == null) {
      debugPrint("Usuário não encontrado");
    }

    await FirebaseAuth.instance.signInWithCredential(credential);
    notifyListeners();
  }

  Future validadeUser() async {
    CollectionReference colletion =
        FirebaseFirestore.instance.collection('Usuário');
    QuerySnapshot querySnapshot = await colletion.get();
    for (var e in querySnapshot.docs) {
      debugPrint("Testando: ${e.id}");
    }
  }

  Future googleLogOut() async {
    FirebaseAuth auth = FirebaseAuth.instance;
    await auth.signOut();
    debugPrint("Usuário desconectado");
  }

  Future updateUser([String? path]) async {
    db.collection('');
  }
}
