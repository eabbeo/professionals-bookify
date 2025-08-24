import 'package:bookify/core/utils/app_colors/app_colors.dart';
import 'package:bookify/core/utils/app_font_size/app_font_size.dart';
import 'package:flutter/material.dart';

class ActiveButton extends StatefulWidget {
  const ActiveButton({
    super.key,
    required this.buttonText,
    required this.keyText,

    required this.onPressed,
  });
  final GlobalKey<FormState>? keyText;
  final String buttonText;

  final Function() onPressed;

  @override
  State<ActiveButton> createState() => _ActiveButtonState();
}

class _ActiveButtonState extends State<ActiveButton> {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: widget.onPressed,
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.all(AppFontSize.fontSize8),
        backgroundColor: AppColors().primaryColor,
       
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
      ),
      child: Text(
        widget.buttonText,
        style: TextStyle(
          color: AppColors().whiteColor,
        ), //style: theme().textTheme.headlineMedium
      ),
    );
  }
}
