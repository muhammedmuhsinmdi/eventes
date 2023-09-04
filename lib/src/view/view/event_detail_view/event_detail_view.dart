import 'dart:developer';

import 'package:evantez/src/view/core//constants/constants.dart';
import 'package:evantez/src/view/core//widgets/custom_back_btn.dart';
import 'package:evantez/src/view/core//widgets/custom_date_picker.dart';
import 'package:evantez/src/view/core//widgets/custom_dropdown_search.dart';
import 'package:evantez/src/view/core//widgets/footer_button.dart';
import 'package:evantez/src/view/core/widgets/multi_selection_dropdown.dart';
import 'package:evantez/src/view/view/event_detail_view/widgets/add_employee_bottom_sheet.dart';
import 'package:evantez/src/view/view/event_detail_view/widgets/event_completed_slot.dart';
import 'package:evantez/src/view/view/event_detail_view/widgets/event_filled_slot.dart';
import 'package:evantez/src/view/view/event_detail_view/widgets/event_ongoing_slot.dart';
import 'package:evantez/src/view/view/event_detail_view/widgets/event_open_slot.dart';
import 'package:evantez/src/view/view/event_detail_view/widgets/event_settlement_slot.dart';
import 'package:evantez/src/view/view/event_detail_view/widgets/urgent_emp_sheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../core/constants/app_images.dart';
import '../../core/constants/app_strings.dart';
import '../../core/themes/colors.dart';
import '../../core/themes/typography.dart';
import '../../core/widgets/custom_textfield.dart';

class EventDetailView extends StatefulWidget {
  const EventDetailView({super.key});

  @override
  State<EventDetailView> createState() => _EventDetailViewState();
}

class _EventDetailViewState extends State<EventDetailView> {
  final ValueNotifier<String> selectedeventStatus = ValueNotifier<String>('');

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
                        SizedBox(height: kSize.height * 0.024),
                        Divider(
                          color: AppColors.secondaryColor.withOpacity(0.2),
                        ),
                        SizedBox(height: kSize.height * 0.024),
                        CustomDropdownSearch(
                          label: AppStrings.changeEventStatusTo,
                          textAlignCenter: true,
                          hintText: 'Select Event Status',
                          items: const [
                            "Upcoming - Hold",
                            "Upcoming - Open",
                            "Upcoming - Filled",
                            "Ongoing",
                            "Settlement",
                            "Completed",
                          ],
                          onChanged: (value) {
                            selectedeventStatus.value = value ?? '';
                          },
                        ),
                        SizedBox(height: kSize.height * 0.024),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            CustomDatePicker(
                              controller: TextEditingController(text: "03 Nov, 2023"),
                              label: "Date",
                              type: 'Date',
                              onChanged: (value) {
                                log(value);
                              },
                            ),
                            CustomDatePicker(
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
                            controller: TextEditingController(text: '02:30PM-11:30 PM'),
                            label: "Actual Time",
                            type: 'Time',
                            onChanged: (value) {
                              log(value);
                            },
                          ),
                        },
                        SizedBox(height: kSize.height * 0.024),
                        Divider(
                          color: AppColors.secondaryColor.withOpacity(0.2),
                        ),
                        SizedBox(height: kSize.height * 0.024),
                        if (selectedeventStatus.value.isNotEmpty) ...{
                          selectSlotByStatus(selectedeventStatus.value),
                          // EventOpenSlot(eventStatus: selectedeventStatus.value),
                          SizedBox(height: kSize.height * 0.024),
                        },
                        if (selectedeventStatus.value == "Upcoming - Hold" ||
                            selectedeventStatus.value == "Upcoming - Open" ||
                            selectedeventStatus.value == "Upcoming - Filled") ...{
                          FooterButton(
                            fillColor: AppColors.transparent,
                            label: AppStrings.addEmployeeText,
                            onTap: () {
                              //
                              AddEmployeeSheet(context).show();
                            },
                          ),
                          SizedBox(height: kSize.height * 0.024),
                          Divider(
                            color: AppColors.secondaryColor.withOpacity(0.2),
                          ),
                          SizedBox(height: kSize.height * 0.024),
                        },
                        if (selectedeventStatus.value == "Ongoing") ...{
                          MultiSelectionDropDown(
                            isEmployeeAssign: true,
                            label: 'Setting Work',
                            items: const ["Set square Tables", 'Set stage'],
                            onSelectedEmp: (value) {
                              //
                            },
                          ),
                          SizedBox(height: kSize.height * 0.016),
                          FooterButton(
                            fillColor: AppColors.transparent,
                            label: 'Add +',
                            onTap: () {},
                          ),
                          SizedBox(height: kSize.height * 0.024),
                          Divider(
                            color: AppColors.secondaryColor.withOpacity(0.2),
                          ),
                          SizedBox(height: kSize.height * 0.024),
                          //
                        },
                        if (selectedeventStatus.value == "Ongoing" ||
                            selectedeventStatus.value == 'Settlement' ||
                            selectedeventStatus.value == 'Completed') ...{
                          Text(
                            AppStrings.overTimeText,
                            style: AppTypography.poppinsSemiBold.copyWith(
                              color: AppColors.secondaryColor,
                            ),
                          ),
                          SizedBox(
                            height: kSize.height * 0.016,
                          ),
                          overTimeDetail(kSize),
                          SizedBox(height: kSize.height * 0.024),
                          Divider(
                            color: AppColors.secondaryColor.withOpacity(0.2),
                          ),
                          SizedBox(height: kSize.height * 0.024),
                        },
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
                        SizedBox(height: kSize.height * 0.024),
                        Divider(
                          color: AppColors.secondaryColor.withOpacity(0.2),
                        ),
                        if (selectedeventStatus.value == "Ongoing") ...{
                          SizedBox(height: kSize.height * 0.024),
                          urgentEmpNeed(context),
                          SizedBox(height: kSize.height * 0.1),
                        }
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

  Widget selectSlotByStatus(String status) {
    switch (status) {
      case "Upcoming - Hold":
        return const SizedBox();
      case "Upcoming - Open":
        return EventOpenSlot(eventStatus: status);
      case "Upcoming - Filled":
        return EventFilledSlot(eventStatus: status);
      case "Ongoing":
        return EventOngoingSlot(eventStatus: status);
      case "Settlement":
        return EventSettleMentSlot(eventStatus: status);
      case "Completed":
        return EventCompletedSlot(eventStatus: status);
      default:
        return const SizedBox();
      // return AppColors.transparent;
    }
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
        style: AppTypography.poppinsSemiBold.copyWith(),
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
