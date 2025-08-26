import 'package:bookify/core/theme/theme_config.dart';
import 'package:bookify/core/utils/app_butons/active_button.dart';
import 'package:bookify/core/utils/app_colors/app_colors.dart';
import 'package:bookify/core/utils/app_font_size/app_font_size.dart';
import 'package:bookify/core/utils/app_sizebox/app_sizebox.dart';
import 'package:bookify/view_models/global_provider.dart';
import 'package:bookify/view_models/professional_provider.dart';
import 'package:bookify/views/professionals/professionals_screen.dart';
import 'package:bookify/widgets/custom_toast/custom_toast.dart';
import 'package:bookify/widgets/profession_container_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class BookingConfirmationScreen extends ConsumerStatefulWidget {
  const BookingConfirmationScreen({super.key});

  @override
  ConsumerState<BookingConfirmationScreen> createState() =>
      _BookingConfirmationScreenState();
}

class _BookingConfirmationScreenState
    extends ConsumerState<BookingConfirmationScreen> {
  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final selectedProffessionalIndex = ref.watch(selectedProfessionalProvider);
    final filteredProfessionals = ref.watch(filteredProfessionalsProvider);

    final professional = filteredProfessionals[selectedProffessionalIndex];
    final serviceInex = ref.watch(selectedSeriveceProvider);
    return Scaffold(
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(AppFontSize.fontSize14),
        child: ActiveButton(
          buttonText: 'Submit Booking',
          keyText: null,
          onPressed: () {
            appToast(
              context,
              'Booking Successful',
              'Your service hads been booked successfully',
              AppColors().greenColor,
              Icons.check,
            );
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => ProfessionalsScreen()),
            );
          },
        ),
      ),
      body: Column(
        spacing: AppFontSize.fontSize14,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomAppBar(screenSize: screenSize),
          Padding(
            padding: const EdgeInsets.only(left: AppFontSize.fontSize14),
            child: Labels(text: 'Service Booked'),
          ),
          Padding(
            padding: const EdgeInsets.only(
              left: AppFontSize.fontSize14,
              right: AppFontSize.fontSize14,
            ),
            child: Container(
              width: screenSize.width,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(AppFontSize.fontSize8),
                border: Border.all(width: 1, color: AppColors().primaryColor),
              ),
              child: ListTile(
                title: Text(professional.services[serviceInex].name),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: 5,
                  children: [
                    AppSizebox().sizedBoxHeight4,
                    ProfessionContainerWidget(
                      text:
                          '${professional.services[serviceInex].duration} minutes',
                    ),
                  ],
                ),
                trailing: Text(
                  "\$ ${professional.services[serviceInex].price.toStringAsFixed(2)}",
                  style: theme().textTheme.displaySmall,
                ),
              ),
            ),
          ),
          AppSizebox().sizedBoxHeight4,
          Padding(
            padding: const EdgeInsets.only(left: AppFontSize.fontSize14),
            child: Labels(text: 'To be serviced by'),
          ),
          ListTile(
            leading: ClipRRect(
              borderRadius: BorderRadiusGeometry.circular(
                AppFontSize.fontSize20,
              ),
              child: CircleAvatar(
                radius: 25,
                backgroundImage: NetworkImage(professional.profileImageUrl),
              ),
            ),
            title: Text(
              professional.name,
              style: theme().textTheme.displaySmall,
            ),
            subtitle: Text(professional.category),
          ),
          Padding(
            padding: const EdgeInsets.only(
              left: AppFontSize.fontSize14,
              right: AppFontSize.fontSize14,
            ),
            child: Row(
              children: [
                Text('Total', style: theme().textTheme.displaySmall),
                Spacer(),
                Text(
                  "\$ ${professional.services[serviceInex].price.toStringAsFixed(2)}",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 25,
                    color: AppColors().primaryColor,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class Labels extends StatelessWidget {
  const Labels({super.key, required this.text});
  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(text, style: theme().textTheme.displaySmall);
  }
}

class CustomAppBar extends StatelessWidget {
  const CustomAppBar({super.key, required this.screenSize});

  final Size screenSize;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: screenSize.width,
      color: AppColors().primaryColor,
      child: Padding(
        padding: const EdgeInsets.only(left: 5, top: 20),
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.center,
          // crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AppSizebox().sizedBoxHeight8,
            Row(
              children: [
                GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: Padding(
                    padding: const EdgeInsets.all(15),
                    child: CircleAvatar(
                      backgroundColor: AppColors().whiteColor,
                      child: Icon(Icons.arrow_back),
                    ),
                  ),
                ),
                Text('Summary', style: theme().textTheme.displayMedium),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
