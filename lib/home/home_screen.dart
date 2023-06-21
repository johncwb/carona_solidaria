import 'package:carona_solidaria/profile/profile_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key, required this.isUser});
  final bool isUser;

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late final user = FirebaseAuth.instance.currentUser!;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: const Color(0xff113d63),
        title: InkWell(
          onTap: () => widget.isUser
              ? Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: ((context) => const ProfileScreen()),
                  ),
                )
              : showGuestMessage(),
          child: widget.isUser ? _buildListTileLogged() : _buildListTileGuest(),
        ),
      ),
    );
  }

  Widget _buildListTileLogged() {
    return ListTile(
      title: _buildTitleLogged(),
      leading: CircleAvatar(
        radius: 20,
        backgroundImage: NetworkImage(user.photoURL!),
      ),
    );
  }

  Widget _buildListTileGuest() {
    return ListTile(
      title: _buildTitlleGuest(),
    );
  }

  Widget _buildTitlleGuest() {
    return const Text(
      "Olá, convidado",
      style: TextStyle(
        color: Colors.white,
        fontSize: 16,
        fontWeight: FontWeight.w400,
      ),
    );
  }

  Widget _buildTitleLogged() {
    return Text(
      "Olá, ${user.displayName}",
      style: const TextStyle(
        color: Colors.white,
        fontSize: 16,
        fontWeight: FontWeight.w400,
      ),
    );
  }

  showGuestMessage() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text("Voçê entrou como convidado!"),
        duration: const Duration(seconds: 5),
        action: SnackBarAction(
            label: "Fechar",
            onPressed: () {
              ScaffoldMessenger.of(context).hideCurrentSnackBar();
            }),
      ),
    );
  }
}
