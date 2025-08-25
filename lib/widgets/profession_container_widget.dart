import 'package:bookify/core/theme/theme_config.dart';
import 'package:bookify/core/utils/app_colors/app_colors.dart';
import 'package:flutter/material.dart';

class ProfessionContainerWidget extends StatelessWidget {
  const ProfessionContainerWidget({super.key, required this.text});
  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors().primaryColor,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        child: Text(text, style: theme().textTheme.labelSmall),
      ),
    );
  }
}
