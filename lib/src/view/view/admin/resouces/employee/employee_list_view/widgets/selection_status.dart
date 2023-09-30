import 'package:flutter/material.dart';

import '../../../../../../core/themes/colors.dart';
import '../../../../../../core/themes/typography.dart';

class SelectionStatus extends StatefulWidget {
  const SelectionStatus({super.key});

  @override
  State<SelectionStatus> createState() => _SelectionStatusState();
}

class _SelectionStatusState extends State<SelectionStatus> {
  final List<String> statusList = ['Active', "Inactive"];

  final ValueNotifier<String> selectedStatus = ValueNotifier('');

  @override
  Widget build(BuildContext context) {
    final kSize = MediaQuery.of(context).size;
    return ValueListenableBuilder(
        valueListenable: selectedStatus,
        builder: (context, value, child) {
          return Wrap(
            clipBehavior: Clip.antiAlias,
            spacing: 8,
            runSpacing: 8,
            children: List.generate(
                statusList.length,
                (index) => InkWell(
                    highlightColor: AppColors.transparent,
                    splashColor: AppColors.transparent,
                    onTap: () {
                      //
                      selectedStatus.value = statusList[index];
                      //
                    },
                    child: statusWidget(kSize, statusList[index]))),
          );
        });
  }

  Widget statusWidget(Size kSize, String filter) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: selectedStatus.value == filter ? AppColors.primaryColor : AppColors.transparent,
          border: Border.all(
            color: AppColors.primaryColor,
          )),
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
      child: Text(
        filter,
        style: AppTypography.poppinsRegular.copyWith(color: AppColors.secondaryColor, fontSize: 12),
      ),
    );
  }
}
