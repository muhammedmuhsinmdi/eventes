import 'package:evantez/app/router/router_constant.dart';
import 'package:evantez/src/model/core/models/menu/menu_model.dart';
import 'package:evantez/src/model/repository/auth/auth_controller.dart';
import 'package:evantez/src/model/repository/catering/food_items_repository.dart';
import 'package:evantez/src/view/core//constants/app_strings.dart';
import 'package:evantez/src/view/core//widgets/custom_back_btn.dart';
import 'package:evantez/src/view/view/admin/catering/food_items/widgets/food_item_filter.dart';
import 'package:evantez/src/view/view/admin/catering/food_items/widgets/food_items_tile.dart';
import 'package:evantez/src/view/view/admin/resouces/rental_items/widgets/add_rental_items.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

import '../../../../core/constants/app_images.dart';
import '../../../../core/constants/constants.dart';
import '../../../../core/themes/colors.dart';
import '../../../../core/themes/typography.dart';
import '../../../../core/widgets/custom_textfield.dart';

class FoodItemsView extends StatefulWidget {
  final MenuData menu;
  const FoodItemsView({super.key, required this.menu});

  @override
  State<FoodItemsView> createState() => _FoodItemsViewState();
}

class _FoodItemsViewState extends State<FoodItemsView> {
  late AuthController authController;
  late FoodItemsController controller;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      controller.foodItemList(token: authController.accesToken!);
      controller.foodItemTypeList(token: authController.accesToken!);
      controller.foodItemUnitList(token: authController.accesToken!);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    authController = context.watch<AuthController>();
    controller = context.watch<FoodItemsController>();
    final kSize = MediaQuery.of(context).size;
    return Scaffold(
      appBar: appBar(context, kSize),
      body: Consumer<FoodItemsController>(
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
                foodItemsListing(kSize),
              ],
            ),
          );
        },
      ),
    );
  }

  AppBar appBar(BuildContext context, Size kSize) {
    final controller = context.watch<FoodItemsController>();
    final auth = context.watch<AuthController>();
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
              controller.initStateLoading();
              Navigator.pushNamed(context, RouterConstants.addFoodItemRoute,
                  arguments: 0);
              /* showModalBottomSheet(
                  isScrollControlled: true,
                  shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(AppConstants.basePadding),
                          topRight: Radius.circular(AppConstants.basePadding))),
                  backgroundColor: AppColors.accentDark,
                  context: context,
                  builder: (context) {
                    return const FoodItemFilter(
                      index: 0,
                    );
                  }); */
              controller.foodItemTypeList(token: auth.accesToken ?? "");
              //
              // AddRentalItems(context).show();
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

  Widget foodItemsListing(Size kSize) {
    return Expanded(
        child: controller.isloading
            ? const Center(
                child: CircularProgressIndicator(
                  color: AppColors.primaryColor,
                ),
              )
            : ListView.builder(
                itemCount: controller.foodItemsList.length,
                padding: EdgeInsets.only(
                    bottom: kSize.height * 0.16,
                    left: AppConstants.baseBorderRadius,
                    right: AppConstants.baseBorderRadius),
                itemBuilder: (context, index) {
                  return FoodItemTile(
                    item: controller.foodItemsList[index],
                    index: index,
                  );
                }));
  }
}
