import 'package:evantez/src/view/core//constants/constants.dart';
import 'package:evantez/src/view/core//widgets/custom_back_btn.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../../../../app/router/router_constant.dart';
import '../../../../../../model/core/models/menu/menu_model.dart';
import '../../../../../core/constants/app_images.dart';
import '../../../../../core/constants/app_strings.dart';
import '../../../../../core/themes/colors.dart';
import '../../../../../core/themes/typography.dart';
import '../../../../../core/widgets/custom_textfield.dart';

class InvoicesView extends StatelessWidget {
  final MenuData menu;
  const InvoicesView({super.key, required this.menu});

  @override
  Widget build(BuildContext context) {
    final kSize = MediaQuery.of(context).size;
    return Scaffold(
      appBar: appBar(context, kSize),
      body: SizedBox(
        height: kSize.height,
        width: kSize.width,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(
              AppConstants.baseBorderRadius, AppConstants.baseBorderRadius, AppConstants.baseBorderRadius, 0),
          child: Column(
            children: [
              searchField(kSize),
              SizedBox(
                height: kSize.height * 0.012,
              ),
              invoiceListing(kSize, context),
            ],
          ),
        ),
      ),
    );
  }

  Widget invoiceListing(Size kSize, BuildContext context) {
    return Expanded(
        child: ListView.separated(
            separatorBuilder: (context, index) {
              return Divider(
                color: AppColors.secondaryColor.withOpacity(0.2),
              );
            },
            itemCount: 10,
            padding: EdgeInsets.only(top: kSize.height * 0.016),
            itemBuilder: (context, index) {
              return InkWell(
                highlightColor: AppColors.transparent,
                splashColor: AppColors.transparent,
                onTap: () {
                  //
                  Navigator.pushNamed(context, RouterConstants.invoiceDetailRoute);
                },
                child: Padding(
                  padding: EdgeInsets.all(kSize.height * 0.016),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Invoice #B0456',
                        style: AppTypography.poppinsSemiBold.copyWith(
                          fontSize: 18,
                          color: AppColors.secondaryColor,
                        ),
                      ),
                      Text(
                        'Amount  ₹ 88454',
                        style: AppTypography.poppinsMedium.copyWith(
                          fontSize: 16,
                          color: AppColors.secondaryColor,
                        ),
                      ),
                      Text(
                        'Orange Kottakkal',
                        style: AppTypography.poppinsMedium.copyWith(
                          fontSize: 16,
                          color: AppColors.secondaryColor.withOpacity(0.6),
                        ),
                      ),
                      /*  if (index != 9) ...{
                        SizedBox(
                          height: kSize.height * 0.016,
                        ),
                        Divider(
                          color: AppColors.secondaryColor.withOpacity(0.2),
                        ),
                      } */
                    ],
                  ),
                ),
              );
            }));
  }

  Widget searchField(Size kSize) {
    return Row(
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
    );
  }

  AppBar appBar(BuildContext context, Size kSize) {
    return AppBar(
      elevation: 0,
      leading: const CustomBackButton(),
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      centerTitle: true,
      title: Text(
        AppStrings.invoiceText,
        style: AppTypography.poppinsSemiBold.copyWith(
          color: AppColors.secondaryColor,
        ),
      ),
      actions: [
        IconButton(
          onPressed: () {
            //
            Navigator.pushNamed(context, RouterConstants.newInvoiceRoute);
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
}
