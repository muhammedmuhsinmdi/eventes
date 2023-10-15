import 'dart:developer';

import 'package:evantez/src/view/core/constants/constants.dart';
import 'package:evantez/src/view/core/themes/typography.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../constants/app_images.dart';
import '../constants/app_strings.dart';
import '../themes/colors.dart';
import 'custom_textfield.dart';

class CustomBottomSheet {
  BuildContext context;
  List<String>? listItems;
  String? headLabel;
  TextEditingController? searchController;
  CustomBottomSheet({required this.context, this.listItems, this.headLabel, this.searchController});

  showCustomSheet() {
    if (listItems != null && listItems!.isNotEmpty) {
      showModalBottomSheet(
          context: context,
          isDismissible: false,
          isScrollControlled: true,
          backgroundColor: AppColors.accentDark,
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(AppConstants.basePadding),
                  topRight: Radius.circular(AppConstants.basePadding))),
          builder: (context) {
            return CustomListSheet(
              listItems: listItems!,
              headLabel: headLabel!,
              searchController: searchController,
            );
          });
    }
  }
}

class CustomListSheet extends StatefulWidget {
  final List<String> listItems;
  final String headLabel;
  final TextEditingController? searchController;
  final Function(String)? onSelected;
  const CustomListSheet(
      {super.key, required this.listItems, required this.headLabel, this.searchController, this.onSelected});

  @override
  State<CustomListSheet> createState() => _CustomListSheetState();
}

class _CustomListSheetState extends State<CustomListSheet> {
  List<String> selectItems = [];

  @override
  void initState() {
    selectItems.addAll(widget.listItems);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final kSize = MediaQuery.of(context).size;
    final keyboard = MediaQuery.of(context).viewInsets;
    log("$keyboard");
    return Padding(
        padding: EdgeInsets.only(
            bottom: keyboard.bottom,
            top: AppConstants.baseBorderRadius,
            left: AppConstants.baseBorderRadius,
            right: AppConstants.baseBorderRadius),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: AppConstants.baseButtonBorderRadius),
              child: Row(
                children: [
                  const Spacer(
                    flex: 3,
                  ),
                  Text(
                    widget.headLabel,
                    style: AppTypography.poppinsSemiBold.copyWith(
                      fontSize: 18,
                      color: AppColors.secondaryColor,
                    ),
                  ),
                  const Spacer(
                    flex: 2,
                  ),
                  InkWell(
                      highlightColor: AppColors.transparent,
                      splashColor: AppColors.transparent,
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Text(
                        AppStrings.closeText,
                        style: AppTypography.poppinsMedium
                            .copyWith(fontSize: 14, color: AppColors.secondaryColor.withOpacity(0.6)),
                      ))
                ],
              ),
            ),
            searchField(kSize),
            SizedBox(
              height: kSize.height * 0.36,
              child: ListView.separated(
                  padding: const EdgeInsets.only(bottom: AppConstants.largePadding),
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () {
                        //
                        log("LLLL");
                        if (widget.onSelected != null) {
                          widget.onSelected!(selectItems[index]);
                        }
                      },
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(6.0),
                            color: AppColors.secondaryColor.withOpacity(0.1)),
                        padding: const EdgeInsets.all(8.0),
                        width: kSize.width,
                        child: Text(selectItems[index],
                            style: AppTypography.poppinsLight.copyWith(
                              fontSize: 16,
                            )),
                      ),
                    );
                  },
                  separatorBuilder: (context, index) {
                    return const Padding(padding: EdgeInsets.only(bottom: 8.0));
                  },
                  itemCount: selectItems.length),
            )
          ],
        ));
  }

  Widget searchField(Size kSize) {
    return Padding(
      padding: const EdgeInsets.only(bottom: AppConstants.baseBorderRadius),
      child: Flexible(
        child: CustomTextField(
          text: '',
          onChanged: (value) {
            // search items
            if (value.isNotEmpty) {
              for (var item in selectItems) {
                if (selectItems.contains(value)) {
                  // keep
                } else {}
              }
            }
          },
          controller: widget.searchController,
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
    );
  }
}
