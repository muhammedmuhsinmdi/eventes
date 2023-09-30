import 'package:evantez/src/view/core/constants/app_strings.dart';
import 'package:evantez/src/view/core/widgets/custom_textfield.dart';
import 'package:flutter/material.dart';

import '../../../../../../core/themes/colors.dart';
import '../../../../../../core/themes/typography.dart';

class EmployeePaymentTile extends StatefulWidget {
  final Function(num) getCutAmount;
  final Function(num) getAdditionalAmount;
  const EmployeePaymentTile({super.key, required this.getCutAmount, required this.getAdditionalAmount});

  @override
  State<EmployeePaymentTile> createState() => _EmployeePaymentTileState();
}

class _EmployeePaymentTileState extends State<EmployeePaymentTile> {
  TextEditingController cutAmt = TextEditingController();
  TextEditingController additionalAmt = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final kSize = MediaQuery.of(context).size;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(bottom: kSize.height * 0.016),
          child: Text(
            AppStrings.performanceText,
            style: AppTypography.poppinsSemiBold.copyWith(
              fontSize: 18,
              color: AppColors.secondaryColor,
            ),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Cut:',
              style: AppTypography.poppinsMedium.copyWith(
                fontSize: 14,
                color: AppColors.secondaryColor.withOpacity(0.6),
              ),
            ),
            SizedBox(
                width: kSize.width * 0.3,
                child: CustomTextField(
                  text: '',
                  keyboardType: TextInputType.number,
                  controller: cutAmt,
                  onChanged: (value) {
                    //
                    num cut = num.parse(value);
                    widget.getCutAmount(cut);
                  },
                ))
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Additional:',
              style: AppTypography.poppinsMedium.copyWith(
                fontSize: 14,
                color: AppColors.secondaryColor.withOpacity(0.6),
              ),
            ),
            SizedBox(
                width: kSize.width * 0.3,
                child: CustomTextField(
                  text: '',
                  keyboardType: TextInputType.number,
                  controller: additionalAmt,
                  onChanged: (value) {
                    //
                    num additional = num.parse(value);
                    widget.getCutAmount(additional);
                  },
                )),
          ],
        ),
      ],
    );
  }
}
