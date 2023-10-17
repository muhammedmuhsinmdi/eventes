import 'package:flutter/material.dart';

import '../../../../../../core/constants/app_images.dart';
import '../../../../../../core/themes/colors.dart';
import '../../../../../../core/themes/typography.dart';
import 'employee_filter.dart';

class SelectionRating extends StatefulWidget {
  final Function(List<String>) onSelectRating;
  const SelectionRating({super.key, required this.onSelectRating});

  @override
  State<SelectionRating> createState() => _SelectionRatingState();
}

class _SelectionRatingState extends State<SelectionRating> {
  List<FilterModel> ratingItems = [
    FilterModel(label: "5", svg: AppImages.starFill),
    FilterModel(label: "4 - 4.99", svg: AppImages.starFill),
    FilterModel(label: "3 - 3.99", svg: AppImages.starFill),
    FilterModel(label: "2 - 2.99", svg: AppImages.starFill),
    FilterModel(label: "1 - 1.99", svg: AppImages.starFill),
    FilterModel(label: "0 - 0.99", svg: AppImages.starFill),
  ];

  List<String> selectedRating = [];

  @override
  Widget build(BuildContext context) {
    final kSize = MediaQuery.of(context).size;
    return Wrap(
      clipBehavior: Clip.antiAlias,
      spacing: 8,
      runSpacing: 8,
      children: List.generate(
          ratingItems.length,
          (index) => InkWell(
              highlightColor: AppColors.transparent,
              splashColor: AppColors.transparent,
              onTap: () {
                if (selectedRating.contains(ratingItems[index].label)) {
                  selectedRating.remove(ratingItems[index].label);
                } else {
                  selectedRating.add(ratingItems[index].label!);
                }
                setState(() {});
                widget.onSelectRating(selectedRating);
              },
              child: ratingWidget(kSize, ratingItems[index]))),
    );
  }

  Widget ratingWidget(Size kSize, FilterModel filter) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: selectedRating.contains(filter.label) ? AppColors.primaryColor : AppColors.transparent,
          border: Border.all(
            color: AppColors.primaryColor,
          )),
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (filter.label != null)
            Text(
              filter.label!,
              style: AppTypography.poppinsRegular.copyWith(color: AppColors.secondaryColor, fontSize: 12),
            ),
          if (filter.svg != null)
            Padding(
              padding: filter.svg == AppImages.star ? const EdgeInsets.only(right: 12) : EdgeInsets.zero,
              child: Icon(
                Icons.star,
                size: kSize.height * 0.016,
              ),
            ),
        ],
      ),
    );
  }
}
