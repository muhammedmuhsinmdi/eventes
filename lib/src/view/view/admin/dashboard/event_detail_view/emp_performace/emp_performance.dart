import 'dart:developer';

import 'package:evantez/src/view/core//constants/app_strings.dart';
import 'package:evantez/src/view/core//constants/constants.dart';
import 'package:evantez/src/view/core//widgets/custom_rating_star.dart';
import 'package:evantez/src/view/core//widgets/custom_textfield.dart';
import 'package:evantez/src/view/core//widgets/footer_button.dart';
import 'package:evantez/src/view/view/admin/dashboard/event_detail_view/emp_performace/widgets/emp_setting_work.dart';
import 'package:evantez/src/view/view/admin/dashboard/event_detail_view/emp_performace/widgets/employee_payment_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../../core/constants/app_images.dart';
import '../../../../../core/themes/colors.dart';
import '../../../../../core/themes/typography.dart';
import '../../../../../core/widgets/custom_back_btn.dart';
import '../../../../../core/widgets/custom_date_picker.dart';

class EmployeePerformanceView extends StatefulWidget {
  final String eventStatus;
  const EmployeePerformanceView({super.key, required this.eventStatus});

  @override
  State<EmployeePerformanceView> createState() => _EmployeePerformanceViewState();
}

class _EmployeePerformanceViewState extends State<EmployeePerformanceView> {
  TextEditingController performanceDetails = TextEditingController();

