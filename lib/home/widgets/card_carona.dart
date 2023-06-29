import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

class CardCarona extends StatelessWidget {
  const CardCarona({
    super.key,
    required this.isGuest,
    required this.name,
    required this.destiny,
    required this.meeting,
    required this.whatsapp,
  });
  final String name;
  final String destiny;
  final String meeting;
  final String whatsapp;

  final bool isGuest;

  void openWhatsApp(String phoneNumber) async {
    String url = 'https://wa.me/+55$phoneNumber';
    Uri uri = Uri.parse(url);
    await _launchInBrowser(uri);
  }

  Future<void> _launchInBrowser(Uri url) async {
    if (!await launchUrl(
      url,
      mode: LaunchMode.externalApplication,
    )) {
      throw Exception('Could not launch $url');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 12),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 1.2,
              blurRadius: 1.2,
              offset: const Offset(2, 5),
            ),
          ],
        ),
        child: _buildCardItens(),
      ),
    );
  }

  Widget _buildCardItens() {
    return InkWell(
      onTap: () => openWhatsApp(whatsapp),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildName(name),
            const SizedBox(height: 10),
            _buildStarsRate(),
            const SizedBox(height: 10),
            _buildLocation(destiny),
            const SizedBox(height: 10),
            _buildWhatsApp(whatsapp),
          ],
        ),
      ),
    );
  }

  Widget _buildStarsRate() {
    return Row(
      children: const [
        Text(
          "Avaliação: ",
          style: TextStyle(
            color: Colors.black,
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        ),
        Icon(Icons.star_rate),
        Icon(Icons.star_rate),
        Icon(Icons.star_rate),
        Icon(Icons.star_rate),
        Icon(Icons.star_rate),
      ],
    );
  }

  Widget _buildWhatsApp(String number) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        RichText(
          text: TextSpan(
            text: 'WhatsAPP: ',
            style: const TextStyle(
              color: Colors.black,
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
            children: [
              TextSpan(
                text: number,
                style: const TextStyle(
                  fontWeight: FontWeight.w400,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(width: 10),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 8),
          child: FaIcon(
            FontAwesomeIcons.whatsapp,
            // color: Colors.white,
          ),
        ),
      ],
    );
  }

  Widget _buildName([String? name]) {
    return RichText(
      text: TextSpan(
        text: 'Passageiro: ',
        style: const TextStyle(
          color: Colors.black,
          fontSize: 16,
          fontWeight: FontWeight.w500,
        ),
        children: [
          TextSpan(
            text: name,
            style: const TextStyle(
              fontWeight: FontWeight.w400,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLocation(String? location) {
    return RichText(
      text: TextSpan(
        text: 'Destino: ',
        style: const TextStyle(
          color: Colors.black,
          fontSize: 16,
          fontWeight: FontWeight.w500,
        ),
        children: [
          TextSpan(
            text: location,
            style: const TextStyle(
              fontWeight: FontWeight.w400,
            ),
          ),
        ],
      ),
    );
  }
}
