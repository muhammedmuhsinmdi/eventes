import 'package:evantez/src/view/core//constants/app_images.dart';
import 'package:evantez/src/view/core//constants/app_strings.dart';
import 'package:evantez/src/view/core//constants/constants.dart';
import 'package:evantez/src/view/core//themes/colors.dart';
import 'package:evantez/src/view/core//widgets/custom_back_btn.dart';
import 'package:evantez/src/view/core//widgets/custom_date_picker.dart';
import 'package:evantez/src/view/core//widgets/custom_drop_down.dart';
import 'package:evantez/src/view/core//widgets/custom_textfield.dart';
import 'package:evantez/src/view/core//widgets/footer_button.dart';
import 'package:evantez/src/view/view/transactions/new_event/widgets/custom_service_counter.dart';
import 'package:evantez/src/view/view/transactions/new_event/widgets/filter_boys_rating.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../core/themes/typography.dart';

class NewEventView extends StatelessWidget {
  NewEventView({super.key});

  final List<String> serviceReq = [
    "Head",
    "Captain",
    "Hosting",
  ];

  @override
  Widget build(BuildContext context) {
    List<String> selectedReq = [];
    selectedReq.add(serviceReq.first);
    final kSize = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: appBar(context, kSize),
      body: SizedBox(
        height: kSize.height,
        width: kSize.width,
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.only(
                top: kSize.height * 0.032,
                right: AppConstants.baseBorderRadius,
                left: AppConstants.baseBorderRadius),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                eventID(),
                uploadImage(kSize),
                SizedBox(
                  height: kSize.height * 0.032,
                ),
                Divider(
                  color: AppColors.secondaryColor.withOpacity(0.2),
                ),
                SizedBox(
                  height: kSize.height * 0.024,
                ),
                eventType(),
                SizedBox(
                  height: kSize.height * 0.024,
                ),
                eventVenue(),
                SizedBox(
                  height: kSize.height * 0.024,
                ),
                dateTime(),
                SizedBox(
                  height: kSize.height * 0.024,
                ),
                const CustomTextField(
                  text: AppStrings.customerName,
                  required: true,
                  hintText: "Name",
                ),
                SizedBox(
                  height: kSize.height * 0.024,
                ),
                const CustomTextField(
                  text: AppStrings.phoneText,
                  required: true,
                  hintText: "Phone Number",
                ),
                SizedBox(
                  height: kSize.height * 0.024,
                ),
                const CustomTextField(
                  text: AppStrings.address,
                  required: true,
                  maxLines: 2,
                  hintText: "Address",
                ),
                SizedBox(
                  height: kSize.height * 0.024,
                ),
                const CustomTextField(
                  text: 'Additional Information',
                  hintText: "Notes/Instructions",
                ),
                SizedBox(
                  height: kSize.height * 0.032,
                ),
                Divider(
                  color: AppColors.secondaryColor.withOpacity(0.2),
                ),
                SizedBox(
                  height: kSize.height * 0.032,
                ),
                Text(
                  AppStrings.overTimeText,
                  style: AppTypography.poppinsSemiBold.copyWith(
                    color: AppColors.secondaryColor,
                  ),
                ),
                SizedBox(
                  height: kSize.height * 0.018,
                ),
                overTimeDetail(kSize),
                SizedBox(
                  height: kSize.height * 0.032,
                ),
                Text(
                  AppStrings.serviceBoystext,
                  style: AppTypography.poppinsSemiBold.copyWith(
                    color: AppColors.secondaryColor,
                  ),
                ),
                SizedBox(
                  height: kSize.height * 0.018,
                ),
                serviceBoys(kSize, selectedReq),
                SizedBox(
                  height: kSize.height * 0.032,
                ),
                Divider(
                  color: AppColors.secondaryColor.withOpacity(0.2),
                ),
                SizedBox(
                  height: kSize.height * 0.032,
                ),
                Text(
                  AppStrings.filterBoysText,
                  style: AppTypography.poppinsSemiBold.copyWith(
                    color: AppColors.secondaryColor,
                  ),
                ),
                SizedBox(
                  height: kSize.height * 0.018,
                ),
                const FilterBoysRating(),
                SizedBox(
                  height: kSize.height * 0.032,
                ),
                FooterButton(
                  label: "Save",
                  onTap: () {},
                ),
                SizedBox(
                  height: kSize.height * 0.12,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  AppBar appBar(BuildContext context, Size kSize) {
    return AppBar(
      elevation: 0,
      leading: const CustomBackButton(),
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      centerTitle: true,
      title: Text(
        AppStrings.createEventText,
        style: AppTypography.poppinsSemiBold.copyWith(
          color: AppColors.secondaryColor,
        ),
      ),
    );
  }

  Widget eventID() {
    return RichText(
        text: TextSpan(
            text: AppStrings.eventCodeText,
            style: AppTypography.poppinsMedium.copyWith(fontSize: 16, color: AppColors.secondaryColor),
            children: [
          TextSpan(
              text: "     EV24215",
              style: AppTypography.poppinsRegular.copyWith(
                fontSize: 16,
                color: AppColors.secondaryColor.withOpacity(0.6),
              ))
        ]));
  }

  Widget uploadImage(Size kSize) {
    return Container(
      margin: EdgeInsets.only(top: kSize.height * 0.032),
      decoration: BoxDecoration(
          color: AppColors.greyColor,
          borderRadius: BorderRadius.circular(
            AppConstants.basePadding,
          )),
      height: kSize.height * 0.2,
      width: kSize.width,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset(
            AppImages.uploadImg,
            height: kSize.height * 0.085,
            width: kSize.height * 0.085,
            colorFilter: const ColorFilter.mode(AppColors.darkGreyColor, BlendMode.srcIn),
          ),
          Container(
            margin: EdgeInsets.only(top: kSize.height * 0.012),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(AppConstants.baseBorderRadius),
              color: AppColors.blackColor.withOpacity(0.6),
            ),
            padding: EdgeInsets.symmetric(horizontal: kSize.width * 0.032, vertical: kSize.height * 0.003),
            child: Text(
              "Upload Image",
              style: AppTypography.poppinsMedium.copyWith(fontSize: 14),
            ),
          ),
        ],
      ),
    );
  }

