import 'package:bookify/core/theme/theme_config.dart';
import 'package:bookify/core/utils/app_animations/app_animations.dart';
import 'package:bookify/core/utils/app_butons/active_button.dart';
import 'package:bookify/core/utils/app_colors/app_colors.dart';
import 'package:bookify/core/utils/app_font_size/app_font_size.dart';
import 'package:bookify/core/utils/app_images/app_images.dart';
import 'package:bookify/core/utils/app_sizebox/app_sizebox.dart';
import 'package:bookify/core/utils/app_string_constants/app_string_constant.dart';
import 'package:bookify/widgets/custom_message_widget/custom_message_widget.dart';
import 'package:bookify/widgets/shimer_loadings/shimmer_card_widget.dart';
import 'package:bookify/widgets/shimer_loadings/shimmer_professional_loading.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:bookify/view_models/professional_provider.dart';
import 'package:flutter_svg/svg.dart';

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

              return Row(
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
                          child: Container(
                            decoration: BoxDecoration(
                              color: AppColors().primaryColor,
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 8,
                                vertical: 4,
                              ),
                              child: Text(
                                professional.category,
                                style: theme().textTheme.labelSmall,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(width: AppFontSize.fontSize8),
                  Expanded(
                    // 👈 wrap Column in Expanded
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      spacing: 5,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              professional.name,
                              style: theme().textTheme.displaySmall,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            Text(
                              "\$ ${professional.services[0].price.toStringAsFixed(2)}",
                              style: theme().textTheme.displaySmall,
                            ),
                          ],
                        ),
                        Text(
                          professional.bio,
                          style: theme().textTheme.bodySmall,
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                        ),
                        Row(
                          // mainAxisAlignment: MainAxisAlignment.,
                          children: [
                            SvgPicture.asset(
                              professional.canTravel ==
                                      AppStringConstant.canTravel
                                  ? AppImages.busImage
                                  : AppImages.cancelImage,
                              width: 15,
                              height: 15,
                            ),
                            AppSizebox().sizedBoxWidth4,
                            professional.canTravel ==
                                    AppStringConstant.canTravel
                                ? Text('Can travel')
                                : Text('Can not travel'),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              );
            },
            separatorBuilder: (context, index) => SizedBox(height: 10),
          );
        },
      ),
    );
  }
}
