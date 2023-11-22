import 'dart:developer';

import 'package:evantez/app/app.dart';
import 'package:evantez/src/controller/auth/auth_controller.dart';
import 'package:evantez/src/controller/events/add_event_controller.dart';
import 'package:evantez/src/controller/resources/employee/employee_controller.dart';
import 'package:evantez/src/model/components/snackbar_widget.dart';
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
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class AddEventView extends StatelessWidget {
  const AddEventView({super.key});

  @override
  Widget build(BuildContext context) {
    final kSize = MediaQuery.of(context).size;
    final authController = context.watch<AuthController>();
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
                    // eventID(addEventContoller.event.code ?? '', addEventContoller, kSize),
                    if (addEventContoller.eventImagePath.isNotEmpty) ...{
                      EventImageUpload(
                        imgUrl: addEventContoller.eventImagePath,
                        onPicked: (pickedImage) {
                          addEventContoller.eventImage = pickedImage;
                        },
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: kSize.height * 0.032),
                        child: Divider(
                          color: AppColors.secondaryColor.withOpacity(0.2),
                        ),
                      )
                    },
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
                      child: CommonDropdown(
                          text: "Event Venue",
                          label: "Event Venue",
                          required: true,
                          hintText: 'Select Event Venue',
                          dropDownValue: addEventContoller.eventVenues,
                          selecteItem: addEventContoller.selectedEventVenue,
                          validator: addEventContoller.eventVenueValidator,
                          onChanged: (DropDownValue value) {
                            addEventContoller.selectedEventVenue = value;
                            addEventContoller.event.venueId = value.id;
                          }) /* CustomTextField(
                        text: "Event Venue",
                        hintText: 'Enter Venue',
                        controller: addEventContoller.eventVenue,
                        validator: addEventContoller.eventVenueValidator,
                        required: true,
                        onSave: (value) {
                          addEventContoller.event.venueId = 1;
                        },
                      ) */
                      ,
                    ),
                    dateTime(kSize: kSize, controller: addEventContoller),
                    Padding(
                      padding: EdgeInsets.only(top: kSize.height * 0.024, bottom: kSize.height * 0.024),
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
                      items: employeeController.employeeTypes,
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
                      child: addEventContoller.isLoading
                          ? const Center(
                              child: CircularProgressIndicator(
                                color: AppColors.primaryColor,
                              ),
                            )
                          : FooterButton(
                              label: AppStrings.saveText,
                              onTap: () async {
                                try {
                                  // save event
                                  if (addEventContoller.eventId != 0) {
                                    final response =
                                        await addEventContoller.updateEvent(authController.accesToken!);
                                    if (response) {
                                      rootScaffoldMessengerKey.currentState!.showSnackBar(
                                          snackBarWidget('Updated Successfully!', color: Colors.green));
                                      if (context.mounted) {
                                        addEventContoller.isLoading = false;
                                        Navigator.pop(context);
                                        // Future.delayed(const Duration(seconds: 1));
                                        // addEventContoller.clearData();
                                      }
                                    }
                                  } else {
                                    bool response =
                                        await addEventContoller.saveEvent(authController.accesToken);
                                    if (response) {
                                      rootScaffoldMessengerKey.currentState!.showSnackBar(
                                          snackBarWidget('Succesfully Created!', color: Colors.green));
                                      if (context.mounted) {
                                        addEventContoller.isLoading = false;
                                        Navigator.pop(context);
                                      }
                                    }
                                  }
                                } catch (e) {
                                  rootScaffoldMessengerKey.currentState!
                                      .showSnackBar(snackBarWidget('$e', color: Colors.red));
                                  addEventContoller.isLoading = false;
                                }
                              }),
                    ),
                  ],
                ),
              ),
            )),
      ),
    );
  }

  Widget eventID(String? eventCode, AddEventController controller, Size kSize) {
    return Padding(
      padding: EdgeInsets.only(bottom: kSize.height * 0.024),
      child: CustomTextField(
        text: 'Event Code',
        required: true,
        hintText: "Code",
        validator: controller.eventCodeValidator,
        controller: controller.eventCode,
        onSave: (code) {
          // controller.event.code = code;
        },
      ),
    );
    /*  return RichText(
        text: TextSpan(
            text: AppStrings.eventCodeText,
            style: AppTypography.poppinsMedium.copyWith(fontSize: 16, color: AppColors.secondaryColor),
            children: [
          TextSpan(
              text: eventCode != null ? "     $eventCode" : '',
              style: AppTypography.poppinsRegular.copyWith(
                fontSize: 16,
                color: AppColors.secondaryColor.withOpacity(0.6),
              ))
        ])); */
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
            getDate: (date) {
              controller.eventDateTime = date;
              log("${controller.eventDateTime}");
            },
            onSaved: (value) {
              // controller.event.scheduleDateTime = controller.eventDateTime;
            },
            onChanged: (value) {},
          ),
          CustomDatePicker(
              controller: controller.scheduledTime,
              type: 'Time',
              label: 'Time',
              getTime: (startTime) {
                controller.eventTime = startTime;
                /* controller.event.scheduleDateTime = DateTime(
                  controller.event.scheduleDateTime!.year,
                  controller.event.scheduleDateTime!.month,
                  controller.event.scheduleDateTime!.day,
                  startTime.hour,
                  startTime.minute,
                ); */
              },
              onSaved: (value) {
                controller.eventDateTime = DateTime(
                    controller.eventDateTime!.year,
                    controller.eventDateTime!.month,
                    controller.eventDateTime!.day,
                    controller.eventTime!.hour,
                    controller.eventTime!.minute);
                // controller.event.scheduleDateTime = controller.eventDateTime!.toIso8601String();
                log(controller.eventDateTime!.toIso8601String());
                controller.event.scheduledDatetime =
                    DateFormat("yyyy-MM-dd'T'HH:mm:ss.SSS'Z'").format(controller.eventDateTime!);
                // DateFormat('yyyy-MM-dd HH:mm:ss').format(controller.eventDateTime!);
                // log(controller.event.scheduleDateTime!);
                /*  controller.event.scheduleDateTime = DateTime(
                  controller.eventDateTime!.year,
                  controller.eventDateTime!.month,
                  controller.eventDateTime!.day,
                  controller.eventTime!.hour,
                  controller.eventTime!.minute,
                ); */
              },
              onChanged: (value) {
                log(value);
                DateTime time = DateTime.parse(value);
                log("time >> $time ");
                String formatTime = DateFormat().format(time);
                log("${DateFormat().format(DateTime.parse(value))}");
              })
        ],
      ),
    );
  }

  AppBar appBar(BuildContext context, Size kSize) {
    final addEventController = context.watch<AddEventController>();
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
        addEventController.eventId != 0 ? "Update Event Site" : AppStrings.createEventText,
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
            maxLines: 1,
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
            maxLines: 1,
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
