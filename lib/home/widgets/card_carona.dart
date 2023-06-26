import 'package:flutter/material.dart';

class CardCarona extends StatelessWidget {
  const CardCarona({super.key, required this.isGuest});

  final bool isGuest;

  @override
  Widget build(BuildContext context) {
    return Container(
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
    );
  }

  Widget _buildCardItens() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildName("Pedro Almeida"),
          const SizedBox(height: 10),
          _buildLocation("R. Buenos Aires, 1260 - Água Verde"),
        ],
      ),
    );
  }

  Widget _buildName(String? name) {
    return RichText(
      text: TextSpan(
        text: 'Nome: ',
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
