import 'dart:developer';

import 'package:evantez/app/router/router_constant.dart';
import 'package:evantez/src/controller/auth/auth_controller.dart';
import 'package:evantez/src/controller/events/events_controller.dart';
import 'package:evantez/src/controller/resources/employee/employee_controller.dart';
import 'package:evantez/src/view/core//constants/constants.dart';
import 'package:evantez/src/view/core//themes/colors.dart';
import 'package:evantez/src/view/core//themes/typography.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

import '../../../../../core/constants/app_images.dart';

class EventFilledSlot extends StatelessWidget {
  final String eventStatus;

  const EventFilledSlot({super.key, required this.eventStatus});

  // final ValueNotifier<int> selectedCaptain = ValueNotifier<int>(-1);

  @override
  Widget build(BuildContext context) {
    final authController = context.watch<AuthController>();
    final employeeController = context.watch<EmployeesController>();
    final eventController = context.watch<EventController>();
    final kSize = MediaQuery.of(context).size;
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            getTitle(eventStatus),
            style: AppTypography.poppinsMedium.copyWith(
              color: AppColors.secondaryColor,
              fontSize: 18,
            ),
          ),
          SizedBox(
            height: kSize.height * 0.032,
            width: kSize.height * 0.032,
            child: SvgPicture.asset(
              AppImages.arrowDown,
              colorFilter: const ColorFilter.mode(
                AppColors.primaryColor,
                BlendMode.srcIn,
              ),
              fit: BoxFit.cover,
            ),
          )
        ],
      ),
      Column(
        children: List.generate(
            eventController.eventModel!.eventSiteEmployeeRequirement!.length,
            (index) => Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          eventController
                              .eventModel!.eventSiteEmployeeRequirement![index].employeeType!.name!,
                          // 'A Boy',
                          style: AppTypography.poppinsMedium.copyWith(
                            color: AppColors.secondaryColor,
                            fontSize: 14,
                          ),
                        ),
                        Text(
                          '${eventController.eventModel!.eventSiteEmployeeRequirement![index].assignedEmployeeList!.length}/${eventController.eventModel!.eventSiteEmployeeRequirement![index].requirementCount}',
                          style: AppTypography.poppinsRegular.copyWith(
                            color: AppColors.secondaryColor.withOpacity(0.6),
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: kSize.height * 0.008,
                    ),
                    Column(
                      children: List.generate(
                          eventController.eventModel!.eventSiteEmployeeRequirement![index]
                              .assignedEmployeeList!.length, (empIndex) {
                        if (eventController.eventModel!.eventSiteEmployeeRequirement![index]
                            .assignedEmployeeList![empIndex].isCaptain!) {
                          log(" Captain >> ${eventController.eventModel!.eventSiteEmployeeRequirement![index].assignedEmployeeList![empIndex].employee!.toJson()}");
                        }

                        return Container(
                          clipBehavior: Clip.antiAlias,
                          padding: EdgeInsets.symmetric(
                            horizontal: kSize.height * 0.01,
                            vertical: kSize.height * 0.01,
                          ),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(AppConstants.basePadding),
                              border: Border.all(color: AppColors.accentColor),
                              color: AppColors.accentDark),
                          margin: EdgeInsets.only(bottom: kSize.height * 0.016),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              SizedBox(
                                width: kSize.width * 0.04,
                                child: PopupMenuButton<String>(
                                  initialValue: 'make captain',
                                  // Callback that sets the selected popup menu item.
                                  onSelected: (item) async {
                                    if (item == 'see profile') {
                                      Navigator.pushNamed(context, RouterConstants.empPerformanceRoute,
                                          arguments: eventStatus);
                                    }
                                    if (item == 'captain') {
                                      await eventController.makeEmployeeCaptain(
                                          eventController.addedEmployees[empIndex],
                                          authController.accesToken!);
                                    }

                                    if (item == "delete") {
                                      await eventController.deleteAssignedEmployee(
                                          eventController.addedEmployees[empIndex].employeeId!,
                                          authController.accesToken!);
                                    }
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

                                  itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
                                    PopupMenuItem<String>(
                                      onTap: () {
                                        // selectedCaptain.value = index;
                                      },
                                      padding: EdgeInsets.symmetric(
                                        horizontal: kSize.width * 0.05,
                                      ),
                                      value: "captain",
                                      child: Text(
                                        'Make Captain',
                                        textAlign: TextAlign.start,
                                        style: AppTypography.poppinsMedium.copyWith(),
                                      ),
                                    ),
                                    PopupMenuItem<String>(
                                      padding: EdgeInsets.symmetric(
                                        horizontal: kSize.width * 0.05,
                                      ),
                                      value: "see profile",
                                      child: Text(
                                        'See Profile',
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
                              SizedBox(
                                width: kSize.width * 0.012,
                              ),
                              // const Spacer(),
                              Container(
                                clipBehavior: Clip.antiAlias,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8.0),
                                ),
                                height: kSize.height * 0.06,
                                width: kSize.height * 0.06,
                                child: const Placeholder(),
                              ),
                              SizedBox(
                                width: kSize.width * 0.012,
                              ),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      eventController.eventModel!.eventSiteEmployeeRequirement![index]
                                          .assignedEmployeeList![empIndex].employee!.employeeName!,
                                      overflow: TextOverflow.ellipsis,
                                      style: AppTypography.poppinsMedium.copyWith(
                                        fontSize: 14,
                                      ),
                                    ),
                                    SizedBox(
                                      height: kSize.height * 0.004,
                                    ),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          eventController.eventModel!.eventSiteEmployeeRequirement![index]
                                              .employeeType!.name!,
                                          overflow: TextOverflow.ellipsis,
                                          style: AppTypography.poppinsRegular.copyWith(
                                            fontSize: 12,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                      margin: EdgeInsets.only(
                                        right: kSize.width * 0.02,
                                      ),
                                      height: kSize.height * 0.01,
                                      width: kSize.height * 0.01,
                                      decoration: BoxDecoration(
                                        color: eventController
                                                .eventModel!
                                                .eventSiteEmployeeRequirement![index]
                                                .assignedEmployeeList![empIndex]
                                                .employee!
                                                .isActive!
                                            ? AppColors.statusSuccess
                                            : AppColors.statusCritical,
                                        shape: BoxShape.circle,
                                      ),
                                    ),
                                    SizedBox(
                                      height: kSize.height * 0.016,
                                    ),
                                    if (eventController.eventModel!.eventSiteEmployeeRequirement![index]
                                        .assignedEmployeeList![empIndex].isCaptain!)
                                      IntrinsicWidth(
                                        child: Container(
                                          padding: const EdgeInsets.symmetric(
                                            horizontal: 8,
                                            vertical: 2,
                                          ),
                                          decoration: BoxDecoration(
                                            color: AppColors.statusSuccess,
                                            border:
                                                Border.all(color: AppColors.secondaryColor.withOpacity(0.4)),
                                            borderRadius: BorderRadius.circular(kSize.height * 0.03),
                                          ),
                                          child: Text("Captain",
                                              style: AppTypography.poppinsRegular.copyWith(fontSize: 12)),
                                        ),
                                      )
                                  ],
                                ),
                              ),
                            ],
                          ),
                        );
                      }),
                    ),
                    SizedBox(
                      height: kSize.height * 0.016,
                    ),
                  ],
                )),
      )
    ]);
  }

  String getTitle(String eventStatus) {
    switch (eventStatus) {
      case "Upcoming - Hold" || "Upcoming - Open" || "Upcoming - Filled":
        return 'Slots';
      case "Ongoing" || "Settlement" || "Completed":
        return "Attendance";
      default:
        return '';
    }
  }
}
