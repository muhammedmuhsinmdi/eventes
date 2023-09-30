/* import 'package:evantez/src/domain/core/models/menu/menu_model.dart';
import 'package:evantez/src/view/core//widgets/custom_back_btn.dart';
import 'package:evantez/src/presentation/view/resouces_view/widgets/menu_data_bottom_sheet.dart';
import 'package:evantez/src/presentation/view/resouces_view/widgets/resource_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../core/constants/app_images.dart';
import '../../core/constants/app_strings.dart';
import '../../core/constants/constants.dart';
import '../../core/themes/colors.dart';
import '../../core/themes/typography.dart';
import '../../core/widgets/custom_textfield.dart';

class ResourcesView extends StatelessWidget {
  final MenuData menu;
  const ResourcesView({super.key, required this.menu});

  @override
  Widget build(BuildContext context) {
    final kSize = MediaQuery.of(context).size;
    return Scaffold(
      appBar: appBar(context, kSize),
      body: SizedBox(
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
            resourceListing(kSize),
          ],
        ),
      ),
    );
  }

  AppBar appBar(BuildContext context, Size kSize) {
    return AppBar(
      elevation: 0,
      leading: const CustomBackButton(),
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      centerTitle: true,
      title: Text(
        menu.menuName!,
        style: AppTypography.poppinsSemiBold.copyWith(),
      ),
      actions: [
        IconButton(
            onPressed: () async {
              //
              await MenuDataBottomSheet(parentContext: context, menuData: menu).show();
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
      padding: const EdgeInsets.symmetric(horizontal: AppConstants.baseBorderRadius),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Flexible(
            child: CustomTextField(
              text: '',
              hintText: AppStrings.searchText,
              suffixIcon: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 10.0),
                child: SvgPicture.asset(
                  AppImages.search,
                  colorFilter: const ColorFilter.mode(AppColors.primaryColor, BlendMode.srcIn),
                ),
              ),
            ),
          ),
          SizedBox(
            width: kSize.width * 0.032,
          ),
          SizedBox(
            width: kSize.width * 0.1,
            child: TextButton(
                style: TextButton.styleFrom(
                  backgroundColor: AppColors.transparent,
                  padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 8.0),
                ),
                onPressed: () {},
                child: SvgPicture.asset(
                  AppImages.filter,
                  colorFilter: const ColorFilter.mode(AppColors.primaryColor, BlendMode.srcIn),
                )),
          )
        ],
      ),
    );
  }

  Widget resourceListing(Size kSize) {
    return Expanded(
        child: ListView.builder(
            itemCount: 10,
            padding: EdgeInsets.only(
                bottom: kSize.height * 0.16,
                left: AppConstants.baseBorderRadius,
                right: AppConstants.baseBorderRadius),
            itemBuilder: (context, index) {
              return const ResourceTile();
            }));
  }
}
 */