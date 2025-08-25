import 'package:flutter/material.dart';

Widget shimmerContainer(
  double shimmerWith,
  double shimmerHeight,
  double shimmerRadius,
  Widget? child,
  Color? containerColor,
) {
  return Container(
    width: shimmerWith,
    height: shimmerHeight,
    decoration: BoxDecoration(
      color: containerColor,
      borderRadius: BorderRadius.circular(shimmerRadius),
    ),
    child: child,
  );
}
