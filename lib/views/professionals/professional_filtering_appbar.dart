import 'package:bookify/core/theme/theme_config.dart';
import 'package:bookify/core/utils/app_colors/app_colors.dart';
import 'package:flutter/material.dart';

class ProfessionalFilteringAppbar extends StatefulWidget {
  const ProfessionalFilteringAppbar({super.key});

  @override
  State<ProfessionalFilteringAppbar> createState() =>
      _ProfessionalFilteringAppbarState();
}

class _ProfessionalFilteringAppbarState
    extends State<ProfessionalFilteringAppbar> {
  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return Container(
      width: screenSize.width,
      height: 150,
      color: AppColors().primaryColor,
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: 10,
          children: [
            Text('Welcome Edward', style: theme().textTheme.displayMedium),
            SizedBox(
              height: 44,
              child: TextFormField(
                decoration: InputDecoration(
                  filled: true,
                  fillColor: AppColors().whiteColor,
                  prefixIcon: Icon(
                    Icons.search,
                    color: AppColors().primaryColor,
                  ),
                  hintText: 'Search for professionals',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(35),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
