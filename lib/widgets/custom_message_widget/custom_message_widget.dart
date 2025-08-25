import 'package:bookify/core/utils/app_colors/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';

class CustomMessageWidget extends StatefulWidget {
  const CustomMessageWidget({
    super.key,
    required this.errorMessage,
    this.retryButton,
    required this.animation,
  });
  final String errorMessage;
  final Widget? retryButton;
  final String animation;
  @override
  State<CustomMessageWidget> createState() => _CustomMessageWidgetState();
}

class _CustomMessageWidgetState extends State<CustomMessageWidget> {
  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return Container(
      width: screenSize.width,
      height: screenSize.height,
      color: AppColors().whiteColor,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        spacing: 10,
        children: [
          LottieBuilder.asset(
            widget.animation,
            width: screenSize.width * 0.4,
            height: screenSize.width * 0.4,
            fit: BoxFit.cover,
          ),
          Center(
            child: Text(
              widget.errorMessage,
              style: TextStyle(
                color: AppColors().blackColor,
                fontSize: 18,
                fontFamily: GoogleFonts.lato().fontFamily,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          if (widget.retryButton != null) widget.retryButton!,
        ],
      ),
    );
  }
}
