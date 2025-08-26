import 'package:bookify/core/utils/app_animations/app_animations.dart';
import 'package:bookify/core/utils/app_butons/active_button.dart';
import 'package:bookify/core/utils/app_colors/app_colors.dart';
import 'package:bookify/core/utils/app_font_size/app_font_size.dart';
import 'package:bookify/view_models/global_provider.dart';
import 'package:bookify/views/professionals/professional_detiails/professional_detials_screen.dart';
import 'package:bookify/widgets/card_list/card_list_widget.dart';
import 'package:bookify/widgets/custom_message_widget/custom_message_widget.dart';
import 'package:bookify/widgets/profession_container_widget.dart';
import 'package:bookify/widgets/shimer_loadings/shimmer_card_widget.dart';
import 'package:bookify/widgets/shimer_loadings/shimmer_professional_loading.dart';
import 'package:cached_network_image/cached_network_image.dart';
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
        loading: () => Center(child: shimmerprrofessionalLoading()),
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
          return ListView.separated(
            padding: EdgeInsets.all(5),
            shrinkWrap: true,
            itemCount: filteredProfessionals.length,
            itemBuilder: (context, index) {
              final professional = filteredProfessionals[index];

              return GestureDetector(
                onTap: () {
                  ref.read(selectedProfessionalProvider.notifier).state = index;
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          ProfessionalDetialsScreen(selectedIndex: index),
                    ),
                  );
                },
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Stack(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: CachedNetworkImage(
                            imageUrl: professional.profileImageUrl,
                            width: 150,
                            height: 150,
                            fit: BoxFit.cover,
                            placeholder: (context, url) => shimmerContainer(
                              150,
                              150,
                              AppFontSize.fontSize8,
                              null,
                              AppColors().shimmerContainerColor,
                            ),
                            errorWidget: (context, url, error) =>
                                Icon(Icons.error),
                          ),
                        ),
                        Positioned(
                          bottom: 0,
                          child: Padding(
                            padding: const EdgeInsets.all(2.0),
                            child: ProfessionContainerWidget(
                              text: professional.category,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(width: AppFontSize.fontSize8),
                    Expanded(
                      child: CardListWidget(
                        professionalName: professional.name,
                        price:
                            "\$ ${professional.services[0].price.toStringAsFixed(2)}",
                        professionalBio: professional.bio,
                        travelMode: professional.canTravel,
                      ),
                    ),
                  ],
                ),
              );
            },
            separatorBuilder: (context, index) => SizedBox(height: 10),
          );
        },
      ),
    );
  }
}
