import 'dart:convert';
import 'dart:developer';

import 'package:evantez/app/app.dart';
import 'package:evantez/src/controller/auth/auth_controller.dart';
import 'package:evantez/src/controller/events/events_controller.dart';
import 'package:evantez/src/controller/resources/employee/employee_controller.dart';
import 'package:evantez/src/model/core/models/employee/assing_event_employee.dart';
import 'package:evantez/src/serializer/models/employee/employee_list_response.dart';
import 'package:evantez/src/view/core//constants/app_images.dart';
import 'package:evantez/src/view/core//constants/constants.dart';
import 'package:evantez/src/view/core//themes/colors.dart';
import 'package:evantez/src/view/core//themes/typography.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

import '../../../../../core/constants/app_strings.dart';
import '../../../../../core/widgets/custom_textfield.dart';

class AddEmployeeSheet {
  BuildContext parentContext;
  AddEmployeeSheet(this.parentContext);

  Future<void> show() async {
    await showModalBottomSheet(
        isDismissible: false,
        context: parentContext,
        backgroundColor: AppColors.accentDark,
        isScrollControlled: true,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(AppConstants.basePadding),
                topRight: Radius.circular(AppConstants.basePadding))),
        builder: (context) {
          return const AddingEmployeeSheet();
        });
  }
}

class AddingEmployeeSheet extends StatefulWidget {
  const AddingEmployeeSheet({super.key});

  @override
  State<AddingEmployeeSheet> createState() => _AddingEmployeeSheetState();
}

class _AddingEmployeeSheetState extends State<AddingEmployeeSheet> {
  List<EventAssignEmployee> empList = [];
  final ValueNotifier<List<String>> selectedEmpList = ValueNotifier<List<String>>([]);

  @override
  Widget build(BuildContext context) {
    final eventController = context.watch<EventController>();
    final authContorller = context.watch<AuthController>();
    final employeeController = context.watch<EmployeesController>();
    final kSize = MediaQuery.of(context).size;
    return Padding(
        padding: EdgeInsets.fromLTRB(
            AppConstants.baseBorderRadius, kSize.height * 0.032, AppConstants.baseBorderRadius, 0),
        child: ValueListenableBuilder(
          valueListenable: selectedEmpList,
          builder: (context, value, child) {
            return Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  children: [
                    const Spacer(flex: 2),
                    Text(
                      'Add Employee',
                      style: AppTypography.poppinsSemiBold.copyWith(
                        fontSize: 18,
                        color: AppColors.secondaryColor,
                      ),
                    ),
                    const Spacer(),
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Text(AppStrings.closeText,
                          style: AppTypography.poppinsMedium.copyWith(
                            color: AppColors.secondaryColor.withOpacity(0.4),
                          )),
                    )
                  ],
                ),
                SizedBox(
                  height: kSize.height * 0.024,
                ),
                searchField(context, kSize),
                SizedBox(
                  height: kSize.height * 0.024,
                ),
                SizedBox(
                  width: kSize.width,
                  child: Wrap(
                    spacing: 8.0,
                    runSpacing: 8.0,
                    crossAxisAlignment: WrapCrossAlignment.start,
                    children: List.generate(
                      empList.length,
                      (index) {
                        selectedEmpList.value.add(employeeController.employeeLists
                            .firstWhere((e) => e.id == empList[index].employee)
                            .employeeName!);
                        return selecteEmployeeTile(kSize, selectedEmpList.value[index]);
                      },
                    ),
                  ),
                ),
                SizedBox(
                  height: kSize.height * 0.024,
                ),
                SizedBox(
                  height: kSize.height * 0.5,
                  child: Scrollbar(
                    interactive: true,
                    thumbVisibility: true,
                    trackVisibility: true,
                    child: ListView.builder(
                        itemCount: employeeController.employeeLists.length,
                        itemBuilder: (context, index) {
                          return InkWell(
                              highlightColor: AppColors.transparent,
                              splashColor: AppColors.transparent,
                              onTap: () {
                                // if (eventController.addedEmployees.isEmpty) {
                                EventAssignEmployee assignedEmp = EventAssignEmployee(
                                    employeeId: eventController.employeeList[index].id,
                                    eventSite: eventController.eventModel!.id,
                                    isCaptain: false,
                                    employee: eventController.employeeList[index]);
                                eventController
                                    .addEmployee(token: authContorller.accesToken!, assignedEmp: assignedEmp)
                                    .then((value) async {
                                  if (value != null) {
                                    // setState(() {

                                    /* EventAssignEmployee emp =
                                        EventAssignEmployee.fromJson(json.decode(value));
                                    eventController.addedEmployees.add(emp);
                                    log("${eventController.addedEmployees.length}");
                                    if (!empList.contains(assignedEmp)) {
                                      empList.add(assignedEmp);
                                    } */
                                    // });
                                  }
                                  await eventController
                                      .getEventDetail(
                                          token: authContorller.accesToken!,
                                          eventId: eventController.eventModel!.id!)
                                      .then((value) {
                                    Navigator.pop(context);
                                  });
                                });
                                /* } else {
                                  EventAssignEmployee assignedEmp = EventAssignEmployee(
                                      employee: employeeController.employeeLists[index].id,
                                      eventSite: eventController.eventModel!.id,
                                      isCaptain: false);
                                  for (var addEmp in eventController.addedEmployees) {
                                    if (addEmp.employee != assignedEmp.employee) {
                                      eventController
                                          .addEmployee(
                                              token: authContorller.accesToken!, assignedEmp: assignedEmp)
                                          .then((value) async {
                                        if (value != null) {
                                          // setState(() {
                                          if (!empList.contains(assignedEmp)) {
                                            empList.add(assignedEmp);
                                          }
                                          // });
                                        }
                                        await eventController
                                            .getEventDetail(
                                                token: authContorller.accesToken!,
                                                eventId: eventController.eventModel!.id!)
                                            .then((value) {
                                          Navigator.pop(context);
                                        });
                                      });
                                    } else {
                                      Navigator.pop(context);
                                      rootScaffoldMessengerKey.currentState!.showSnackBar(const SnackBar(
                                        content: Text("Employee Already Added!"),
                                        backgroundColor: AppColors.statusCritical,
                                      ));
                                    }
                                  }
                                } */
                              },
                              child: employeeTile(
                                  kSize, employeeController.employeeLists[index], employeeController));
                        }),
                  ),
                ),
              ],
            );
          },
        ));
  }
}

