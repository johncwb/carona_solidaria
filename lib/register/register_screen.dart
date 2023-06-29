import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../home/home_screen.dart';
import '../provider/google_sign_in.dart';
import '../utils/constants.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  List<bool> _selections = [false, false];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            _buildLogo(),
            const SizedBox(height: 30),
            _buildText(),
            const SizedBox(height: 30),
            _buildOptions(),
            const SizedBox(height: 30),
            _buildRegisterButton(),
          ],
        ),
      ),
    );
  }

  Widget _buildText() {
    return const Text(
      "Usará o aplicativo como: ",
      style: TextStyle(
        color: AppConstants.primaryColor,
        fontSize: 18,
        fontWeight: FontWeight.w400,
      ),
    );
  }

  Widget _buildLogo() {
    return Image.asset(
      "assets/images/logo_completa.png",
      height: 250,
    );
  }

  Widget _buildOptions() {
    return ToggleButtons(
      borderColor: Colors.transparent,
      color: Colors.transparent,
      fillColor: Colors.transparent,
      disabledColor: Colors.transparent,
      disabledBorderColor: Colors.transparent,
      focusColor: Colors.transparent,
      highlightColor: Colors.transparent,
      renderBorder: false,
      selectedBorderColor: Colors.transparent,
      selectedColor: Colors.transparent,
      hoverColor: Colors.transparent,
      splashColor: Colors.transparent,
      direction: Axis.horizontal,
      isSelected: _selections,
      onPressed: (index) {
        setState(() {
          _selections = [false, false];
          _selections[index] = true;
        });
      },
      children: [
        _buildBottons(
          title: "Motorista",
          icon: Icons.directions_car,
          isSelected: _selections[0],
        ),
        _buildBottons(
          title: "Caroneiro",
          icon: Icons.emoji_people,
          isSelected: _selections[1],
        ),
      ],
    );
  }

  Widget _buildBottons({
    required String title,
    required IconData icon,
    required bool isSelected,
  }) {
    return Container(
      margin: const EdgeInsets.all(10),
      width: 100,
      height: 100,
      decoration: BoxDecoration(
        color: !isSelected ? Colors.white : AppConstants.primaryColor,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: isSelected ? Colors.white : AppConstants.primaryColor,
          width: 3.0,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Text(
              title,
              style: TextStyle(
                fontSize: 16,
                color: isSelected ? Colors.white : AppConstants.primaryColor,
              ),
            ),
            const SizedBox(height: 12),
            Icon(
              icon,
              size: 40,
              color: isSelected ? Colors.white : AppConstants.primaryColor,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRegisterButton() {
    bool? isDriver;
    if (_selections[0]) {
      isDriver = true;
    } else {
      isDriver = false;
    }
    return InkWell(
      onTap: () {
        final provider =
            Provider.of<GoogleSignInProvider>(context, listen: false);
        var saveUser = provider.saveUser(isDriver!);
        saveUser.whenComplete(() {
          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                builder: (context) => HomeScreen(
                  isDriver: isDriver,
                  isUser: true,
                ),
              ),
              (route) => false);
        });
      },
      child: Container(
        width: 275,
        height: 50,
        decoration: BoxDecoration(
          color: AppConstants.primaryColor,
          border: Border.all(
            color: AppConstants.primaryColor,
            width: 3.0,
          ),
          borderRadius: BorderRadius.circular(110),
        ),
        child: const Center(
          child: Text(
            "Salvar",
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ),
    );
  }
}
