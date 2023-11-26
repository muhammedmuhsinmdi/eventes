import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:evantez/app/router/router_constant.dart';
import 'package:evantez/src/controller/auth/auth_controller.dart';
import 'package:evantez/src/controller/events/add_event_controller.dart';
import 'package:evantez/src/controller/events/events_controller.dart';
import 'package:evantez/src/controller/resources/employee/employee_controller.dart';
import 'package:evantez/src/view/core//constants/constants.dart';
import 'package:evantez/src/view/core//widgets/custom_back_btn.dart';
import 'package:evantez/src/view/core//widgets/custom_date_picker.dart';
import 'package:evantez/src/view/core//widgets/custom_dropdown_search.dart';
import 'package:evantez/src/view/core//widgets/footer_button.dart';
import 'package:evantez/src/view/core/widgets/multi_selection_dropdown.dart';
import 'package:evantez/src/view/view/admin/dashboard/event_detail_view/widgets/add_employee_bottom_sheet.dart';
import 'package:evantez/src/view/view/admin/dashboard/event_detail_view/widgets/event_completed_slot.dart';
import 'package:evantez/src/view/view/admin/dashboard/event_detail_view/widgets/event_filled_slot.dart';
import 'package:evantez/src/view/view/admin/dashboard/event_detail_view/widgets/event_ongoing_slot.dart';
import 'package:evantez/src/view/view/admin/dashboard/event_detail_view/widgets/event_open_slot.dart';
import 'package:evantez/src/view/view/admin/dashboard/event_detail_view/widgets/event_settlement_slot.dart';
import 'package:evantez/src/view/view/admin/dashboard/event_detail_view/widgets/urgent_emp_sheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

import '../../../../core/constants/app_images.dart';
import '../../../../core/constants/app_strings.dart';
import '../../../../core/themes/colors.dart';
import '../../../../core/themes/typography.dart';
import '../../../../core/widgets/custom_textfield.dart';

class EventDetailView extends StatefulWidget {
  const EventDetailView({
    super.key,
  });

  @override
  State<EventDetailView> createState() => _EventDetailViewState();
}

class _EventDetailViewState extends State<EventDetailView> {
  /* @override
  void initState() {
    controller.selectedeventStatus.value = widget.eventModel.status!;
    log("${widget.eventModel.toJson()}");
    super.initState();
  } */

