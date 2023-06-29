import 'package:flutter/material.dart';

class TitleField extends StatefulWidget {
  const TitleField({super.key, required this.title});
  final String title;

  @override
  State<TitleField> createState() => _TitleFieldState();
}

class _TitleFieldState extends State<TitleField> {
  @override
  Widget build(BuildContext context) {
    return Text(widget.title);
  }
}
