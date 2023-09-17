import 'package:evantez/src/view/core//constants/app_images.dart';
import 'package:evantez/src/view/core//constants/constants.dart';
import 'package:evantez/src/view/core//themes/colors.dart';
import 'package:evantez/src/view/core//themes/typography.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../core/constants/app_strings.dart';
import '../../../core/widgets/custom_textfield.dart';

class AddEmployeeSheet {
  BuildContext parentContext;
  AddEmployeeSheet(this.parentContext);

  Future<void> show() async {
    await showModalBottomSheet(
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
  List<String> empList = <String>[
    'Olive Yew',
    'Aida Bugg',
    "Roshan",
    "Suhail",
    "Muhsin",
    "Sameer"
  ];
  final ValueNotifier<List<String>> selectedEmpList =
      ValueNotifier<List<String>>([]);

  @override
  Widget build(BuildContext context) {
    final kSize = MediaQuery.of(context).size;
    return Padding(
        padding: EdgeInsets.fromLTRB(AppConstants.baseBorderRadius,
            kSize.height * 0.032, AppConstants.baseBorderRadius, 0),
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
                      selectedEmpList.value.length,
                      (index) => selecteEmployeeTile(
                          kSize, selectedEmpList.value[index]),
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
                        itemCount: empList.length,
                        itemBuilder: (context, index) {
                          return InkWell(
                              highlightColor: AppColors.transparent,
                              splashColor: AppColors.transparent,
                              onTap: () {
                                setState(() {
                                  if (selectedEmpList.value
                                      .contains(empList[index])) {
                                    selectedEmpList.value
                                        .remove(empList[index]);
                                    if (kDebugMode) {
                                      print(selectedEmpList.value.length);
                                    }
                                  } else {
                                    selectedEmpList.value.add(empList[index]);
                                    if (kDebugMode) {
                                      print(selectedEmpList.value.length);
                                    }
                                  }
                                });
                              },
                              child: employeeTile(kSize, empList[index]));
                        }),
                  ),
                ),
              ],
            );
          },
        ));
  }
}

Widget employeeTile(Size kSize, String emp) {
  return Container(
    margin: const EdgeInsets.only(bottom: 8, right: AppConstants.marginSpace),
    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
    decoration: BoxDecoration(
        color: AppColors.secondaryColor.withOpacity(0.1),
        borderRadius: BorderRadius.circular(6)),
    child: RichText(
        text: TextSpan(
            text: "$emp  ",
            style: AppTypography.poppinsRegular.copyWith(
              fontSize: 16,
              color: AppColors.secondaryColor,
            ),
            children: [
          TextSpan(
              text: 'Supervisor',
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
        colorFilter:
            const ColorFilter.mode(AppColors.primaryColor, BlendMode.srcIn),
      ),
    ),
  );
}