  @override
  Widget build(BuildContext context) {
    final employeeController = context.watch<EmployeesController>();
    final authController = context.watch<AuthController>();
    final controller = context.watch<EventController>();
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
                  valueListenable: controller.selectedeventStatus,
                  builder: (context, value, child) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: kSize.height * 0.016),
                        eventImage(
                            kSize,
                            context,
                            controller.selectedeventStatus.value,
                            controller.eventModel!.venue!.image ??
                                '' /* controller.eventsDetail?.image ?? "" */),
                        SizedBox(height: kSize.height * 0.024),
                        Text(
                          controller.eventModel!.venue!.name ?? '',
                          // controller.eventsDetail?.name ?? '',
                          style: AppTypography.poppinsMedium.copyWith(
                            fontSize: 24,
                            color: AppColors.primaryColor,
                          ),
                        ),
                        SizedBox(
                          height: kSize.height * 0.01,
                        ),
                        Text(
                          controller.eventModel!.eventType!.name!,
                          // "Marriage Function",
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
                          selectedItem: controller.selectedeventStatus.value,
                          hintText: 'Select Event Status',
                          items: const [
                            "Upcoming - Hold",
                            "Upcoming - Open",
                            "Upcoming - Filled",
                            "Ongoing",
                            "Settlement",
                            "Completed",
                          ],
                          onChanged: (dropdownValue) async {
                            // controller.selectedeventStatus.value = value ?? '';
                            controller.eventModel!.status = controller.getEventStatus(dropdownValue!);
                            log(controller.eventModel!.status!);
                            await controller
                                .updateEvent(
                                    id: controller.eventModel!.id!,
                                    eventSite: controller.eventModel!,
                                    token: authController.accesToken!)
                                .then((value) {
                              log("$value");
                              if (value) {
                                controller.selectedeventStatus.value = dropdownValue;
                              }
                            });
                          },
                        ),
                        SizedBox(height: kSize.height * 0.024),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            CustomDatePicker(
                              readOnly: true,

                              controller:
                                  controller.scheduledDate, //  TextEditingController(text: "03 Nov, 2023"),
                              label: "Date",
                              type: 'Date',
                              onChanged: (value) {
                                log(value);
                              },
                            ),
                            CustomDatePicker(
                              readOnly: true,
                              controller:
                                  controller.scheduledTime, //TextEditingController(text: '02:30PM-11:30 PM'),
                              label: "Time",
                              type: 'Time',
                              onChanged: (value) {
                                log(value);
                              },
                            ),
                          ],
                        ),
                        if (controller.selectedeventStatus.value == "Completed") ...{
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
                        SizedBox(height: kSize.height * 0.024),
                        Divider(
                          color: AppColors.secondaryColor.withOpacity(0.2),
                        ),
                        SizedBox(height: kSize.height * 0.024),
                        if (controller.eventModel!.status!.isNotEmpty) ...{
                          selectSlotByStatus(controller.eventModel!.status!, controller),
                          // EventOpenSlot(eventStatus: controller.selectedeventStatus.value),
                          SizedBox(height: kSize.height * 0.024),
                        },
                        if (controller.selectedeventStatus.value == "Upcoming - Hold" ||
                            controller.selectedeventStatus.value == "Upcoming - Open" ||
                            controller.selectedeventStatus.value == "Upcoming - Filled") ...{
                          FooterButton(
                            fillColor: AppColors.transparent,
                            label: AppStrings.addEmployeeText,
                            onTap: () {
                              /*  controller.addEmployee(token: authController.accesToken!).then((value) {
                                log('added');
                              });
                              // */
                              employeeController.employeeTypesData(token: authController.accesToken!);
                              employeeController
                                  .employeeList(token: authController.accesToken!)
                                  .then((value) {
                                AddEmployeeSheet(context).show();
                              });
                            },
                          ),
                          SizedBox(height: kSize.height * 0.024),
                          Divider(
                            color: AppColors.secondaryColor.withOpacity(0.2),
                          ),
                          SizedBox(height: kSize.height * 0.024),
                        },
                        if (controller.selectedeventStatus.value == "Ongoing") ...{
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
                        if (controller.selectedeventStatus.value == "Ongoing" ||
                            controller.selectedeventStatus.value == 'Settlement' ||
                            controller.selectedeventStatus.value == 'Completed') ...{
                          Text(
                            AppStrings.overTimeText,
                            style: AppTypography.poppinsSemiBold.copyWith(
                              color: AppColors.secondaryColor,
                            ),
                          ),
                          SizedBox(
                            height: kSize.height * 0.016,
                          ),
                          overTimeDetail(kSize, controller),
                          SizedBox(height: kSize.height * 0.024),
                          Divider(
                            color: AppColors.secondaryColor.withOpacity(0.2),
                          ),
                          SizedBox(height: kSize.height * 0.024),
                        },
                        if (controller.eventModel!.notes!.isNotEmpty) ...{
                          Text(
                            AppStrings.additionalInfoText,
                            style: AppTypography.poppinsSemiBold.copyWith(
                              fontSize: 18,
                              color: AppColors.secondaryColor,
                            ),
                          ),
                          SizedBox(height: kSize.height * 0.01),
                          Text(
                            controller.eventModel!
                                .notes!, //"The conference is open to boys of all ages who are interested in event management as a career or hobby.",
                            style: AppTypography.poppinsRegular.copyWith(
                              fontSize: 16,
                              color: AppColors.secondaryColor.withOpacity(0.6),
                            ),
                          )
                        },
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
                        if (controller.selectedeventStatus.value == "Ongoing") ...{
                          SizedBox(height: kSize.height * 0.024),
                          urgentEmpNeed(context),
                          SizedBox(height: kSize.height * 0.1),
                        },
                        if (controller.selectedeventStatus.value == "Upcoming - Open")
                          InkWell(
                            onTap: () {
                              Navigator.pushNamed(context, RouterConstants.applystatus);
                            },
                            child: Container(
                              height: kSize.height * 0.05,
                              width: kSize.width,
                              decoration: BoxDecoration(
                                  color: AppColors.primaryColor,
                                  borderRadius: BorderRadius.circular(
                                    AppConstants.baseBorderRadius,
                                  )),
                              child: const Center(child: Text('Apply')),
                            ),
                          )
                      ],
                    );
                  }),
            ),
          ),
        ));
  }

  Widget overTimeDetail(Size kSize, EventController controller) {
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
            readOnly: controller.selectedeventStatus.value == "Settlement" ||
                    controller.selectedeventStatus.value == "Completed"
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
            readOnly: controller.selectedeventStatus.value == "Settlement" ||
                    controller.selectedeventStatus.value == "Completed"
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

  Widget selectSlotByStatus(String status, EventController controller) {
    switch (controller.selectedeventStatus.value) {
      case "Upcoming - Hold":
        return const SizedBox();
      case "Upcoming - Open":
        return EventOpenSlot(eventStatus: controller.selectedeventStatus.value);
      case "Upcoming - Filled":
        return EventFilledSlot(eventStatus: controller.selectedeventStatus.value);
      case "Ongoing":
        return EventOngoingSlot(eventStatus: controller.selectedeventStatus.value);
      case "Settlement":
        return EventSettleMentSlot(eventStatus: controller.selectedeventStatus.value);
      case "Completed":
        return EventCompletedSlot(eventStatus: controller.selectedeventStatus.value);
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

  Widget eventImage(Size kSize, BuildContext context, String eventStatus, String image) {
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
          child: CachedNetworkImage(
            imageUrl: image,
            errorWidget: (context, url, error) {
              return const SizedBox();
            },
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
    final employeeController = context.watch<EmployeesController>();
    final controller = context.watch<EventController>();
    final auth = context.watch<AuthController>();
    final addEventController = context.watch<AddEventController>();
    return AppBar(
      elevation: 0,
      leading: const CustomBackButton(),
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      centerTitle: true,
      title: Text(
        controller.eventModel!.code ?? '',
        style: AppTypography.poppinsSemiBold.copyWith(),
      ),
      actions: [
        IconButton(
            onPressed: () async {
              addEventController.clearData();
              await employeeController.employeeTypesData(token: auth.accesToken ?? '');
              addEventController.employeeTypes = employeeController.employeeTypes;
              await addEventController.getEventTypes(auth.accesToken!);
              await addEventController.getEventDetail(auth.accesToken!, controller.eventModel!.id!);
              if (context.mounted) {
                Navigator.pushNamed(context, RouterConstants.newEventRoute).then((value) {
                  controller.getEventDetail(token: auth.accesToken!, eventId: controller.eventModel!.id!);
                });
              }
            },
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
