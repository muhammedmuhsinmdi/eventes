import 'package:evantez/src/model/core/models/menu/menu_model.dart';
import 'package:evantez/src/model/repository/resource/rentalitem_repository.dart';
import 'package:evantez/src/view/core//constants/app_strings.dart';
import 'package:evantez/src/view/core//widgets/custom_back_btn.dart';
import 'package:evantez/src/view/view/admin/resouces/rental_items/widgets/add_rental_items.dart';
import 'package:evantez/src/view/view/admin/resouces/rental_items/widgets/rental_item_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

import '../../../../core/constants/app_images.dart';
import '../../../../core/constants/constants.dart';
import '../../../../core/themes/colors.dart';
import '../../../../core/themes/typography.dart';
import '../../../../core/widgets/custom_textfield.dart';

class RentalItemsView extends StatefulWidget {
  final MenuData menu;
  const RentalItemsView({super.key, required this.menu});

  @override
  State<RentalItemsView> createState() => _RentalItemsViewState();
}

class _RentalItemsViewState extends State<RentalItemsView> {
  @override
  Widget build(BuildContext context) {
    final kSize = MediaQuery.of(context).size;
    return Scaffold(
      appBar: appBar(context, kSize),
      body: Consumer<RentalItemsController>(
        builder: (context, value, child) {
          return SizedBox(
            height: kSize.height,
            width: kSize.width,
            child: Column(
              children: [
                SizedBox(
                  height: kSize.height * 0.016,
                ),
                searchField(kSize, context),
                SizedBox(
                  height: kSize.height * 0.024,
                ),
                rentalItemsListing(kSize),
              ],
            ),
          );
        },
      ),
    );
  }

  AppBar appBar(BuildContext context, Size kSize) {
    final controller = context.watch<RentalItemsController>();
    return AppBar(
      elevation: 0,
      leading: const CustomBackButton(),
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      centerTitle: true,
      title: Text(
        widget.menu.menuName!,
        style: AppTypography.poppinsSemiBold.copyWith(),
      ),
      actions: [
        IconButton(
            onPressed: () async {
              //
              controller.initStateLoading();
              AddRentalItems(context, 0).show();
            },
            icon: SvgPicture.asset(
              AppImages.addCircle,
              colorFilter: const ColorFilter.mode(
                AppColors.primaryColor,
                BlendMode.srcIn,
              ),
            ))
      ],
    );
  }

  Widget searchField(Size kSize, BuildContext context) {
    return Padding(
      padding:
          const EdgeInsets.symmetric(horizontal: AppConstants.baseBorderRadius),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Flexible(
            child: CustomTextField(
              text: '',
              hintText: AppStrings.searchText,
              suffixIcon: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 8.0, vertical: 10.0),
                child: SvgPicture.asset(
                  AppImages.search,
                  colorFilter: const ColorFilter.mode(
                      AppColors.primaryColor, BlendMode.srcIn),
                ),
              ),
            ),
          ),
          /*  SizedBox(
            width: kSize.width * 0.032,
          ),
          SizedBox(
            width: kSize.width * 0.1,
            child: TextButton(
                style: TextButton.styleFrom(
                  backgroundColor: AppColors.transparent,
                  padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 8.0),
                ),
                onPressed: () {
                   // filter
                },
                child: SvgPicture.asset(
                  AppImages.filter,
                  colorFilter: const ColorFilter.mode(AppColors.primaryColor, BlendMode.srcIn),
                )),
          ) */
        ],
      ),
    );
  }

  Widget rentalItemsListing(Size kSize) {
    final controller = context.watch<RentalItemsController>();
    return Expanded(
        child: ListView.builder(
            itemCount: controller.rentalItemsList.length,
            padding: EdgeInsets.only(
                bottom: kSize.height * 0.16,
                left: AppConstants.baseBorderRadius,
                right: AppConstants.baseBorderRadius),
            itemBuilder: (context, index) {
              return RentalItemsTile(index: index);
            }));
  }
}