  @override
  Widget build(BuildContext context) {
    log(widget.eventStatus);
    final kSize = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: appBar(context, kSize),
      body: SizedBox(
        height: kSize.height,
        width: kSize.width,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(AppConstants.baseBorderRadius, AppConstants.baseBorderRadius,
                AppConstants.baseBorderRadius, 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                empProPicDetail(kSize: kSize, context: context),
                SizedBox(
                  height: kSize.height * 0.024,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Working on',
                      style: AppTypography.poppinsMedium
                          .copyWith(color: AppColors.secondaryColor.withOpacity(0.6), fontSize: 14),
                    ),
                    // if (eventStatus.isNotEmpty)
                    Container(
                      margin: EdgeInsets.only(top: kSize.height * 0.013, left: kSize.height * 0.016),
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                      decoration: BoxDecoration(
                        border: Border.all(color: AppColors.secondaryColor.withOpacity(0.4)),
                        color: getEventStatusColor(widget.eventStatus),
                        borderRadius: BorderRadius.circular(AppConstants.basePadding),
                      ),
                      child: Text(
                        getEventStatus(widget.eventStatus),
                        style: AppTypography.poppinsMedium.copyWith(
                          fontSize: 12,
                          color: AppColors.secondaryColor,
                        ),
                      ),
                    )
                  ],
                ),
                Text(
                  'Nava Auditorium',
                  style: AppTypography.poppinsSemiBold.copyWith(
                    fontSize: 18,
                    color: AppColors.secondaryColor,
                  ),
                ),
                Text(
                  'Marriage Function',
                  style: AppTypography.poppinsLight.copyWith(
                    fontSize: 16,
                    color: AppColors.secondaryColor,
                  ),
                ),
                Text(
                  '03 Nov, 2023 -  02:30PM-11:30 PM',
                  style: AppTypography.poppinsSemiBold.copyWith(
                    fontSize: 12,
                    color: AppColors.secondaryColor.withOpacity(0.6),
                  ),
                ),
                SizedBox(height: kSize.height * 0.024),
                Divider(
                  color: AppColors.secondaryColor.withOpacity(0.2),
                ),
                SizedBox(height: kSize.height * 0.024),
                // Remove Button
                if (widget.eventStatus == 'Upcoming - Filled') removeBtn(),
                // Remove Button

                if (widget.eventStatus == 'Ongoing' ||
                    widget.eventStatus == 'Settlement' ||
                    widget.eventStatus == 'Completed') ...{
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CustomDatePicker(
                        controller: TextEditingController(text: "03 Nov, 2023"),
                        label: "Entry",
                        type: 'Time',
                        onChanged: (value) {
                          log(value);
                        },
                      ),
                      CustomDatePicker(
                        controller: TextEditingController(text: ''),
                        label: "Exit",
                        type: 'Time',
                        onChanged: (value) {
                          log(value);
                        },
                      ),
                    ],
                  ),
                  SizedBox(
                    height: kSize.height * 0.024,
                  ),
                  Divider(
                    color: AppColors.secondaryColor.withOpacity(0.2),
                  ),
                  SizedBox(
                    height: kSize.height * 0.024,
                  ),
                  Text(
                    'Rating',
                    style: AppTypography.poppinsSemiBold.copyWith(
                      fontSize: 18,
                      color: AppColors.secondaryColor,
                    ),
                  ),
                  SizedBox(
                    height: kSize.height * 0.024,
                  ),
                  CustomRatingStar(
                    onRating: (value) {
                      log("$value");
                    },
                    hideValue: false,
                    height: kSize.height * 0.018,
                    ignoreGestures: false,
                    initialRating: 0.0,
                  ),
                  SizedBox(
                    height: kSize.height * 0.024,
                  ),
                  Text(
                    'Performance',
                    style: AppTypography.poppinsSemiBold.copyWith(
                      fontSize: 18,
                      color: AppColors.secondaryColor,
                    ),
                  ),
                  SizedBox(
                    height: kSize.height * 0.024,
                  ),
                  CustomTextField(
                    text: '',
                    maxLines: 2,
                    controller: performanceDetails,
                    hintStyle: AppTypography.poppinsRegular
                        .copyWith(fontSize: 16, color: AppColors.secondaryColor.withOpacity(0.6)),
                    hintText: 'Enter performance details of employee',
                  )
                },
                Padding(
                  padding: EdgeInsets.symmetric(vertical: kSize.height * 0.024),
                  child: Divider(
                    color: AppColors.secondaryColor.withOpacity(0.2),
                  ),
                ),
                EmployeePaymentTile(
                  getAdditionalAmount: (additionalAmt) {
                    // get additional amount
                    log('$additionalAmt');
                  },
                  getCutAmount: (cutAmnt) {
                    // get cut amount
                    log('$cutAmnt');
                  },
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: kSize.height * 0.024),
                  child: Divider(
                    color: AppColors.secondaryColor.withOpacity(0.2),
                  ),
                ),
                EmployeeSettingWork(
                  items: const ["Table Settings", "Chair settings", "Woping", "Manage Entry", "Serve Drinks"],
                  onSelected: (settingWorkList) {
                    log("$settingWorkList");
                  },
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: kSize.height * 0.024),
                  child: Divider(
                    color: AppColors.secondaryColor.withOpacity(0.2),
                  ),
                ),
                ExpansionTile(
                  iconColor: AppColors.primaryColor,
                  trailing: SvgPicture.asset(
                    AppImages.arrowDown,
                    colorFilter: const ColorFilter.mode(AppColors.primaryColor, BlendMode.srcIn),
                  ),
                  tilePadding: EdgeInsets.zero,
                  initiallyExpanded: true,
                  title: Text(
                    "Total Due",
                    style: AppTypography.poppinsSemiBold.copyWith(
                      color: AppColors.secondaryColor,
                      fontSize: 18,
                    ),
                  ),
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("${AppStrings.overTimeText}    200 Per Hour",
                            style: AppTypography.poppinsMedium.copyWith(
                              color: AppColors.secondaryColor.withOpacity(0.6),
                              fontSize: 14,
                            )),
                        Text("₹ 1400",
                            style: AppTypography.poppinsMedium.copyWith(
                              color: AppColors.secondaryColor,
                              fontSize: 14,
                            )),
                      ],
                    ),
                    SizedBox(
                      height: kSize.height * 0.016,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Setting Work",
                            style: AppTypography.poppinsMedium.copyWith(
                              color: AppColors.secondaryColor.withOpacity(0.6),
                              fontSize: 14,
                            )),
                        Text("₹ 48",
                            style: AppTypography.poppinsMedium.copyWith(
                              color: AppColors.secondaryColor,
                              fontSize: 14,
                            )),
                      ],
                    ),
                    SizedBox(
                      height: kSize.height * 0.024,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Total",
                            style: AppTypography.poppinsSemiBold.copyWith(
                              color: AppColors.secondaryColor,
                              fontSize: 18,
                            )),
                        Text("₹ 4,154",
                            style: AppTypography.poppinsSemiBold.copyWith(
                              color: AppColors.secondaryColor,
                              fontSize: 18,
                            )),
                      ],
                    ),
                    SizedBox(
                      height: kSize.height * 0.024,
                    ),
                  ],
                ),
                SizedBox(
                  height: kSize.height * 0.024,
                ),
                FooterButton(
                    label: "Give Early Settlement",
                    fillColor: AppColors.transparent,
                    borderColor: AppColors.statusCritical,
                    onTap: () {}),
                SizedBox(
                  height: kSize.height * 0.024,
                ),
                FooterButton(
                    label: "Mark Exit Manually",
                    fillColor: AppColors.transparent,
                    borderColor: AppColors.statusCritical,
                    onTap: () {}),
                SizedBox(
                  height: kSize.height * 0.1,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget removeBtn() {
    return FooterButton(
        borderColor: AppColors.statusCritical,
        fillColor: AppColors.transparent,
        label: 'Remove',
        onTap: () {});
  }

  Color getEventStatusColor(String status) {
    switch (status) {
      case "Upcoming - Hold":
        return AppColors.statusCritical;
      case "Upcoming - Open":
        return AppColors.statusSuccess;
      case "Upcoming - Filled":
        return AppColors.statusWarning;
      case "Ongoing":
        return AppColors.statusSuccess;
      case "Settlement":
        return AppColors.statusBlue;
      case "Completed":
        return AppColors.statusPending;
      default:
        return AppColors.transparent;
    }
  }

  String getEventStatus(String status) {
    switch (status) {
      case "Upcoming - Hold":
        return "Hold";
      case "Upcoming - Open":
        return "Upcoming";
      case "Upcoming - Filled":
        return "Upcoming";
      case "Ongoing":
        return "Ongoing";
      case "Settlement":
        return "Settlement";
      case "Completed":
        return "Completed";
      default:
        return '';
    }
  }

  Widget empProPicDetail({required Size kSize, required BuildContext context}) {
    return Row(
      children: [
        Container(
          clipBehavior: Clip.antiAlias,
          width: kSize.height * 0.1,
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(8.0)),
          height: kSize.height * 0.1,
          child: const Placeholder(),
        ),
        SizedBox(
          width: kSize.width * 0.018,
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Suhail Pallikkal',
              maxLines: 2,
              style: AppTypography.poppinsSemiBold.copyWith(fontSize: 24),
            ),
            Text(
              'A Boy',
              style: AppTypography.poppinsLight
                  .copyWith(color: AppColors.secondaryColor.withOpacity(0.6), fontSize: 14),
            ),
            Row(
              children: [
                Container(
                  margin: const EdgeInsets.only(right: AppConstants.basePadding / 2),
                  height: kSize.height * 0.01,
                  width: kSize.height * 0.01,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: AppColors.statusSuccess,
                  ),
                ),
                Text(
                  'Present',
                  style: AppTypography.poppinsMedium
                      .copyWith(color: AppColors.secondaryColor.withOpacity(0.6), fontSize: 12),
                ),
              ],
            )
          ],
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
        AppStrings.performanceText,
        style: AppTypography.poppinsSemiBold.copyWith(
          color: AppColors.secondaryColor,
        ),
      ),
      actions: [
        IconButton(
            onPressed: () {},
            icon: SvgPicture.asset(
              AppImages.edit,
              colorFilter: const ColorFilter.mode(
                AppColors.primaryColor,
                BlendMode.srcIn,
              ),
            ))
      ],
    );
  }
}
