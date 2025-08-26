import 'package:bookify/views/professionals/professional_filtering_appbar.dart';
import 'package:bookify/views/professionals/professional_list_screen.dart';

import 'package:flutter/material.dart';

class ProfessionalsScreen extends StatelessWidget {
  const ProfessionalsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: Scaffold(
        body: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ProfessionalFilteringAppbar(),
              Expanded(child: ProfessionalListScreen()),
            ],
          ),
        ),
      ),
    );
  }
}