Widget employeeTile(Size kSize, EmployeeListResponse emp, EmployeesController controller) {
  String employeeType = controller.employeeTypes.firstWhere((e) => e.id == emp.employeeType).name!;
  return Container(
    margin: const EdgeInsets.only(bottom: 8, right: AppConstants.marginSpace),
    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
    decoration: BoxDecoration(
        color: AppColors.secondaryColor.withOpacity(0.1), borderRadius: BorderRadius.circular(6)),
    child: RichText(
        text: TextSpan(
            text: "${emp.employeeName}  ",
            style: AppTypography.poppinsRegular.copyWith(
              fontSize: 16,
              color: AppColors.secondaryColor,
            ),
            children: [
          TextSpan(
              text: employeeType,
              style: AppTypography.poppinsRegular.copyWith(
                  fontSize: 16,
                  color: AppColors.secondaryColor.withOpacity(
                    0.4,
                  )))
        ])),
  );
}

Widget selecteEmployeeTile(Size kSize, String emp) {
  return Container(
    decoration: BoxDecoration(
        color: AppColors.primaryColor,
        borderRadius: BorderRadius.circular(
          AppConstants.basePadding,
        )),
    padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 2.0),
    child: Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          emp,
          style: AppTypography.poppinsRegular.copyWith(
            fontSize: 14,
            color: AppColors.secondaryColor,
          ),
        ),
        InkWell(
          highlightColor: AppColors.transparent,
          splashColor: AppColors.transparent,
          onTap: () {},
          child: Icon(
            Icons.close_rounded,
            size: kSize.height * 0.018,
          ),
        )
      ],
    ),
  );
}

Widget searchField(BuildContext context, Size kSize) {
  return CustomTextField(
    text: '',
    hintText: AppStrings.searchText,
    suffixIcon: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 10.0),
      child: SvgPicture.asset(
        AppImages.search,
        colorFilter: const ColorFilter.mode(AppColors.primaryColor, BlendMode.srcIn),
      ),
    ),
  );
}
