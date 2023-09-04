import 'dart:developer';

import 'package:evantez/src/view/core//constants/constants.dart';
import 'package:evantez/src/view/core//widgets/custom_back_btn.dart';
import 'package:evantez/src/view/core//widgets/custom_date_picker.dart';
import 'package:evantez/src/view/core//widgets/footer_button.dart';
import 'package:evantez/src/view/view/event_detail_view/widgets/urgent_emp_sheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../core/constants/app_images.dart';
import '../../core/constants/app_strings.dart';
import '../../core/themes/colors.dart';
import '../../core/themes/typography.dart';
import '../../core/widgets/custom_textfield.dart';

class BoyEventDetailView extends StatefulWidget {
  const BoyEventDetailView({super.key});

  @override
  State<BoyEventDetailView> createState() => _BoyEventDetailViewState();
}

class _BoyEventDetailViewState extends State<BoyEventDetailView> {
  ValueNotifier<String> selectedeventStatus = ValueNotifier<String>('Completed');

  @override
  Widget build(BuildContext context) {
    final kSize = MediaQuery.of(context).size;
    return Scaffold(
        appBar: appBar(context, kSize),
        body: SizedBox(
          height: kSize.height,
          width: kSize.width,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: AppConstants.baseBorderRadius),
            child: SingleChildScrollView(
              child: ValueListenableBuilder(
                  valueListenable: selectedeventStatus,
                  builder: (context, value, child) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: kSize.height * 0.016),
                        eventImage(kSize, context, selectedeventStatus.value),
                        SizedBox(height: kSize.height * 0.024),
                        Text(
                          "Nova Auditorium",
                          style: AppTypography.poppinsMedium.copyWith(
                            fontSize: 24,
                            color: AppColors.primaryColor,
                          ),
                        ),
                        SizedBox(
                          height: kSize.height * 0.01,
                        ),
                        Text(
                          "Marriage Function",
                          style: AppTypography.poppinsRegular.copyWith(
                            fontSize: 16,
                            color: AppColors.secondaryColor.withOpacity(0.6),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: kSize.height * 0.024),
                          child: Divider(
                            color: AppColors.secondaryColor.withOpacity(0.2),
                          ),
                        ),
                        if (selectedeventStatus.value.isNotEmpty &&
                            (selectedeventStatus.value == "Upcoming - Hold" ||
                                selectedeventStatus.value == 'Open' ||
                                selectedeventStatus.value == 'Completed'))
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              CustomDatePicker(
                                readOnly: true,
                                controller: TextEditingController(text: "03 Nov, 2023"),
                                label: "Date",
                                type: 'Date',
                                onChanged: (value) {
                                  log(value);
                                },
                              ),
                              CustomDatePicker(
                                readOnly: true,
                                controller: TextEditingController(text: '02:30PM-11:30 PM'),
                                label: "Time",
                                type: 'Time',
                                onChanged: (value) {
                                  log(value);
                                },
                              ),
                            ],
                          ),
                        if (selectedeventStatus.value == "Completed") ...{
                          SizedBox(
                            height: kSize.height * 0.024,
                          ),
                          CustomDatePicker(
                            readOnly: true,
                            controller: TextEditingController(text: '02:30PM-11:30 PM'),
                            label: "Actual Time",
                            type: 'Time',
                            onChanged: (value) {
                              log(value);
                            },
                          ),
                        },
                        if (selectedeventStatus.value == "Ongoing" ||
                            selectedeventStatus.value == "Settlement") ...{
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              CustomDatePicker(
                                readOnly: true,
                                controller: TextEditingController(),
                                label: "Entry",
                                type: 'Time',
                                onChanged: (value) {
                                  log(value);
                                },
                              ),
                              CustomDatePicker(
                                readOnly: true,
                                controller: TextEditingController(),
                                label: "Exit",
                                type: 'Time',
                                onChanged: (value) {
                                  log(value);
                                },
                              ),
                            ],
                          ),
                        },
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: kSize.height * 0.024),
                          child: Divider(
                            color: AppColors.secondaryColor.withOpacity(0.2),
                          ),
                        ),
                        // if (selectedeventStatus.value.isNotEmpty) ...{
                        // SELECT EVENT STATUS
                        selectSlotByStatus(selectedeventStatus.value, context),
                        SizedBox(height: kSize.height * 0.024),
                        //
                        // },
                        Text(
                          AppStrings.additionalInfoText,
                          style: AppTypography.poppinsSemiBold.copyWith(
                            fontSize: 18,
                            color: AppColors.secondaryColor,
                          ),
                        ),
                        SizedBox(height: kSize.height * 0.01),
                        Text(
                          "The conference is open to boys of all ages who are interested in event management as a career or hobby.",
                          style: AppTypography.poppinsRegular.copyWith(
                            fontSize: 16,
                            color: AppColors.secondaryColor.withOpacity(0.6),
                          ),
                        ),
                        SizedBox(height: kSize.height * 0.024),
                        Text(
                          AppStrings.locationText,
                          style: AppTypography.poppinsSemiBold.copyWith(
                            fontSize: 18,
                            color: AppColors.secondaryColor,
                          ),
                        ),
                        SizedBox(height: kSize.height * 0.01),
                        locationTile(kSize, context),
                        SizedBox(height: kSize.height * 0.032),
                      ],
                    );
                  }),
            ),
          ),
        ));
  }

  Widget overTimeDetail(Size kSize) {
    return Row(
      // mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        SizedBox(
          width: kSize.width * 0.17,
          child: Text(
            "Normal Hours",
            textAlign: TextAlign.end,
            maxLines: 2,
            style: AppTypography.poppinsMedium.copyWith(color: AppColors.secondaryColor.withOpacity(0.6)),
          ),
        ),
        SizedBox(
          width: kSize.width * 0.015,
        ),
        Flexible(
          // width: kSize.width * 0.2,
          child: CustomTextField(
            text: '',
            readOnly: selectedeventStatus.value == "Settlement" || selectedeventStatus.value == "Completed"
                ? true
                : false,
            keyboardType: TextInputType.number,
            suffixIcon: Padding(
              padding: EdgeInsets.only(top: kSize.height * 0.015),
              child: Text(
                'Hrs',
                textAlign: TextAlign.end,
                style: AppTypography.poppinsSemiBold.copyWith(color: AppColors.secondaryColor, fontSize: 16),
              ),
            ),
          ),
        ),
        SizedBox(
          width: kSize.width * 0.016,
        ),
        Container(
          height: kSize.height * 0.04,
          width: 2,
          color: AppColors.secondaryColor.withOpacity(0.6),
        ),
        SizedBox(
          width: kSize.width * 0.016,
        ),
        SizedBox(
          width: kSize.width * 0.2,
          child: Text(
            "Overtime Rate/Hr",
            textAlign: TextAlign.end,
            maxLines: 2,
            style: AppTypography.poppinsMedium.copyWith(color: AppColors.secondaryColor.withOpacity(0.6)),
          ),
        ),
        SizedBox(
          width: kSize.width * 0.015,
        ),
        Flexible(
          child: CustomTextField(
            readOnly: selectedeventStatus.value == "Settlement" || selectedeventStatus.value == "Completed"
                ? true
                : false,
            keyboardType: TextInputType.number,
            text: '',
          ),
        ),
      ],
    );
  }

  Widget urgentEmpNeed(BuildContext context) {
    return FooterButton(
        borderColor: AppColors.statusCritical,
        fillColor: AppColors.transparent,
        label: "Urgent Employee Needed",
        onTap: () {
          //
          showModalBottomSheet(
              context: context,
              backgroundColor: AppColors.accentDark,
              isScrollControlled: true,
              shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(AppConstants.basePadding),
                      topRight: Radius.circular(AppConstants.basePadding))),
              builder: (context) {
                return UrgentEmpSheet();
              });
        });
  }

  Widget selectSlotByStatus(String status, BuildContext context) {
    switch (status) {
      case "Upcoming - Hold":
        return const SizedBox();
      case "Upcoming - Open":
        return openEvent();
      case "accepted":
        return acceptedSlot();
      case "Ongoing":
        return ongoing();
      case "Settlement":
        return settlementSlot();
      case "Completed":
        return completedSlot();
      default:
        return const SizedBox();
      // return AppColors.transparent;
    }
  }

  Widget completedSlot() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: AppConstants.baseBorderRadius),
          child: Text(
            AppStrings.paymentText,
            style: AppTypography.poppinsSemiBold.copyWith(
              color: AppColors.secondaryColor,
              fontSize: 18,
            ),
          ),
        ),
        Column(
          children: List.generate(
              3,
              (index) => Padding(
                    padding: EdgeInsets.only(bottom: index == 2 ? 0 : AppConstants.basePadding),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          index == 0
                              ? "Normal Wage"
                              : index == 1
                                  ? "OverTime   200/Hr"
                                  : "Setting Work",
                          style: AppTypography.poppinsRegular
                              .copyWith(color: AppColors.secondaryColor, fontSize: 14),
                        ),
                        Text(
                          "₹ 2484",
                          style: AppTypography.poppinsRegular
                              .copyWith(color: AppColors.secondaryColor, fontSize: 14),
                        )
                      ],
                    ),
                  )),
        ),
        Padding(
          padding: const EdgeInsets.only(top: AppConstants.baseBorderRadius),
          child: Divider(
            color: AppColors.secondaryColor.withOpacity(0.3),
          ),
        )
      ],
    );
  }

  Widget settlementSlot() {
    final kSize = MediaQuery.of(context).size;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: AppConstants.baseBorderRadius),
          child: Text(
            "Setting Work",
            style: AppTypography.poppinsSemiBold.copyWith(
              color: AppColors.secondaryColor,
              fontSize: 18,
            ),
          ),
        ),
        Column(
          children: List.generate(
              2,
              (index) => Container(
                    decoration: BoxDecoration(
                      color: AppColors.secondaryColor.withOpacity(0.05),
                      borderRadius: BorderRadiusDirectional.circular(AppConstants.baseTextFieldBorderRdious),
                    ),
                    margin: const EdgeInsets.only(bottom: AppConstants.baseTextFieldBorderRdious),
                    padding: const EdgeInsets.all(AppConstants.marginSpace),
                    width: kSize.width,
                    child: Row(
                      children: [
                        Text(
                          "Serve Table",
                          style: AppTypography.poppinsRegular
                              .copyWith(color: AppColors.secondaryColor, fontSize: 14),
                        ),
                        const Spacer(
                          flex: 3,
                        ),
                        Text(
                          "1",
                          style: AppTypography.poppinsRegular
                              .copyWith(color: AppColors.secondaryColor, fontSize: 14),
                        ),
                        const Spacer(),
                        Text(
                          "₹ 2484",
                          style: AppTypography.poppinsRegular
                              .copyWith(color: AppColors.secondaryColor, fontSize: 14),
                        )
                      ],
                    ),
                  )),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: AppConstants.baseBorderRadius),
          child: Divider(
            color: AppColors.secondaryColor.withOpacity(0.3),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: AppConstants.baseBorderRadius),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Setting Work",
                style: AppTypography.poppinsSemiBold.copyWith(
                  color: AppColors.secondaryColor,
                  fontSize: 18,
                ),
              ),
              SvgPicture.asset(
                AppImages.arrowDown,
                colorFilter: const ColorFilter.mode(
                  AppColors.primaryColor,
                  BlendMode.srcIn,
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: AppConstants.baseBorderRadius),
          child: Row(
            children: [
              Text(
                AppStrings.overTimeText,
                style: AppTypography.poppinsMedium.copyWith(color: AppColors.secondaryColor, fontSize: 14),
              ),
              const Spacer(),
              Text(
                "200/Hr",
                style: AppTypography.poppinsMedium.copyWith(color: AppColors.secondaryColor, fontSize: 14),
              ),
              const Spacer(
                flex: 2,
              ),
              Text(
                "₹ 560",
                style: AppTypography.poppinsMedium.copyWith(color: AppColors.secondaryColor, fontSize: 14),
              )
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: AppConstants.baseBorderRadius),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Settings Work',
                style: AppTypography.poppinsMedium.copyWith(color: AppColors.secondaryColor, fontSize: 14),
              ),
              Text(
                "₹ 48",
                style: AppTypography.poppinsMedium.copyWith(color: AppColors.secondaryColor, fontSize: 14),
              )
            ],
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              AppStrings.totalText,
              style: AppTypography.poppinsSemiBold.copyWith(color: AppColors.secondaryColor, fontSize: 18),
            ),
            Text(
              "₹ 4815",
              style: AppTypography.poppinsSemiBold.copyWith(color: AppColors.secondaryColor, fontSize: 18),
            )
          ],
        ),
        Padding(
          padding: const EdgeInsets.only(top: AppConstants.baseBorderRadius),
          child: Divider(
            color: AppColors.secondaryColor.withOpacity(0.3),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: AppConstants.baseBorderRadius),
          child: FooterButton(
              label: "Show Settlement QR",
              onTap: () {
                //
              }),
        ),
        Padding(
          padding: const EdgeInsets.only(top: AppConstants.baseBorderRadius),
          child: Divider(
            color: AppColors.secondaryColor.withOpacity(0.3),
          ),
        )
      ],
    );
  }

  Widget ongoing() {
    final kSize = MediaQuery.of(context).size;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: AppConstants.baseBorderRadius),
          child: Text(
            "Setting Work",
            style: AppTypography.poppinsSemiBold.copyWith(
              color: AppColors.secondaryColor,
              fontSize: 18,
            ),
          ),
        ),
        Column(
          children: List.generate(
              2,
              (index) => Container(
                    decoration: BoxDecoration(
                      color: AppColors.accentColor,
                      borderRadius: BorderRadiusDirectional.circular(AppConstants.baseTextFieldBorderRdious),
                    ),
                    margin: const EdgeInsets.only(bottom: AppConstants.baseTextFieldBorderRdious),
                    padding: const EdgeInsets.all(AppConstants.marginSpace),
                    width: kSize.width,
                    child: Row(
                      children: [
                        Text(
                          "Serve Table",
                          style: AppTypography.poppinsRegular
                              .copyWith(color: AppColors.secondaryColor, fontSize: 14),
                        ),
                        const Spacer(
                          flex: 3,
                        ),
                        Text(
                          "1",
                          style: AppTypography.poppinsRegular
                              .copyWith(color: AppColors.secondaryColor, fontSize: 14),
                        ),
                        const Spacer(),
                        Text(
                          "₹ 2484",
                          style: AppTypography.poppinsRegular
                              .copyWith(color: AppColors.secondaryColor, fontSize: 14),
                        )
                      ],
                    ),
                  )),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: AppConstants.baseBorderRadius),
          child: Divider(
            color: AppColors.secondaryColor.withOpacity(0.3),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: AppConstants.baseBorderRadius),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Setting Work",
                style: AppTypography.poppinsSemiBold.copyWith(
                  color: AppColors.secondaryColor,
                  fontSize: 18,
                ),
              ),
              SvgPicture.asset(
                AppImages.arrowDown,
                colorFilter: const ColorFilter.mode(
                  AppColors.primaryColor,
                  BlendMode.srcIn,
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: AppConstants.baseBorderRadius),
          child: Row(
            children: [
              Text(
                AppStrings.overTimeText,
                style: AppTypography.poppinsMedium.copyWith(color: AppColors.secondaryColor, fontSize: 14),
              ),
              const Spacer(),
              Text(
                "200/Hr",
                style: AppTypography.poppinsMedium.copyWith(color: AppColors.secondaryColor, fontSize: 14),
              ),
              const Spacer(
                flex: 2,
              ),
              Text(
                "₹ 560",
                style: AppTypography.poppinsMedium.copyWith(color: AppColors.secondaryColor, fontSize: 14),
              )
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: AppConstants.baseBorderRadius),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Settings Work',
                style: AppTypography.poppinsMedium.copyWith(color: AppColors.secondaryColor, fontSize: 14),
              ),
              Text(
                "₹ 48",
                style: AppTypography.poppinsMedium.copyWith(color: AppColors.secondaryColor, fontSize: 14),
              )
            ],
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              AppStrings.totalText,
              style: AppTypography.poppinsSemiBold.copyWith(color: AppColors.secondaryColor, fontSize: 18),
            ),
            Text(
              "₹ 4815",
              style: AppTypography.poppinsSemiBold.copyWith(color: AppColors.secondaryColor, fontSize: 18),
            )
          ],
        ),
        Padding(
          padding: const EdgeInsets.only(top: AppConstants.baseBorderRadius),
          child: Divider(
            color: AppColors.secondaryColor.withOpacity(0.3),
          ),
        )
      ],
    );
  }

  Widget acceptedSlot() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: AppConstants.basePadding),
          child: Text(
            "Contact",
            style: AppTypography.poppinsMedium.copyWith(
              fontSize: 18,
              color: AppColors.secondaryColor,
            ),
          ),
        ),
        Column(
          children: List.generate(
              2,
              (index) => Container(
                    margin: const EdgeInsets.only(bottom: AppConstants.basePadding),
                    decoration: BoxDecoration(
                        color: AppColors.secondaryColor.withOpacity(0.05),
                        borderRadius: BorderRadius.circular(AppConstants.basePadding)),
                    padding: const EdgeInsets.symmetric(
                        horizontal: AppConstants.basePadding, vertical: AppConstants.marginSpace),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const CircleAvatar(),
                        const Spacer(),
                        Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                          Text(
                            index == 0 ? "Sandeep" : "Suhail",
                            style: AppTypography.poppinsMedium.copyWith(
                              fontSize: 14,
                              color: AppColors.secondaryColor,
                            ),
                          ),
                          Text(
                            index == 0 ? "Captain" : "Supervisor",
                            style: AppTypography.poppinsMedium.copyWith(
                              fontSize: 14,
                              color: AppColors.secondaryColor.withOpacity(0.6),
                            ),
                          )
                        ]),
                        const Spacer(
                          flex: 4,
                        ),
                        IconButton(
                            iconSize: 24,
                            onPressed: () {
                              //
                            },
                            icon: SvgPicture.asset(
                              AppImages.call,
                              colorFilter: const ColorFilter.mode(AppColors.primaryColor, BlendMode.srcIn),
                            )),
                        IconButton(
                            iconSize: 24,
                            onPressed: () {
                              //
                            },
                            icon: SvgPicture.asset(
                              AppImages.mail,
                              colorFilter: const ColorFilter.mode(AppColors.primaryColor, BlendMode.srcIn),
                            ))
                      ],
                    ),
                  )),
        ),
        // Padding(
        //   padding: const EdgeInsets.only(top: AppConstants.baseBorderRadius),
        //   child: Divider(
        //     color: AppColors.secondaryColor.withOpacity(0.2),
        //   ),
        // ),
      ],
    );
  }

  Widget openEvent() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 8),
          child: Text(
            "Slots",
            style: AppTypography.poppinsMedium.copyWith(
              fontSize: 18,
              color: AppColors.secondaryColor,
            ),
          ),
        ),
        Text(
          "2 slots available",
          style: AppTypography.poppinsRegular.copyWith(
            fontSize: 18,
            color: AppColors.statusSuccess,
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: AppConstants.baseBorderRadius),
          child: Divider(
            color: AppColors.secondaryColor.withOpacity(0.2),
          ),
        ),
      ],
    );
  }

  Widget locationTile(Size kSize, BuildContext context) {
    return Container(
      clipBehavior: Clip.antiAlias,
      height: kSize.height * 0.2,
      width: kSize.width,
      decoration: BoxDecoration(
          color: AppColors.primaryColor,
          borderRadius: BorderRadius.circular(
            AppConstants.basePadding,
          )),
      child: Image.asset(
        AppImages.locationDummy,
        fit: BoxFit.cover,
      ),
    );
  }

  Widget eventImage(Size kSize, BuildContext context, String eventStatus) {
    return Stack(
      clipBehavior: Clip.antiAlias,
      children: [
        Container(
          clipBehavior: Clip.antiAlias,
          height: kSize.height * 0.2,
          width: kSize.width,
          decoration: BoxDecoration(
              color: AppColors.primaryColor,
              borderRadius: BorderRadius.circular(
                AppConstants.basePadding,
              )),
          child: Image.network(
            "https://upload.wikimedia.org/wikipedia/commons/5/58/TRUE_ICON_HALL.jpg",
            fit: BoxFit.cover,
          ),
        ),
        if (eventStatus.isNotEmpty)
          Container(
            margin: EdgeInsets.only(top: kSize.height * 0.013, left: kSize.height * 0.016),
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
            decoration: BoxDecoration(
              border: Border.all(color: AppColors.secondaryColor.withOpacity(0.4)),
              color: getEventStatusColor(eventStatus),
              borderRadius: BorderRadius.circular(AppConstants.basePadding),
            ),
            child: Text(
              getEventStatus(eventStatus),
              style: AppTypography.poppinsMedium.copyWith(
                fontSize: 12,
                color: AppColors.secondaryColor,
              ),
            ),
          )
      ],
    );
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
        return "Open";
      case "Upcoming - Filled":
        return "Filled";
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

  AppBar appBar(BuildContext context, Size kSize) {
    return AppBar(
      elevation: 0,
      leading: const CustomBackButton(),
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      centerTitle: true,
      title: Text(
        "EV #123",
        style: AppTypography.poppinsSemiBold.copyWith(
          color: AppColors.secondaryColor,
          fontSize: 24,
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
