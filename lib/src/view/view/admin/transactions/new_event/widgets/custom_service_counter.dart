import 'dart:developer';

import 'package:evantez/src/serializer/models/employee/employee_types_response.dart';
import 'package:evantez/src/view/core//constants/app_images.dart';
import 'package:evantez/src/view/core//themes/colors.dart';
import 'package:evantez/src/view/core//widgets/custom_dropdown_search.dart';
import 'package:evantez/src/view/core//widgets/custom_textfield.dart';
import 'package:evantez/src/view/core/constants/app_strings.dart';
import 'package:evantez/src/view/core/constants/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../../core/themes/typography.dart';

class CustomServiceCounter extends StatefulWidget {
  final String label;
  final bool? required;
  final Color? labelTextColor;
  final List<EmployeesTypesList> items;
  final String? intialValue;
  final bool? isEmployeeAssign;
  final Function()? onSelected;
  final Function(int, num)? countCallBack;
  final Function(EmployeesTypesList)? onSelectedEmp;
  const CustomServiceCounter(
      {super.key,
      required this.label,
      required this.items,
      this.intialValue,
      this.isEmployeeAssign,
      this.onSelectedEmp,
      this.required,
      this.labelTextColor,
      this.onSelected,
      this.countCallBack});

  @override
  State<CustomServiceCounter> createState() => _CustomServiceCounterState();
}

class _CustomServiceCounterState extends State<CustomServiceCounter> {
  final TextEditingController _totalController = TextEditingController();

  final TextEditingController employeeTypeController = TextEditingController();

  final TextEditingController wageController = TextEditingController();

  final ValueNotifier<double> serviceWage = ValueNotifier<double>(0);

  final ValueNotifier<int> count = ValueNotifier<int>(1);

  final ValueNotifier<List<String>> selectedEmpList = ValueNotifier<List<String>>([]);

