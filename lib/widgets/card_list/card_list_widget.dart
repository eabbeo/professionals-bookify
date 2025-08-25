import 'package:bookify/core/theme/theme_config.dart';
import 'package:bookify/core/utils/app_images/app_images.dart';
import 'package:bookify/core/utils/app_sizebox/app_sizebox.dart';
import 'package:bookify/core/utils/app_string_constants/app_string_constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class CardListWidget extends StatelessWidget {
  const CardListWidget({
    super.key,
    required this.professionalName,
    required this.price,
    required this.professionalBio,
    required this.travelMode,
  });
  final String professionalName;
  final String price;
  final String professionalBio;
  final String travelMode;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 5,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              professionalName,
              style: theme().textTheme.displaySmall,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            Text(price, style: theme().textTheme.displaySmall),
          ],
        ),
        Text(
          professionalBio,
          style: theme().textTheme.bodySmall,
          maxLines: 3,
          overflow: TextOverflow.ellipsis,
        ),
        Row(
          children: [
            SvgPicture.asset(
              travelMode == AppStringConstant.canTravel
                  ? AppImages.busImage
                  : AppImages.cancelImage,
              width: 15,
              height: 15,
            ),
            AppSizebox().sizedBoxWidth4,
            travelMode == AppStringConstant.canTravel
                ? Text('Can travel')
                : Text('Can not travel'),
          ],
        ),
      ],
    );
  }
}
