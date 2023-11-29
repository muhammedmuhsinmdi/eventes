import 'dart:developer';

import 'package:evantez/src/controller/auth/auth_controller.dart';
import 'package:evantez/src/controller/events/events_controller.dart';
import 'package:evantez/src/controller/resources/employee/employee_controller.dart';
import 'package:evantez/src/view/core//constants/app_images.dart';
import 'package:evantez/src/view/core//themes/colors.dart';
import 'package:evantez/src/view/core//themes/typography.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

class EventOpenSlot extends StatefulWidget {
  final String eventStatus;
  const EventOpenSlot({super.key, required this.eventStatus});

  @override
  State<EventOpenSlot> createState() => _EventOpenSlotState();
}

class _EventOpenSlotState extends State<EventOpenSlot> {
  late AuthController authController;
  late EmployeesController employeeController;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      await employeeController.employeeList(token: authController.accesToken!);
      log("${employeeController.employeeLists.length}");
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    authController = context.watch<AuthController>();
    employeeController = context.watch<EmployeesController>();
    final eventController = context.watch<EventController>();
    final kSize = MediaQuery.of(context).size;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              getTitle(widget.eventStatus),
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
        SizedBox(
          height: kSize.height * 0.016,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: List.generate(
              eventController.eventModel!.eventSiteEmployeeRequirement!.length,
              (index) => Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        //'A Boy',
                        eventController.eventModel!.eventSiteEmployeeRequirement![index].employeeType!.name ??
                            '',
                        style: AppTypography.poppinsMedium.copyWith(
                          color: AppColors.secondaryColor,
                          fontSize: 14,
                        ),
                      ),
                      SizedBox(
                        height: kSize.height * 0.008,
                      ),
                      Wrap(
                        crossAxisAlignment: WrapCrossAlignment.start,
                        alignment: WrapAlignment.start,
                        runSpacing: 8,
                        spacing: 8,
                        children: List.generate(
                            eventController
                                .eventModel!.eventSiteEmployeeRequirement![index].requirementCount!,
                            (empIndex) => IntrinsicWidth(
                                    child: Container(
                                  height: kSize.height * 0.005,
                                  width: getCountWidth(eventController
                                      .eventModel!.eventSiteEmployeeRequirement![index].requirementCount!),
                                  decoration: BoxDecoration(
                                    color: eventController.getSlotColor(empIndex,
                                        eventController.eventModel!.eventSiteEmployeeRequirement![index]
                                            .assignedEmployeeList!.length),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                ))),
                      ),
                      SizedBox(
                        height: kSize.height * 0.016,
                      ),
                      Text(
                        '${eventController.eventModel!.eventSiteEmployeeRequirement![index].assignedEmployeeList!.length}/${eventController.eventModel!.eventSiteEmployeeRequirement![index].requirementCount!}',
                        style: AppTypography.poppinsRegular.copyWith(
                          color: AppColors.secondaryColor.withOpacity(0.6),
                          fontSize: 16,
                        ),
                      ),
                      SizedBox(
                        height: kSize.height * 0.016,
                      )
                    ],
                  )),
        )
      ],
    );
  }

  double getCountWidth(int itemCount) {
    if (itemCount <= 5) {
      return 66;
    } else if (itemCount <= 10) {
      return 33;
    } else if (itemCount <= 20) {
      return 22;
    } else if (itemCount <= 30) {
      return 11;
    } else {
      return 5;
    }
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
