import 'dart:developer';

import 'package:evantez/src/view/core/themes/colors.dart';
import 'package:evantez/src/view/view/admin/transactions/new_event/widgets/custom_service_counter.dart';
import 'package:flutter/material.dart';

import '../../../../../../core/constants/app_strings.dart';
import '../../../../../../core/themes/typography.dart';
import '../../../../../../core/widgets/footer_button.dart';

class EmployeeSettingWork extends StatefulWidget {
  final List<String> items;
  final Function(List<String>) onSelected;
  const EmployeeSettingWork({super.key, required this.items, required this.onSelected});

  @override
  State<EmployeeSettingWork> createState() => _EmployeeSettingWorkState();
}

class _EmployeeSettingWorkState extends State<EmployeeSettingWork> {
  ValueNotifier<int> settingWorkCount = ValueNotifier<int>(0);

  List<String> settingWorkItems = [];

  @override
  void initState() {
    settingWorkItems.addAll(widget.items);
    log(" >>> ${settingWorkItems.length}");
    settingWorkCount.value = 1;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final kSize = MediaQuery.of(context).size;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(bottom: kSize.height * 0.016),
          child: Text(
            AppStrings.settingsWorkText,
            style: AppTypography.poppinsSemiBold.copyWith(
              fontSize: 18,
              color: AppColors.secondaryColor,
            ),
          ),
        ),
        SizedBox(
          width: kSize.width,
          child: ValueListenableBuilder(
              valueListenable: settingWorkCount,
              builder: (context, value, child) {
                return Column(
                  children: List.generate(settingWorkCount.value, (index) {
                    return CustomServiceCounter(
                      label: "Setting Work",
                      items: settingWorkItems,
                    );
                  }),
                );
              }),
        ),
        if (settingWorkCount.value <= settingWorkItems.length)
          FooterButton(
              fillColor: AppColors.transparent,
              label: "Add +",
              onTap: () {
                if (settingWorkItems.length > settingWorkCount.value) {
                  settingWorkCount.value++;
                  widget.onSelected(settingWorkItems);
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Max Limit Reached')),
                  );
                }
              })
        else
          const SizedBox()
      ],
    );
  }
}
