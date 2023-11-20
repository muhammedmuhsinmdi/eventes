import 'dart:developer';

import 'package:evantez/app/app.dart';
import 'package:evantez/src/controller/auth/auth_controller.dart';
import 'package:evantez/src/controller/resources/settingswages_controller.dart';
import 'package:evantez/src/model/components/snackbar_widget.dart';
import 'package:evantez/src/view/core//constants/constants.dart';
import 'package:evantez/src/view/core//themes/colors.dart';
import 'package:evantez/src/view/core//themes/typography.dart';
import 'package:evantez/src/view/view/admin/resouces/settings_wage/widgets/add_setting_wage_bottom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddSettingsTile extends StatelessWidget {
  const AddSettingsTile({super.key, required this.index});
  final int index;
  @override
  Widget build(BuildContext context) {
    final kSize = MediaQuery.of(context).size;
    final authController = context.watch<AuthController>();
    final controller = context.watch<SettingsWageController>();
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
                /*   'Chair Cover Dressing' */ controller.settingsWageLists[index].name,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: AppTypography.poppinsSemiBold.copyWith(
                  fontSize: 18,
                  color: AppColors.secondaryColor,
                ),
              ),
              RichText(
                text: TextSpan(
                    text: 'Price Range ',
                    style: AppTypography.poppinsMedium
                        .copyWith(fontSize: 14, color: AppColors.secondaryColor.withOpacity(0.5)),
                    children: [
                      TextSpan(
                          text: controller.settingsWageLists[index].rate,
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
                // setState(() {
                if (item == 'edit') {
                  controller.initStateLoading(data: controller.settingsWageLists[index]);
                  AddSettingWageBottomSheet(context, index).show();
                  log(item);
                }
                if (item == 'delete') {
                  deleteSettingsWage(
                    authController: authController,
                    controller: controller,
                    token: authController.accesToken!,
                    wageId: controller.settingsWageLists[index].id,
                  );
                }

                // });
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
                PopupMenuItem<String>(
                  padding: EdgeInsets.symmetric(
                    horizontal: kSize.width * 0.05,
                  ),
                  value: "delete",
                  child: Text(
                    'Delete',
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

  Future deleteSettingsWage(
      {required String token,
      required int wageId,
      required SettingsWageController controller,
      required AuthController authController}) async {
    try {
      await controller.deleteSettingWage(token, wageId).then((value) async {
        if (value) {
          await controller.settingsWageList(token: authController.accesToken!);
          rootScaffoldMessengerKey.currentState!
              .showSnackBar(snackBarWidget('Successfully deleted!', color: Colors.green));
          await Future.delayed(const Duration(seconds: 2));
        } else {
          rootScaffoldMessengerKey.currentState!
              .showSnackBar(snackBarWidget('Delete failed!', color: Colors.red));
          await Future.delayed(const Duration(seconds: 2));
        }
      });
    } catch (_) {}
  }
}
