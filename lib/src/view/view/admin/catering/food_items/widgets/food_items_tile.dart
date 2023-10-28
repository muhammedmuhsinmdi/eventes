import 'dart:developer';

import 'package:evantez/app/router/router_constant.dart';
import 'package:evantez/src/model/repository/catering/food_items_repository.dart';
import 'package:evantez/src/serializer/models/food_items_list_response.dart';
import 'package:evantez/src/view/core//constants/constants.dart';
import 'package:evantez/src/view/core//themes/colors.dart';
import 'package:evantez/src/view/core//themes/typography.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FoodItemTile extends StatelessWidget {
  final FoodItemListResponse item;
  final int index;
  const FoodItemTile({super.key, required this.item, required this.index});
  @override
  Widget build(BuildContext context) {
    final kSize = MediaQuery.of(context).size;
    final controller = context.watch<FoodItemsController>();
    return Container(
      width: kSize.width,
      margin: EdgeInsets.only(bottom: kSize.height * 0.012),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(AppConstants.basePadding),
        color: AppColors.accentDark,
      ),
      padding: EdgeInsets.symmetric(
        horizontal: kSize.height * 0.016,
        vertical: kSize.height * 0.016,
      ),
      child: Row(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                getFoodItemType(controller: controller),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: AppTypography.poppinsSemiBold.copyWith(
                  fontSize: 14,
                  color: AppColors.secondaryColor,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                    vertical: AppConstants.baseTextFieldBorderRdious),
                child: Text(
                  item.name!,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: AppTypography.poppinsSemiBold.copyWith(
                    fontSize: 18,
                    color: AppColors.secondaryColor,
                  ),
                ),
              ),
              RichText(
                text: TextSpan(
                    text: 'Rate ',
                    style: AppTypography.poppinsMedium.copyWith(
                        fontSize: 14,
                        color: AppColors.secondaryColor.withOpacity(0.5)),
                    children: [
                      TextSpan(
                          text: item.rate,
                          style: AppTypography.poppinsMedium.copyWith(
                            fontSize: 14,
                            color: AppColors.secondaryColor,
                          ))
                    ]),
              )
            ],
          ),
          const Spacer(),
          SizedBox(
            width: kSize.width * 0.1,
            child: PopupMenuButton<String>(
              initialValue: 'Edit',
              // Callback that sets the selected popup menu item.
              onSelected: (item) {
                controller.initStateLoading(
                    data: controller.foodItemsList[index], index: index);
                Navigator.pushNamed(context, RouterConstants.addFoodItemRoute,
                    arguments: index);
              },
              clipBehavior: Clip.antiAlias,
              padding: EdgeInsets.symmetric(horizontal: kSize.height * 0.024),
              shape: RoundedRectangleBorder(
                  side: const BorderSide(
                    color: AppColors.accentColor,
                  ),
                  borderRadius: BorderRadius.circular(
                    AppConstants.basePadding,
                  )),

              itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
                PopupMenuItem<String>(
                  padding: EdgeInsets.symmetric(
                    horizontal: kSize.width * 0.05,
                  ),
                  value: "edit",
                  child: Text(
                    'Edit',
                    textAlign: TextAlign.start,
                    style: AppTypography.poppinsMedium.copyWith(),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  String getFoodItemType({required FoodItemsController controller}) {
    return controller.foodItemTypes
        .where((e) => e.id == item.foodItemType)
        .first
        .name;
  }
}
