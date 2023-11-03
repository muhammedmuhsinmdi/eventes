import 'dart:developer';

import 'package:evantez/src/controller/events/add_event_controller.dart';
import 'package:evantez/src/controller/resources/employee/employee_controller.dart';
import 'package:evantez/src/view/core/constants/app_strings.dart';
import 'package:evantez/src/view/core/constants/constants.dart';
import 'package:evantez/src/view/core/themes/colors.dart';
import 'package:evantez/src/view/core/themes/typography.dart';
import 'package:evantez/src/view/core/widgets/common_drop_down.dart';
import 'package:evantez/src/view/core/widgets/custom_back_btn.dart';
import 'package:evantez/src/view/core/widgets/custom_date_picker.dart';
import 'package:evantez/src/view/core/widgets/custom_textfield.dart';
import 'package:evantez/src/view/core/widgets/drop_down_value.dart';
import 'package:evantez/src/view/core/widgets/footer_button.dart';
import 'package:evantez/src/view/view/admin/transactions/new_event/widgets/event_image_upload.dart';
import 'package:evantez/src/view/view/admin/transactions/new_event/widgets/filter_boys_rating.dart';
import 'package:evantez/src/view/view/admin/transactions/new_event/widgets/service_boys.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddEventView extends StatelessWidget {
  const AddEventView({super.key});

  @override
  Widget build(BuildContext context) {
    final kSize = MediaQuery.of(context).size;
    final employeeController = context.watch<EmployeesController>();
    final addEventContoller = context.watch<AddEventController>();
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: appBar(context, kSize),
      body: SizedBox(
        height: kSize.height,
        width: kSize.width,
        child: Form(
            key: addEventContoller.eventForm,
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.only(
                    top: kSize.height * 0.032,
                    right: AppConstants.baseBorderRadius,
                    left: AppConstants.baseBorderRadius),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    eventID(addEventContoller.event.code!),
                    EventImageUpload(onPicked: (pickedImage) {}),
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: kSize.height * 0.032),
                      child: Divider(
                        color: AppColors.secondaryColor.withOpacity(0.2),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: kSize.height * 0.024),
                      child: CommonDropdown(
                          text: "Event Type",
                          label: "Event Type",
                          required: true,
                          hintText: 'Select Event Type',
                          dropDownValue: addEventContoller.types,
                          selecteItem: addEventContoller.selectedEventType,
                          validator: addEventContoller.eventTypeValidator,
                          onChanged: (DropDownValue value) {
                            addEventContoller.selectedEventType = value;
                            addEventContoller.event.eventTypeId = value.id;
                          }),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: kSize.height * 0.024),
                      child: CustomTextField(
                        text: "Event Venue",
                        hintText: 'Enter Venue',
                        controller: addEventContoller.eventVenue,
                        validator: addEventContoller.eventVenueValidator,
                        required: true,
                        onSave: (value) {
                          addEventContoller.event.venueId = 1;
                        },
                      ),
                    ),
                    dateTime(kSize: kSize, controller: addEventContoller),
                    Padding(
                      padding: EdgeInsets.only(bottom: kSize.height * 0.024),
                      child: CustomTextField(
                        text: AppStrings.customerName,
                        required: true,
                        hintText: "Name",
                        controller: addEventContoller.customerName,
                        validator: (value) => addEventContoller.customerNameValidator(value),
                        onSave: (value) {
                          addEventContoller.event.customerName = value;
                        },
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(bottom: kSize.height * 0.024),
                      child: CustomTextField(
                        text: AppStrings.phoneText,
                        required: true,
                        hintText: "Phone Number",
                        maxLength: 10,
                        prefixIcon: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
                          child: Text(
                            "+91",
                            style: AppTypography.poppinsMedium.copyWith(
                              color: AppColors.primaryColor,
                              fontSize: 16,
                            ),
                          ),
                        ),
                        keyboardType: TextInputType.phone,
                        controller: addEventContoller.customerPhone,
                        validator: addEventContoller.phoneValidator,
                        onChanged: (phone) {},
                        onSave: (value) {
                          addEventContoller.event.customerPhone = value;
                        },
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(bottom: kSize.height * 0.024),
                      child: CustomTextField(
                        text: AppStrings.address,
                        required: true,
                        maxLines: 2,
                        hintText: "Address",
                        controller: addEventContoller.customerAddress,
                        validator: addEventContoller.customAddressValidator,
                        onSave: (address) {
                          addEventContoller.event.customerAddress = address;
                        },
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(bottom: kSize.height * 0.024),
                      child: CustomTextField(
                        text: 'Additional Information',
                        hintText: "Notes/Instructions",
                        controller: addEventContoller.additionalInfo,
                        onSave: (notes) {
                          addEventContoller.event.notes = notes;
                          // additionalnote.text = notes;
                        },
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: kSize.height * 0.032),
                      child: Divider(
                        color: AppColors.secondaryColor.withOpacity(0.2),
                      ),
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
                    overTimeDetail(kSize: kSize, controller: addEventContoller),
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: kSize.height * 0.032),
                      child: Divider(
                        color: AppColors.secondaryColor.withOpacity(0.2),
                      ),
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
                    ServiceBoys(
                      items: employeeController.employeeTypesList,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: kSize.height * 0.032),
                      child: Divider(
                        color: AppColors.secondaryColor.withOpacity(0.2),
                      ),
                    ),
                    Text(
                      AppStrings.filterBoysText,
                      style: AppTypography.poppinsSemiBold.copyWith(
                        color: AppColors.secondaryColor,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: kSize.height * 0.018),
                      child: FilterBoysRating(
                        onSelected: (rating) {
                          log(rating);
                        },
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                        top: kSize.height * 0.024,
                        bottom: kSize.height * 0.032,
                      ),
                      child: FooterButton(
                          label: AppStrings.saveText,
                          onTap: () {
                            // save event
                            addEventContoller.saveEvent();
                          }),
                    ),
                  ],
                ),
              ),
            )),
      ),
    );
  }

  Widget eventID(String eventCode) {
    return RichText(
        text: TextSpan(
            text: AppStrings.eventCodeText,
            style: AppTypography.poppinsMedium.copyWith(fontSize: 16, color: AppColors.secondaryColor),
            children: [
          TextSpan(
              text: "     $eventCode",
              style: AppTypography.poppinsRegular.copyWith(
                fontSize: 16,
                color: AppColors.secondaryColor.withOpacity(0.6),
              ))
        ]));
  }

  Widget dateTime({required Size kSize, required AddEventController controller}) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: kSize.height * 0.024),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          CustomDatePicker(
            controller: controller.scheduledDate,
            type: "Date",
            label: "Date",
            onSaved: (value) {
              // On Save Pending , Due variable not in API
            },
            onChanged: (value) {},
          ),
          CustomDatePicker(
              controller: controller.scheduledTime,
              type: 'Time',
              label: 'Time',
              onSaved: (value) {
                // On Save Pending , Due variable not in API
              },
              onChanged: (value) {})
        ],
      ),
    );
  }

  AppBar appBar(BuildContext context, Size kSize) {
    return AppBar(
      elevation: 0,
      leading: CustomBackButton(
        onTap: () {
          Navigator.pop(context);
        },
      ),
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

  Widget overTimeDetail({required Size kSize, required AddEventController controller}) {
    return Row(
      mainAxisSize: MainAxisSize.max,
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        SizedBox(
          width: 55,
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
          child: CustomTextField(
            text: '',
            controller: controller.normalHours,
            validator: controller.normalHoursValidator,
            keyboardType: TextInputType.number,
            onSave: (value) {
              controller.event.normalHours = value;
            },
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
          width: kSize.width * 0.024,
        ),
        Container(
          height: kSize.height * 0.04,
          width: 2,
          color: AppColors.secondaryColor.withOpacity(0.6),
        ),
        SizedBox(
          width: kSize.width * 0.024,
        ),
        SizedBox(
          width: 70,
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
        Flexible(
          child: CustomTextField(
            prefix: Padding(
              padding: const EdgeInsets.only(right: 3.0),
              child: Text(
                "₹",
                style: AppTypography.poppinsMedium.copyWith(
                  color: AppColors.primaryColor,
                  fontSize: 16,
                ),
              ),
            ),
            keyboardType: TextInputType.number,
            text: '',
            controller: controller.overTimeRate,
            validator: controller.overTimeRateValidator,
            onSave: (value) {
              controller.event.overtimeHourlyCharge = value;
            },
          ),
        ),
      ],
    );
  }
}