  @override
  Widget build(BuildContext context) {
    final kSize = MediaQuery.of(context).size;
    return Container(
      width: kSize.width,
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: AppColors.secondaryColor.withOpacity(0.01),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 1, vertical: 1),
      margin: EdgeInsets.only(bottom: kSize.height * 0.032),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              /* SizedBox(
                width: kSize.width * 0.05,
                child: PopupMenuButton<String>(
                  icon: const Icon(
                    Icons.more_vert,
                    color: AppColors.primaryColor,
                  ),
                  // color: AppColors.primaryColor,
                  initialValue: 'remove',
                  // Callback that sets the selected popup menu item.
                  onSelected: (item) {
                    // setState(() {
                    log(item);
                    // });
                  },
                  clipBehavior: Clip.antiAlias,
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
                      value: "remove",
                      child: Text(
                        'Remove Item',
                        textAlign: TextAlign.start,
                        style: AppTypography.poppinsMedium.copyWith(),
                      ),
                    ),
                  ],
                ),
              ), */
              const Icon(
                Icons.more_vert,
                color: AppColors.primaryColor,
              ),
              Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: kSize.width * 0.5,
                        child: CustomTextField(
                          readOnly: true,
                          controller: employeeTypeController,
                          text: "",
                          onTap: () {
                            showEmployeeTypeSheet(
                                kSize: kSize,
                                onSelected: (employee) {
                                  employeeTypeController.text = employee.name!;
                                  wageController.text =
                                      "${double.parse(employee.amount!).toDouble().round()}";
                                  _totalController.text = wageController.text;
                                  /* if (widget.onSelected != null) {
                                    widget.onSelectedEmp!(employee);
                                  } */
                                  log("${employee.toJson()}");
                                });
                          },
                          suffixIcon: Padding(
                            padding: const EdgeInsets.all(6.0),
                            child: SvgPicture.asset(
                              AppImages.arrowDropDown,
                              colorFilter: const ColorFilter.mode(AppColors.primaryColor, BlendMode.srcIn),
                              fit: BoxFit.contain,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      SizedBox(
                          width: kSize.width * 0.25,
                          child: CustomTextField(
                            maxLines: 1,
                            readOnly: true,
                            keyboardType: TextInputType.number,
                            controller: wageController,
                            onChanged: (value) {
                              _totalController.text = value;
                            },
                            text: '',
                          )),
                    ],
                  ),
                  SizedBox(
                    width: kSize.width * 0.8,
                    child: ValueListenableBuilder(
                        valueListenable: count,
                        builder: (context, value, child) {
                          return Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.end,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              IconButton(
                                  onPressed: () {
                                    if (count.value > 1) {
                                      if (wageController.text.isNotEmpty) {
                                        count.value--;
                                        double wg = double.parse(wageController.text);
                                        _totalController.text = "${(wg * count.value).toInt()}";
                                        if (widget.countCallBack != null) {
                                          widget.countCallBack!(
                                              count.value, num.parse(_totalController.text));
                                        }
                                      }
                                    }
                                  },
                                  icon: SvgPicture.asset(
                                    AppImages.minuscircle,
                                    colorFilter:
                                        const ColorFilter.mode(AppColors.primaryColor, BlendMode.srcIn),
                                  )),
                              Text(
                                '${count.value}',
                                style: AppTypography.poppinsRegular.copyWith(
                                  color: AppColors.secondaryColor,
                                  fontSize: 16,
                                ),
                              ),
                              IconButton(
                                  onPressed: () {
                                    if (wageController.text.isNotEmpty) {
                                      count.value++;
                                      double wg = double.parse(wageController.text);
                                      _totalController.text = "${(wg * count.value).toInt()}";
                                      if (widget.countCallBack != null) {
                                        widget.countCallBack!(count.value, num.parse(_totalController.text));
                                      }
                                    }
                                  },
                                  icon: SvgPicture.asset(
                                    AppImages.addCircle,
                                    colorFilter:
                                        const ColorFilter.mode(AppColors.primaryColor, BlendMode.srcIn),
                                  )),
                              const SizedBox(
                                width: 14,
                              ),
                              Text(
                                'Total',
                                style: AppTypography.poppinsRegular.copyWith(
                                  fontSize: 16,
                                ),
                              ),
                              const SizedBox(
                                width: 14,
                              ),
                              SizedBox(
                                  width: kSize.width * 0.27,
                                  child: CustomTextField(
                                    readOnly: true,
                                    controller: _totalController,
                                    text: '',
                                  )),
                            ],
                          );
                        }),
                  ),
                  if (widget.isEmployeeAssign != null && widget.isEmployeeAssign!) ...{
                    SizedBox(
                        width: kSize.width * 0.8,
                        child: const CustomDropdownSearch(
                          label: 'Assign to',
                          items: [
                            "Roshan",
                            "Suhail",
                            "Rahul",
                            "John",
                            "Amal",
                          ],
                        ))
                    /* SizedBox(
                      width: kSize.width,
                      child: ValueListenableBuilder(
                          valueListenable: selectedEmpList,
                          builder: (context, value, child) {
                            return Wrap();
                          }),
                    ) */
                  }
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  showEmployeeTypeSheet({required Size kSize, required Function(EmployeesTypesList) onSelected}) {
    showModalBottomSheet<void>(
        clipBehavior: Clip.antiAlias,
        isScrollControlled: true,
        isDismissible: false,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(topRight: Radius.circular(16), topLeft: Radius.circular(16)),
        ),
        backgroundColor: AppColors.darkBgColor2,
        context: context,
        builder: (context) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: AppConstants.baseBorderRadius, vertical: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Spacer(
                      flex: 2,
                    ),
                    Text("Select Service Boys",
                        style: AppTypography.poppinsSemiBold.copyWith(
                          color: AppColors.secondaryColor,
                          fontSize: 18,
                        )),
                    const Spacer(),
                    TextButton(
                      style: TextButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 6),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4))),
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
              ),
              SizedBox(
                height: kSize.height * 0.35,
                child: ListView.builder(
                    itemCount: widget.items.length,
                    padding: const EdgeInsets.only(
                        right: AppConstants.baseBorderRadius,
                        left: AppConstants.baseBorderRadius,
                        bottom: AppConstants.largePadding),
                    itemBuilder: (context, index) {
                      return InkWell(
                        highlightColor: AppColors.transparent,
                        splashColor: AppColors.transparent,
                        onTap: () {
                          onSelected(widget.items[index]);
                          if (widget.onSelectedEmp != null) {
                            widget.onSelectedEmp!(widget.items[index]);
                            widget.countCallBack!(1, num.parse(widget.items[index].amount!));
                          }
                          Navigator.pop(context);
                        },
                        child: Padding(
                          padding: const EdgeInsets.only(bottom: 8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(widget.items[index].name!,
                                  style: AppTypography.poppinsMedium.copyWith(
                                    color: AppColors.secondaryColor,
                                  )),
                              Text("₹${widget.items[index].amount!}",
                                  style: AppTypography.poppinsMedium.copyWith(
                                    color: AppColors.secondaryColor,
                                  ))
                            ],
                          ),
                        ),
                      );
                    }),
              )
              /* Column(
                children: List.generate(
                    widget.items.length,
                    (index) => Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(widget.items[index].name!,
                                style: AppTypography.poppinsMedium.copyWith(
                                  color: AppColors.secondaryColor.withOpacity(0.4),
                                )),
                            Text(widget.items[index].amount!,
                                style: AppTypography.poppinsMedium.copyWith(
                                  color: AppColors.secondaryColor.withOpacity(0.4),
                                ))
                          ],
                        )),
              ) */
            ],
          );
        });
  }
}
