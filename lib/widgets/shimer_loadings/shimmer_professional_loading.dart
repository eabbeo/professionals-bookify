import 'package:bookify/core/utils/app_colors/app_colors.dart';
import 'package:bookify/core/utils/app_font_size/app_font_size.dart';
import 'package:bookify/widgets/shimer_loadings/shimmer_card_widget.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

Widget shimmerprrofessionalLoading() {
  List<Widget> loadingProfessionals = List.generate(5, (index) {
    return SingleChildScrollView(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: shimmerContainer(
              150,
              150,
              AppFontSize.fontSize8,
              null,
              AppColors().shimmerContainerColor,
            ),
          ),

          SizedBox(width: AppFontSize.fontSize8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: 5,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    shimmerContainer(
                      70,
                      20,
                      AppFontSize.fontSize8,
                      null,
                      AppColors().shimmerContainerColor,
                    ),
                    shimmerContainer(
                      70,
                      20,
                      AppFontSize.fontSize8,
                      null,
                      AppColors().shimmerContainerColor,
                    ),
                  ],
                ),
                shimmerContainer(
                  double.infinity,
                  70,
                  AppFontSize.fontSize8,
                  null,
                  AppColors().shimmerContainerColor,
                ),
                Row(
                  // mainAxisAlignment: MainAxisAlignment.,
                  children: [
                    shimmerContainer(
                      20,
                      20,
                      AppFontSize.fontSize8,
                      null,
                      AppColors().shimmerContainerColor,
                    ),

                    shimmerContainer(
                      50,
                      20,
                      AppFontSize.fontSize8,
                      null,
                      AppColors().shimmerContainerColor,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  });

  return Shimmer.fromColors(
    baseColor: Colors.grey[300]!,
    highlightColor: Colors.grey[100]!,
    child: Column(children: [...loadingProfessionals]),
  );
}
