/* import 'package:flutter/material.dart';

import '../../../core/themes/colors.dart';
import '../../../core/themes/typography.dart';

class DateSelectionTile extends StatelessWidget {
  final String title;
  final List<String> items;
  const DateSelectionTile({super.key, required this.title, required this.items});

  @override
  Widget build(BuildContext context) {
    final kSize = MediaQuery.of(context).size;
    return ExpansionTile(
      tilePadding: EdgeInsets.zero,
      title: Text(
        title,
        style: AppTypography.poppinsSemiBold.copyWith(
          color: AppColors.secondaryColor,
          fontSize: 18,
        ),
      ),
      childrenPadding: EdgeInsets.only(
        bottom: kSize.height * 0.024,
      ),
      children: [
        SizedBox(
          width: kSize.width,
          child: Wrap(
            alignment: WrapAlignment.start,
            runAlignment: WrapAlignment.start,
            // crossAxisAlignment: WrapCrossAlignment.start,
            children: List.generate(
                items.length,
                (index) => InkWell(
                    highlightColor: AppColors.transparent,
                    splashColor: AppColors.transparent,
                    onTap: () {
                      //
                      if (isMultiSelect != null && isMultiSelect) {
                      } else {}
                    },
                    child: items[index])),
          ),
        )
      ],
    );
  }
}
 */