import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';

class ButtonWidgets extends StatelessWidget {
  const ButtonWidgets({
    super.key,
    required this.text,
    required this.function,
  });

  final String text;
  final Function function;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => function(),
      child: Padding(
        padding: const EdgeInsets.all(0.0),
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
          height: 55,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(
                text,
                style: GoogleFonts.anton(
                  color: Colors.white,
                  fontSize: 20,
                ),
              ),
              const FaIcon(
                FontAwesomeIcons.google,
                color: Colors.white,
              )
            ],
          ),
        ),
      ),
    );
  }
}
