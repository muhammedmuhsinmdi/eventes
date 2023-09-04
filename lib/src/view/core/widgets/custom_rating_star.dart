import 'package:evantez/src/view/core//constants/app_images.dart';
import 'package:evantez/src/view/core//themes/typography.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_svg/svg.dart';

import '../themes/colors.dart';

class CustomRatingStar extends StatefulWidget {
  final double? height;
  final double? padding;
  final bool? ignoreGestures;
  final double? initialRating;
  final Function(double) onRating;
  final bool? hideValue;
  const CustomRatingStar(
      {super.key,
      this.height,
      this.padding,
      this.ignoreGestures = false,
      this.initialRating,
      required this.onRating,
      this.hideValue});

  @override
  State<CustomRatingStar> createState() => _CustomRatingStarState();
}

class _CustomRatingStarState extends State<CustomRatingStar> {
  final ValueNotifier<double> rating = ValueNotifier<double>(0);

  @override
  void initState() {
    if (widget.initialRating != null) {
      rating.value = widget.initialRating!;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final kSize = MediaQuery.of(context).size;
    return ValueListenableBuilder(
        valueListenable: rating,
        builder: (context, value, child) {
          return Row(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              RatingBar(
                direction: Axis.horizontal,
                minRating: 1,
                onRatingUpdate: (value) {
                  rating.value = value;
                  widget.onRating(rating.value);
                },
                tapOnlyMode: true,
                ratingWidget: RatingWidget(
                  full: SvgPicture.asset(
                    AppImages.starFill,
                    colorFilter: const ColorFilter.mode(AppColors.primaryColor, BlendMode.srcIn),
                  ),
                  half: SvgPicture.asset(
                    AppImages.star,
                    colorFilter: const ColorFilter.mode(AppColors.primaryColor, BlendMode.srcIn),
                  ),
                  empty: SvgPicture.asset(
                    AppImages.star,
                    colorFilter: const ColorFilter.mode(AppColors.primaryColor, BlendMode.srcIn),
                  ),
                ),
                itemSize: widget.height ?? kSize.height * 0.016,
                itemCount: 5,
                initialRating: widget.initialRating ?? 0,
                itemPadding: EdgeInsets.only(right: widget.padding ?? kSize.width * 0.005),
                updateOnDrag: true,
                allowHalfRating: false,
                ignoreGestures: widget.ignoreGestures ?? true,
              ),
              if (widget.hideValue != null && !widget.hideValue!)
                Text(
                  "${rating.value}",
                  textAlign: TextAlign.center,
                  style: AppTypography.poppinsMedium.copyWith(
                    fontSize: 14,
                    color: AppColors.secondaryColor.withOpacity(0.4),
                  ),
                )
            ],
          );
        });
  }
}
