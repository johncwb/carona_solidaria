import 'package:flutter/material.dart';
import '../../utils/constants.dart';

class CreateButton extends StatefulWidget {
  const CreateButton({super.key, this.onTap, this.text});
  final Function? onTap;
  final String? text;

  @override
  State<CreateButton> createState() => _CreateButtonState();
}

class _CreateButtonState extends State<CreateButton> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => widget.onTap!(),
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
        child: Center(
          child: Text(
            widget.text!,
            style: const TextStyle(
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