  Widget eventType() {
    return CustomDropDown(
      label: "Type of Event",
      required: true,
      hintText: "Select Event Type",
      items: const ["Marriage Function", "Nikkhah", "Meetings", "House Warming"],
    );
  }

  Widget eventVenue() {
    return CustomDropDown(
      label: "Event Venue",
      required: true,
      hintText: "Select Event Venue",
      items: const ["Malappuram", "Valenchery", "Palakkad", "Manjeri"],
    );
  }

  Widget dateTime() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        CustomDatePicker(
            controller: TextEditingController(), type: "Date", label: "Date", onChanged: (value) {}),
        CustomDatePicker(
            controller: TextEditingController(), type: 'Time', label: 'Time', onChanged: (valu) {})
      ],
    );
  }

  Widget overTimeDetail(Size kSize) {
    return Row(
      // mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        SizedBox(
          width: kSize.width * 0.17,
          child: Text(
            "Normal Hours",
            textAlign: TextAlign.end,
            maxLines: 2,
            style: AppTypography.poppinsMedium.copyWith(color: AppColors.secondaryColor.withOpacity(0.6)),
          ),
        ),
        SizedBox(
          width: kSize.width * 0.015,
        ),
        Flexible(
          // width: kSize.width * 0.2,
          child: CustomTextField(
            text: '',
            keyboardType: TextInputType.number,
            suffixIcon: Padding(
              padding: EdgeInsets.only(top: kSize.height * 0.015),
              child: Text(
                'Hrs',
                textAlign: TextAlign.end,
                style: AppTypography.poppinsSemiBold.copyWith(color: AppColors.secondaryColor, fontSize: 16),
              ),
            ),
          ),
        ),
        SizedBox(
          width: kSize.width * 0.016,
        ),
        Container(
          height: kSize.height * 0.04,
          width: 2,
          color: AppColors.secondaryColor.withOpacity(0.6),
        ),
        SizedBox(
          width: kSize.width * 0.016,
        ),
        SizedBox(
          width: kSize.width * 0.2,
          child: Text(
            "Overtime Rate/Hr",
            textAlign: TextAlign.end,
            maxLines: 2,
            style: AppTypography.poppinsMedium.copyWith(color: AppColors.secondaryColor.withOpacity(0.6)),
          ),
        ),
        SizedBox(
          width: kSize.width * 0.015,
        ),
        const Flexible(
          child: CustomTextField(
            keyboardType: TextInputType.number,
            text: '',
          ),
        ),
      ],
    );
  }

  Widget serviceBoys(Size kSize, List<String> selectedReq) {
    return SizedBox(
      width: kSize.width,
      child: Column(
        children: List.generate(
          serviceReq.length + 1,
          (index) => serviceReq.length == index
              ? FooterButton(fillColor: AppColors.transparent, label: "Add +", onTap: () {})
              : CustomServiceCounter(
                  label: "",
                  items: serviceReq,
                ),
        ),
      ),
    );
  }

  // Widget filterRatingBoys() {
  //   return CustomDropDown(
  //     items: [] ,
  //   );
  // }
}
