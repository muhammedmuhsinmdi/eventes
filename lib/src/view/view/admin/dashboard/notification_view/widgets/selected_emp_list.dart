import 'dart:developer';

import 'package:evantez/src/controller/auth/auth_controller.dart';
import 'package:evantez/src/controller/resources/employee/employee_controller.dart';
import 'package:evantez/src/serializer/models/employee/employee_types_response.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../core/themes/colors.dart';
import '../../../../../core/themes/typography.dart';

class SelectEmpList extends StatefulWidget {
  final Function(List<EmployeesTypesList>) onSelectedList;
  const SelectEmpList({super.key, required this.onSelectedList});

  @override
  State<SelectEmpList> createState() => _SelectEmpListState();
}

class _SelectEmpListState extends State<SelectEmpList> {
  late EmployeesController employeesController;
  late AuthController authController;
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      // log("${AppPrefs.token}");
      employeesController.employeeTypesData(token: authController.accesToken!);
      log("${employeesController.employeeTypesList}");
    });
    super.initState();
  }

  List<EmployeesTypesList> selectedEmp = [];

  List<String> employeeList = [
    'A Boy',
    'B Boy',
    'C Boy',
    'Fresher Boy',
    'Head',
    'Captain',
    'Vice Captain',
    'Supervisor',
  ];

  @override
  Widget build(BuildContext context) {
    employeesController = context.watch<EmployeesController>();
    authController = context.watch<AuthController>();
    return Wrap(
      clipBehavior: Clip.antiAlias,
      spacing: 8,
      runSpacing: 8,
      children: List.generate(
          employeesController.employeeTypesList.length,
          (index) => InkWell(
                highlightColor: AppColors.transparent,
                splashColor: AppColors.transparent,
                onTap: () {
                  if (selectedEmp.contains(employeesController.employeeTypesList[index])) {
                    selectedEmp.remove(employeesController.employeeTypesList[index]);
                  } else {
                    selectedEmp.add(employeesController.employeeTypesList[index]);
                  }
                  log("$selectedEmp");
                  setState(() {});
                  // widget.onSelectedList(selectedEmp);
                },
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      color: selectedEmp.contains(employeesController.employeeTypesList[index])
                          ? AppColors.primaryColor
                          : AppColors.transparent,
                      border: Border.all(
                        color: AppColors.primaryColor,
                      )),
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                  child: Text(
                    employeesController.employeeTypesList[index].name!,
                    style:
                        AppTypography.poppinsRegular.copyWith(color: AppColors.secondaryColor, fontSize: 12),
                  ),
                ),
              )),
    );
  }
}
