import 'package:evantez/src/view/core//constants/app_images.dart';
import 'package:evantez/src/view/core//themes/colors.dart';
import 'package:evantez/src/view/core//widgets/custom_dropdown_search.dart';
import 'package:evantez/src/view/core//widgets/custom_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../core/themes/typography.dart';

class CustomServiceCounter extends StatelessWidget {
  final String label;
  final bool? required;
  final Color? labelTextColor;
  final List<String> items;
  final String? intialValue;
  final bool? isEmployeeAssign;
  final Function(List<String>)? onSelectedEmp;
  CustomServiceCounter(
      {super.key,
      required this.label,
      required this.items,
      this.intialValue,
      this.isEmployeeAssign,
      this.onSelectedEmp,
      this.required,
      this.labelTextColor});

  final TextEditingController _totalController = TextEditingController();

  final TextEditingController wageController = TextEditingController();

  final ValueNotifier<double> serviceWage = ValueNotifier<double>(0);

  final ValueNotifier<int> count = ValueNotifier<int>(1);

  final ValueNotifier<List<String>> selectedEmpList =
      ValueNotifier<List<String>>([]);

  @override
  Widget build(BuildContext context) {
    final kSize = MediaQuery.of(context).size;
    return Container(
      width: kSize.width,
      padding: const EdgeInsets.symmetric(horizontal: 1, vertical: 1),
      color: AppColors.blackColor.withOpacity(0.1),
      margin: EdgeInsets.only(bottom: kSize.height * 0.032),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
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
                        width: kSize.width * 0.55,
                        child: CustomDropdownSearch(
                          items: items,
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      SizedBox(
                          width: kSize.width * 0.2,
                          child: CustomTextField(
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
                                        double wg =
                                            double.parse(wageController.text);
                                        _totalController.text =
                                            "${(wg * count.value).toInt()}";
                                      }
                                    }
                                  },
                                  icon: SvgPicture.asset(
                                    AppImages.minuscircle,
                                    colorFilter: const ColorFilter.mode(
                                        AppColors.primaryColor,
                                        BlendMode.srcIn),
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
                                      double wg =
                                          double.parse(wageController.text);
                                      _totalController.text =
                                          "${(wg * count.value).toInt()}";
                                    }
                                  },
                                  icon: SvgPicture.asset(
                                    AppImages.addCircle,
                                    colorFilter: const ColorFilter.mode(
                                        AppColors.primaryColor,
                                        BlendMode.srcIn),
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
                  if (isEmployeeAssign != null && isEmployeeAssign!) ...{
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
}
