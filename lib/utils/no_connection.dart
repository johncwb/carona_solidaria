import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class NoConnection extends StatelessWidget {
  const NoConnection({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        backgroundColor: const Color(0xff113d63),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          // crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Icon(
              Icons.signal_wifi_off_rounded,
              size: 87,
              color: Color(0xff113d63),
            ),
            const SizedBox(height: 25),
            Text(
              "Sem conexão\nPor favor verifique sua conexão",
              textAlign: TextAlign.center,
              style: GoogleFonts.anton(
                color: Colors.black,
                fontWeight: FontWeight.w200,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
