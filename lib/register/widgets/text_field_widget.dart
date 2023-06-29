import 'package:carona_solidaria/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomTextFormField extends StatefulWidget {
  const CustomTextFormField({
    super.key,
    required this.label,
    required this.hint,
    required this.textInputType,
    required this.controller,
    required this.textInputFormatter,
  });
  final String label;
  final String hint;
  final TextInputType textInputType;
  final TextEditingController controller;
  final TextInputFormatter textInputFormatter;

  @override
  State<CustomTextFormField> createState() => _CustomTextFormFieldState();
}

class _CustomTextFormFieldState extends State<CustomTextFormField> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      autofocus: false,
      obscureText: false,
      keyboardType: widget.textInputType,
      inputFormatters: [
        widget.textInputFormatter,
      ],
      decoration: InputDecoration(
        label: Text(widget.label),
        hintText: widget.hint,
        fillColor: AppConstants.primaryColor,
        focusColor: AppConstants.primaryColor,
        border: const OutlineInputBorder(),
      ),
    );
  }
}
