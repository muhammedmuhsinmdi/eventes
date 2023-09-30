import 'package:evantez/src/view/core/constants/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../../core/themes/colors.dart';

class ApplyCompleted extends StatelessWidget {
  const ApplyCompleted({super.key});

  @override
  Widget build(BuildContext context) {
    final kSize = MediaQuery.of(context).size;
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(
            horizontal: AppConstants.baseBorderRadius),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: SvgPicture.asset('assets/svg/arrow.svg'),
            ),
            const SizedBox(
              height: 20,
            ),
            const Text(
              'You have signed in to \nthe event ',
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: Color(0xffE8A250),
                  fontWeight: FontWeight.w600,
                  fontSize: 24),
            ),
            const SizedBox(
              height: 20,
            ),
            const Text(
              'EV - 540',
              style: TextStyle(
                  color: Colors.grey,
                  fontWeight: FontWeight.w600,
                  fontSize: 24),
            ),
            const SizedBox(
              height: 20,
            ),
            const Text(
              'Marriage Function at Nova Auditorium',
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: Color(0xffFFFFFF),
                  fontWeight: FontWeight.w600,
                  fontSize: 24),
            ),
            const SizedBox(
              height: 20,
            ),
            const Text(
              '03 NOV, 2023 - 02:30 PM to 11:30 PM',
              style: TextStyle(
                  color: Color(0xff2C67FF),
                  fontSize: 18,
                  fontWeight: FontWeight.w600),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 80),
              child: InkWell(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Container(
                  height: kSize.height * 0.05,
                  width: kSize.width,
                  decoration: BoxDecoration(
                      color: AppColors.primaryColor,
                      borderRadius: BorderRadius.circular(
                        AppConstants.baseBorderRadius,
                      )),
                  child: const Center(child: Text('Continue')),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
