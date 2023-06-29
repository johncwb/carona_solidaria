import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class EditProfileButton extends StatelessWidget {
  const EditProfileButton({super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.pushNamed(context, '/register');
      },
      child: Container(
        width: 200,
        decoration: BoxDecoration(
          color: const Color(0xff113d63),
          border: Border.all(
            width: 3,
            color: const Color(0xff113d63),
          ),
          borderRadius: const BorderRadius.all(
            Radius.circular(20.0),
          ),
        ),
        // color: const Color(0xff113d63),
        height: 30,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text(
              'Editar Perfil',
              style: GoogleFonts.anton(
                color: Colors.white,
                fontSize: 16,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
