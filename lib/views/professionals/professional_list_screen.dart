import 'package:bookify/core/utils/app_animations/app_animations.dart';
import 'package:bookify/core/utils/app_butons/active_button.dart';
import 'package:bookify/core/utils/app_colors/app_colors.dart';
import 'package:bookify/views/professionals/professional_card_list.dart';
import 'package:bookify/widgets/custom_error_widget/custom_message_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:bookify/view_models/professional_provider.dart';

class ProfessionalListScreen extends ConsumerWidget {
  const ProfessionalListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final professionalsAsync = ref.watch(professionalsListProvider);
    final filteredProfessionals = ref.watch(filteredProfessionalsProvider);
    //  final screensize = MediaQuery.of(context).size;

    return RefreshIndicator(
      onRefresh: () => ref.refresh(professionalsListProvider.future),
      child: professionalsAsync.when(
        loading: () => Center(
          child: CircularProgressIndicator(color: AppColors().primaryColor),
        ),
        error: (error, stack) => CustomMessageWidget(
          animation: AppAnimations.errorAnimation,
          errorMessage: 'Error loading professionals',
          retryButton: ActiveButton(
            buttonText: 'Retry',
            keyText: GlobalKey<FormState>(),
            onPressed: () => ref.refresh(professionalsListProvider),
          ),
        ),

        data: (data) {
          if (filteredProfessionals.isEmpty) {
            return CustomMessageWidget(
              animation: AppAnimations.nodataAnimation,
              errorMessage: 'No professionals found',
            );
          }

          return ProfessionalCardList(
            filteredProfessionals: filteredProfessionals,
          );
        },
      ),
    );
  }
}
