import 'package:flutter/material.dart';

class TextFormWidget extends StatefulWidget {
  const TextFormWidget({
    super.key,
    required this.label,
    required this.hint,
    required this.controller,
    required this.keyboardType,
    required this.validator,
  });

  final String label;
  final String hint;
  final TextEditingController controller;
  final TextInputType keyboardType;
  final Function(String) validator;
  final bool isPassword = false;

  @override
  State<TextFormWidget> createState() => _TextFormWidgetState();
}

class _TextFormWidgetState extends State<TextFormWidget> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24),
      child: TextFormField(
        controller: widget.controller,
        obscureText: widget.isPassword,
        decoration: InputDecoration(
          border: const OutlineInputBorder(),
          label: Text(widget.label),
          hintText: widget.hint,
        ),
        keyboardType: widget.keyboardType,
        validator: (value) => widget.validator(value!),
      ),
    );
  }
}
