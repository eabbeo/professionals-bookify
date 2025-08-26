import 'package:bookify/core/theme/theme_config.dart';
import 'package:bookify/core/utils/app_colors/app_colors.dart';
import 'package:bookify/core/utils/app_font_size/app_font_size.dart';
import 'package:bookify/core/utils/app_images/app_images.dart';
import 'package:bookify/core/utils/app_sizebox/app_sizebox.dart';
import 'package:bookify/core/utils/app_string_constants/app_string_constant.dart';
import 'package:bookify/view_models/global_provider.dart';
import 'package:bookify/view_models/professional_provider.dart';
import 'package:bookify/views/bookings/books_screen.dart';
import 'package:bookify/widgets/profession_container_widget.dart';
import 'package:bookify/widgets/shimer_loadings/shimmer_card_widget.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';

class ProfessionalDetialsScreen extends ConsumerStatefulWidget {
  const ProfessionalDetialsScreen({super.key, required this.selectedIndex});
  final int selectedIndex;

  @override
  ConsumerState<ProfessionalDetialsScreen> createState() =>
      _ProfessionalDetialsScreenState();
}

class _ProfessionalDetialsScreenState
    extends ConsumerState<ProfessionalDetialsScreen> {
  int? selectedService;

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final professionalData = ref.watch(filteredProfessionalsProvider);

    Future<dynamic> timeSlotModal(context) async {
      return showModalBottomSheet(
        backgroundColor: AppColors().dropBackFilterColor.withValues(alpha: 0.9),
        barrierColor: AppColors().dropBackFilterColor.withValues(alpha: 0.9),
        isScrollControlled: true,
        isDismissible: true,
        context: context,
        builder: (BuildContext context) {
          return const BooksScreen();
        },
      );
    }

    return Placeholder(
      child: Scaffold(
        body: SafeArea(
          child: Column(
            spacing: 10,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                children: [
                  ClipRRect(
                    child: CachedNetworkImage(
                      imageUrl: professionalData[widget.selectedIndex]
                          .profileImageUrl,
                      width: double.infinity,
                      height: 250,
                      fit: BoxFit.cover,
                      placeholder: (context, url) => shimmerContainer(
                        double.infinity,
                        150,
                        AppFontSize.fontSize8,
                        null,
                        AppColors().shimmerContainerColor,
                      ),
                      errorWidget: (context, url, error) => Icon(Icons.error),
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: 250,
                    color: AppColors().blackColor.withValues(alpha: 0.2),
                  ),
                  Positioned(
                    top: 90,
                    left: 140,

                    child: Column(
                      spacing: 5,
                      children: [
                        Text(
                          professionalData[widget.selectedIndex].name,
                          style: theme().textTheme.displayMedium,
                        ),
                        ProfessionContainerWidget(
                          text: professionalData[widget.selectedIndex].category,
                        ),
                      ],
                    ),
                  ),
                  Positioned(
                    child: GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: Padding(
                        padding: const EdgeInsets.all(15),
                        child: CircleAvatar(
                          backgroundColor: AppColors().whiteColor,
                          child: Icon(Icons.arrow_back),
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 20,
                    child: SizedBox(
                      width: screenSize.width,
                      child: Text(
                        professionalData[widget.selectedIndex].bio,
                        textAlign: TextAlign.center,
                        style: theme().textTheme.labelSmall,
                      ),
                    ),
                  ),
                ],
              ),

              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'See all services',
                      style: theme().textTheme.displaySmall,
                    ),
                    Row(
                      children: [
                        SvgPicture.asset(
                          professionalData[widget.selectedIndex].canTravel ==
                                  AppStringConstant.canTravel
                              ? AppImages.busImage
                              : AppImages.cancelImage,
                          width: 15,
                          height: 15,
                        ),
                        AppSizebox().sizedBoxWidth4,
                        professionalData[widget.selectedIndex].canTravel ==
                                AppStringConstant.canTravel
                            ? Text('Can travel')
                            : Text(
                                'Can not travel',
                                style: TextStyle(color: AppColors().redColor),
                              ),
                      ],
                    ),
                  ],
                ),
              ),
              Expanded(
                child: ListView.separated(
                  itemCount:
                      professionalData[widget.selectedIndex].services.length,
                  itemBuilder: (context, index) {
                    final detials =
                        professionalData[widget.selectedIndex].services[index];
                    return Padding(
                      padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                      child: Container(
                        width: screenSize.width,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(
                            AppFontSize.fontSize8,
                          ),
                          border: Border.all(
                            width: 1,
                            color: selectedService == index
                                ? AppColors().primaryColor
                                : AppColors().greyColor.withValues(alpha: 0.5),
                          ),
                        ),
                        child: ListTile(
                          title: Text(detials.name),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            spacing: 5,
                            children: [
                              AppSizebox().sizedBoxHeight4,
                              ProfessionContainerWidget(
                                text: '${detials.duration} minutes',
                              ),
                              Row(
                                children: [
                                  TextButton(
                                    onPressed: () {
                                      setState(() {
                                        selectedService = index;
                                      });
                                      ref
                                              .read(
                                                selectedSeriveceProvider
                                                    .notifier,
                                              )
                                              .state =
                                          selectedService!;

                                      timeSlotModal(context);
                                    },
                                    child: Text('Select Time'),
                                  ),
                                  Icon(Icons.keyboard_arrow_right),
                                ],
                              ),
                            ],
                          ),
                          trailing: Text(
                            "\$ ${detials.price.toStringAsFixed(2)}",
                            style: theme().textTheme.displaySmall,
                          ),
                          onTap: () {
                            setState(() {
                              selectedService = index;
                            });
                            ref.read(selectedSeriveceProvider.notifier).state =
                                selectedService!;

                            timeSlotModal(context);
                          },
                        ),
                      ),
                    );
                  },
                  separatorBuilder: (context, index) =>
                      AppSizebox().sizedBoxHeight8,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
