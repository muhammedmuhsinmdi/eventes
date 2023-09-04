import 'package:evantez/src/view/core/constants/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../../app/router/router_constant.dart';
import '../../../core/constants/app_images.dart';
import '../../../core/constants/app_strings.dart';
import '../../../core/themes/colors.dart';
import '../../../core/themes/typography.dart';
import '../../../core/widgets/custom_back_btn.dart';
import '../../../core/widgets/custom_textfield.dart';

class QuotationsView extends StatelessWidget {
  const QuotationsView({super.key});

  @override
  Widget build(BuildContext context) {
    final kSize = MediaQuery.of(context).size;
    return Scaffold(
      appBar: appBar(context, kSize),
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: /*  Padding(
        padding: const EdgeInsets.fromLTRB(
            AppConstants.baseBorderRadius, AppConstants.baseBorderRadius, AppConstants.baseBorderRadius, 0),
        child: */
          SizedBox(
        height: kSize.height,
        width: kSize.width,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            searchField(kSize),
            SizedBox(
              height: kSize.height * 0.012,
            ),
            quotationListing(context, kSize),
          ],
        ),
        // ),
      ),
    );
  }

  Widget quotationListing(BuildContext context, Size kSize) {
    return Expanded(
      child: ListView.separated(
          padding: const EdgeInsets.fromLTRB(
            AppConstants.baseBorderRadius,
            0,
            AppConstants.baseBorderRadius,
            AppConstants.largePadding,
          ),
          itemBuilder: (context, index) {
            return InkWell(
              highlightColor: AppColors.transparent,
              splashColor: AppColors.transparent,
              onTap: () {
                //
                Navigator.pushNamed(context, RouterConstants.quotationDetailRoute);
              },
              child: SizedBox(
                width: kSize.width,
                child: ListTile(
                  leading: leadingPopUpMenu(kSize),
                  contentPadding: EdgeInsets.symmetric(horizontal: kSize.width * 0.01),
                  title: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      //
                      Text(
                        'Quote #B0456',
                        style: AppTypography.poppinsSemiBold.copyWith(
                          color: AppColors.secondaryColor,
                          fontSize: 18,
                        ),
                      ),
                      Text(
                        'Amount ₹ 15454',
                        style: AppTypography.poppinsMedium.copyWith(
                          color: AppColors.secondaryColor,
                          fontSize: 14,
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Orange Kottakkal',
                            style: AppTypography.poppinsMedium.copyWith(
                              color: AppColors.secondaryColor.withOpacity(0.6),
                              fontSize: 14,
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                            decoration: BoxDecoration(
                                border: Border.all(color: AppColors.secondaryColor.withOpacity(0.4)),
                                color: AppColors.statusSuccess,
                                borderRadius: BorderRadius.circular(AppConstants.baseBorderRadius)),
                            child: Text(
                              'Approved',
                              style: AppTypography.poppinsMedium.copyWith(
                                color: AppColors.secondaryColor,
                                fontSize: 12,
                              ),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            );
          },
          separatorBuilder: (context, index) {
            return Padding(
              padding: EdgeInsets.symmetric(vertical: kSize.height * 0.016),
              child: Divider(
                color: AppColors.secondaryColor.withOpacity(0.3),
              ),
            );
          },
          itemCount: 20),
    );
  }

  Widget leadingPopUpMenu(Size kSize) {
    List<String> popupList = ['Mark Approved', 'Mark Rejected', 'Mark Pending', 'Edit', 'Share', 'Delete'];
    return SizedBox(
      width: kSize.width * 0.04,
      child: PopupMenuButton<String>(
        initialValue: '',
        // Callback that sets the selected popup menu item.
        onSelected: (item) {
          //
        },
        clipBehavior: Clip.antiAlias,
        padding: EdgeInsets.zero, //symmetric(horizontal: kSize.height * 0.024),
        shape: RoundedRectangleBorder(
            side: const BorderSide(
              color: AppColors.accentColor,
            ),
            borderRadius: BorderRadius.circular(
              AppConstants.basePadding,
            )),

        itemBuilder: (BuildContext context) => List.generate(popupList.length, (index) {
          return PopupMenuItem<String>(
            onTap: () {
              // selectedCaptain.value = index;
            },
            padding: EdgeInsets.symmetric(
              horizontal: kSize.width * 0.05,
            ),
            value: popupList[index],
            child: Text(
              popupList[index],
              textAlign: TextAlign.start,
              style: AppTypography.poppinsMedium.copyWith(
                fontSize: 14,
              ),
            ),
          );
        }),
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
        AppStrings.quotations,
        style: AppTypography.poppinsSemiBold.copyWith(
          color: AppColors.secondaryColor,
        ),
      ),
      actions: [
        IconButton(
          onPressed: () {
            //
            Navigator.pushNamed(context, RouterConstants.newQuotationRoute);
          },
          icon: SvgPicture.asset(
            AppImages.addCircle,
            colorFilter: const ColorFilter.mode(
              AppColors.primaryColor,
              BlendMode.srcIn,
            ),
          ),
        )
      ],
    );
  }

  Widget searchField(Size kSize) {
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
                onPressed: () {
                  //
                },
                child: SvgPicture.asset(
                  AppImages.filter,
                  colorFilter: const ColorFilter.mode(AppColors.primaryColor, BlendMode.srcIn),
                )),
          )
        ],
      ),
    );
  }
}
