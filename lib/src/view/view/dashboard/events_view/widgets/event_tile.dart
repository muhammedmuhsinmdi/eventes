import 'package:evantez/src/view/core//constants/constants.dart';
import 'package:evantez/src/view/core//themes/colors.dart';
import 'package:evantez/src/view/core//themes/typography.dart';
import 'package:flutter/material.dart';

class EventTile extends StatelessWidget {
  final int index;
  final int itemCount;
  final bool? isBoy;
  const EventTile({super.key, required this.index, required this.itemCount, this.isBoy = false});

  @override
  Widget build(BuildContext context) {
    final kSize = MediaQuery.of(context).size;
    return SizedBox(
      width: kSize.width,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                clipBehavior: Clip.antiAlias,
                decoration: BoxDecoration(borderRadius: BorderRadius.circular(8)),
                margin: EdgeInsets.only(right: kSize.width * 0.024),
                height: kSize.height * 0.085,
                width: kSize.height * 0.085,
                child: const Placeholder(),
              ),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Janata Auditorium',
                      style:
                          AppTypography.poppinsMedium.copyWith(color: AppColors.secondaryColor, fontSize: 14),
                    ),
                    SizedBox(
                      height: kSize.height * 0.003,
                    ),
                    Text(
                      '12-03-2023',
                      style: AppTypography.poppinsRegular.copyWith(
                        color: AppColors.secondaryColor,
                        fontSize: 12,
                      ),
                    ),
                    SizedBox(
                      height: kSize.height * 0.003,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          '09:30 AM - 05:30 PM',
                          style: AppTypography.poppinsRegular.copyWith(
                            color: AppColors.secondaryColor,
                          ),
                        ),
                        eventStatus(),
                      ],
                    )
                  ],
                ),
              ),
            ],
          ),
          if (!isBoy!) ...{
            SizedBox(
              height: kSize.height * 0.008,
            ),
            eventProgressLine(kSize),
          }
        ],
      ),
    );
  }

  Widget eventProgressLine(Size kSize) {
    return Container(
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25),
      ),
      height: kSize.height * 0.005,
      width: kSize.height * 0.085,
      child: const LinearProgressIndicator(
        value: 0.86,
        color: AppColors.statusSuccess,
      ),
    );
  }

  Widget eventStatus() {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppConstants.marginSpace,
        vertical: AppConstants.smallPadding,
      ),
      decoration: BoxDecoration(
          color: AppColors.secondaryColor.withOpacity(0.4),
          borderRadius: BorderRadius.circular(AppConstants.basePadding)),
      child: Text(
        "Closed",
        style: AppTypography.poppinsRegular.copyWith(
          fontSize: 12,
        ),
      ),
    );
  }
}
