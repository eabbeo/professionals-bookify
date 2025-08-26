// ignore_for_file: strict_top_level_inference

import 'package:bookify/core/utils/app_colors/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:toastification/toastification.dart';

ToastificationItem appToast(
  context,
  String title,
  String message,
  HexColor color,
  IconData icons,
) {
  return toastification.show(
    context: context, // optional if you use ToastificationWrapper
    type: ToastificationType.success,
    style: ToastificationStyle.flatColored,
    autoCloseDuration: const Duration(seconds: 5),
    title: Text(
      title,
      style: TextStyle(color: AppColors().blackColor),
      // style: normalBoldTextStyle(Colors.black
      // )
    ),
    // you can also use RichText widget for title and description parameters
    description: RichText(
      text: TextSpan(
        text: message,
        style: TextStyle(color: AppColors().blackColor),
      ),
    ),
    alignment: Alignment.topRight,
    direction: TextDirection.ltr,
    animationDuration: const Duration(milliseconds: 300),
    animationBuilder: (context, animation, alignment, child) {
      return FadeTransition(opacity: animation, child: child);
    },
    icon: Icon(icons),
    showIcon: true, // show or hide the icon
    primaryColor: color,
    backgroundColor: AppColors().whiteColor,
    foregroundColor: AppColors().blackColor,
    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
    margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
    borderRadius: BorderRadius.circular(12),
    boxShadow: const [
      BoxShadow(
        color: Color(0x07000000),
        blurRadius: 16,
        offset: Offset(0, 16),
        spreadRadius: 0,
      ),
    ],
    showProgressBar: false,
    //closeButton: CloseButtonShowType.onHover,
    closeOnClick: false,
    pauseOnHover: true,
    dragToClose: true,
    applyBlurEffect: true,
  );
}
