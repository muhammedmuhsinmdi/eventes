import 'dart:developer';

import 'package:flutter/material.dart';

import '../../../../core/themes/colors.dart';
import '../../../../core/themes/typography.dart';

class SelectEmpList extends StatefulWidget {
  final Function(List<String>) onSelectedList;
  const SelectEmpList({super.key, required this.onSelectedList});

  @override
  State<SelectEmpList> createState() => _SelectEmpListState();
}

class _SelectEmpListState extends State<SelectEmpList> {
  List<String> selectedEmp = [];

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
    return Wrap(
      clipBehavior: Clip.antiAlias,
      spacing: 8,
      runSpacing: 8,
      children: List.generate(
          employeeList.length,
          (index) => InkWell(
                highlightColor: AppColors.transparent,
                splashColor: AppColors.transparent,
                onTap: () {
                  if (selectedEmp.contains(employeeList[index])) {
                    selectedEmp.remove(employeeList[index]);
                  } else {
                    selectedEmp.add(employeeList[index]);
                  }
                  log("$selectedEmp");
                  setState(() {});
                  widget.onSelectedList(selectedEmp);
                },
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      color: selectedEmp.contains(employeeList[index])
                          ? AppColors.primaryColor
                          : AppColors.transparent,
                      border: Border.all(
                        color: AppColors.primaryColor,
                      )),
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                  child: Text(
                    employeeList[index],
                    style:
                        AppTypography.poppinsRegular.copyWith(color: AppColors.secondaryColor, fontSize: 12),
                  ),
                ),
              )),
    );
  }
}
