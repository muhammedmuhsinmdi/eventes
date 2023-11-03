import 'dart:developer';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:evantez/src/controller/events/events_controller.dart';
import 'package:evantez/src/controller/resources/employee/employee_controller.dart';
import 'package:evantez/src/controller/transaction/new_event/new_event_controller.dart';
import 'package:evantez/src/model/components/snackbar_widget.dart';

import 'package:evantez/src/view/core//constants/app_strings.dart';
import 'package:evantez/src/view/core//constants/constants.dart';
import 'package:evantez/src/view/core//themes/colors.dart';
import 'package:evantez/src/view/core//widgets/custom_back_btn.dart';
import 'package:evantez/src/view/core//widgets/custom_date_picker.dart';
import 'package:evantez/src/view/core//widgets/custom_drop_down.dart';
import 'package:evantez/src/view/core//widgets/custom_textfield.dart';
import 'package:evantez/src/view/core//widgets/footer_button.dart';
import 'package:evantez/src/view/view/admin/transactions/new_event/widgets/event_image_upload.dart';
import 'package:evantez/src/view/view/admin/transactions/new_event/widgets/event_type_dropdown.dart';
import 'package:evantez/src/view/view/admin/transactions/new_event/widgets/filter_boys_rating.dart';
import 'package:evantez/src/view/view/admin/transactions/new_event/widgets/service_boys.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../controller/auth/auth_controller.dart';

import '../../../../core/themes/typography.dart';

class NewEventView extends StatefulWidget {
  const NewEventView({super.key});
  @override
  State<NewEventView> createState() => _NewEventViewState();
}

class _NewEventViewState extends State<NewEventView> {
  late EmployeesController employeeController;
  late EventController controller;
  late AuthController authcontroller;
  late NewEventController newEventController;

  final _formKey = GlobalKey<FormState>();

  List<String> serviceReq = [
    "Head",
    "Captain",
    "Hosting",
  ];

  List<String> eventTypeList = const ["Marriage Function", "Nikkhah", "Meetings", "House Warming"];

  String? eventtype;
  File? imagefile;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      /*  await employeeController.employeeTypesData(token: authcontroller.accesToken!);
      log(" employee types >>>> ${employeeController.employeeTypesList.length}"); */
      newEventController.initData();
      await newEventController.getEventTypes(authcontroller.accesToken!);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    employeeController = context.watch<EmployeesController>();
    // controller = context.watch<EventController>();
    newEventController = context.watch<NewEventController>();
    authcontroller = context.watch<AuthController>();
    final kSize = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: appBar(context, kSize),
      body: Form(
        key: _formKey,
        child: SizedBox(
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
                  eventID("EV24215"),
                  EventImageUpload(
                    onPicked: (eventImage) {
                      // You will the image file here
                      // eventImage

                      imagefile = eventImage;
                    },
                  ),
                  SizedBox(
                    height: kSize.height * 0.032,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: kSize.height * 0.032),
                    child: Divider(
                      color: AppColors.secondaryColor.withOpacity(0.2),
                    ),
                  ),
                  SizedBox(
                    height: kSize.height * 0.024,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: kSize.height * 0.024),
                    child: EventTypeDropDown(
                      intialValue: newEventController.eventTypeString,
                      eventTypes: newEventController.eventTypeList,
                      onSelected: (eventType) {
                        newEventController.eventModel.eventTypeId = eventType.id!;
                        newEventController.eventTypeString = newEventController.eventTypeList
                            .firstWhere((e) => e.id == newEventController.eventModel.eventTypeId)
                            .name!;
                      },
                    ),
                  ),
                  SizedBox(
                    height: kSize.height * 0.024,
                  ),
                  CustomTextField(
                    text: "Event Venue",
                    hintText: 'Enter Venue',
                    controller: newEventController.eventVenue,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Enter Event Venue';
                      }
                      return null;
                    },
                    required: true,
                    onChanged: (eventVenue) {
                      log(eventVenue);
                    },
                  ),
                  SizedBox(
                    height: kSize.height * 0.024,
                  ),
                  dateTime(onSelectDate: (date) {
                    newEventController.scheduledDate.text = date;
                  }, onSelectTime: (time) {
                    newEventController.scheduledTime.text = time;
                  }),
                  SizedBox(
                    height: kSize.height * 0.024,
                  ),
                  CustomTextField(
                    text: AppStrings.customerName,
                    required: true,
                    hintText: "Name",
                    controller: newEventController.customerName,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Enter Customer Name";
                      }
                      return null;
                    },
                    onChanged: (name) {
                      newEventController.eventModel.customerName = name;
                    },
                  ),
                  SizedBox(
                    height: kSize.height * 0.024,
                  ),
                  CustomTextField(
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
                    controller: newEventController.customerPhone,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Enter Customer Phone";
                      }
                      return null;
                    },
                    onChanged: (phone) {
                      newEventController.eventModel.customerPhone = phone;
                      // customerPhone.text = phone;
                    },
                  ),
                  SizedBox(
                    height: kSize.height * 0.024,
                  ),
                  CustomTextField(
                    text: AppStrings.address,
                    required: true,
                    maxLines: 2,
                    hintText: "Address",
                    controller: newEventController.customerAddress,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Enter Customer Address";
                      }
                      return null;
                    },
                    onChanged: (address) {
                      newEventController.eventModel!.customerAddress = address;
                      // customeraddress.text = address;
                    },
                  ),
                  SizedBox(
                    height: kSize.height * 0.024,
                  ),
                  CustomTextField(
                    text: 'Additional Information',
                    hintText: "Notes/Instructions",
                    controller: newEventController.additionalInfo,
                    onChanged: (notes) {
                      newEventController.eventModel.notes = notes;
                      // additionalnote.text = notes;
                    },
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
                  overTimeDetail(
                      kSize: kSize,
                      getNormalHours: (workingHours) {
                        newEventController.eventModel!.normalHours = workingHours;
                        // normalhours.text = workingHours;
                      },
                      getOverTimeRate: (overTimeRate) {
                        newEventController.eventModel!.overtimeHourlyCharge = overTimeRate;
                        // addtionalhours.text = overTimeRate;
                      }),
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
                  ServiceBoys(
                    items: employeeController.employeeTypesList,
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
                    AppStrings.filterBoysText,
                    style: AppTypography.poppinsSemiBold.copyWith(
                      color: AppColors.secondaryColor,
                    ),
                  ),
                  SizedBox(
                    height: kSize.height * 0.018,
                  ),
                  FilterBoysRating(
                    onSelected: (rating) {
                      log(rating);
                    },
                  ),
                  SizedBox(
                    height: kSize.height * 0.032,
                  ),
                  FooterButton(
                      label: "Save",
                      onTap: () async {
                        if (_formKey.currentState!.validate()) {
                          newEventController.eventModel!.code = "EV006";
                          if (newEventController.eventVenue.text.isNotEmpty) {
                            if (imagefile != null) {
                              FormData formData = FormData.fromMap({
                                'name': newEventController.eventVenue.text,
                                'image': await MultipartFile.fromFile(
                                  imagefile!.path,
                                  filename: imagefile!.path.split('/').last,
                                ),
                                'lat': '23.075689',
                                'log': '72.772426',
                              });

                              await newEventController
                                  .addEventvenue(token: authcontroller.accesToken!, data: formData)
                                  .then((eventVenue) {
                                if (eventVenue.id != 0) {
                                  newEventController.eventModel.venueId = eventVenue.id!;
                                  log("${newEventController.eventModel.venueId}");
                                }
                              });
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(snackBarWidget(
                                  'Please select an Image',
                                  color: Colors.black26,
                                  duration: const Duration(seconds: 2)));
                            }
                            newEventController.eventModel!.status = 'Upcoming - Hold';
                            newEventController.addEventSite(token: authcontroller.accesToken!);
                            // }
                          }
                        }
                        /* int? eventTypeid;
                        int? eventVenueId;
                        int? empTypeId;

                        if (imagefile == null) {
                          ScaffoldMessenger.of(context).showSnackBar(snackBarWidget('Please select an Image',
                              color: Colors.black26, duration: const Duration(seconds: 2)));
                        } else {
                          if (eventtype == null ||
                              eventVenue.text.isEmpty ||
                              customerName.text.isEmpty ||
                              customeraddress.text.isEmpty ||
                              // customerphone == null ||
                              // scheduledtime == null ||
                              // scheduleddate == null ||
                              addtionalhours.text.isEmpty ||
                              normalhours.text.isEmpty) {
                            ScaffoldMessenger.of(context).showSnackBar(snackBarWidget(
                                'Please Fill all the Parameter',
                                color: Colors.black26,
                                duration: const Duration(seconds: 2)));
                          } else {
                            // -=-= -=--=-=-=-=-= EventType -=-=-=-=-==-=--=-

                            await controller
                                .addEventType(token: authcontroller.accesToken ?? '', eventadd: eventtype!)
                                .then((value) {
                              eventTypeid = value.id;
                            });

                            // -=-=-=-=-=-=-=-=- Event Venue -=-=-=-=-=-=-=-=-=-=-=-

                            FormData formData = FormData.fromMap({
                              'name': eventVenue.text,
                              'image': await MultipartFile.fromFile(
                                imagefile!.path,
                                filename: imagefile!.path.split('/').last,
                              ),
                              'lat': '23.075689',
                              'log': '72.772426',
                            });

                            await controller
                                .addEventvenue(token: authcontroller.accesToken ?? '', data: formData)
                                .then((value) {
                              eventVenueId = value.id;
                            }

                                    // -=-=-=-=-=-=-=-= EventSite Add -=-=-=-=-=-=-=-=-=-=

                                    // await controller.eventSiteAdd(
                                    //   token: authcontroller.accesToken ?? '',
                                    //   eventSite: EventSite(
                                    //       eventTypeId: eventTypeid,
                                    //       venueId: eventVenueId,
                                    //       scheduledDatetime:
                                    //           '2023-07-14T06:59:34.349688Z',
                                    //       customerName: customername,
                                    //       customerPhone: customerphone,
                                    //       customerAddress: customeraddress,
                                    //       notes: additionalnote,
                                    //       normalHours: normalhours,
                                    //       overtimeHourlyCharge: addtionalhours,
                                    //       eventSiteSettings: [
                                    //         EventSiteSettings(
                                    //           service: 1,
                                    //         )
                                    //       ],
                                    //       eventSiteEmployeeRequirement: [
                                    //         EventSiteEmployeeRequirement(
                                    //           charge: '300',
                                    //           employeeType: 3,
                                    //           requirementCount: 3,
                                    //         )
                                    //       ],
                                    //       code: "EVC001",
                                    //       status: 'open'),

                                    //-=-=-=-=-=-=-=-=--= Employee Type -=-=-=-=-=-=-=-=-=-=
                                    // await controller
                                    //     .employeeType(
                                    //   token: authcontroller.accesToken ?? '',
                                    //   name: 'Name',
                                    //   amount: 500,
                                    //   code: 'Code',
                                    // )
                                    //     .then((value) {
                                    //   print(value.id);
                                    // })
                                    );
                          }
                        } */
                      }),
                  SizedBox(
                    height: kSize.height * 0.12,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  AppBar appBar(BuildContext context, Size kSize) {
    return AppBar(
      elevation: 0,
      leading: CustomBackButton(
        onTap: () {
          imagefile = null;
          eventtype = '';
          newEventController.eventType = null;
          newEventController.eventVenue.clear();
          newEventController.customerName.clear();
          newEventController.customerPhone.clear();
          newEventController.customerAddress.clear();
          newEventController.additionalInfo.clear();
          newEventController.normalHours.clear();
          newEventController.overTimeRate.clear();
          newEventController.scheduledDate.clear();
          newEventController.scheduledTime.clear();
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

  /*  Widget uploadImage(
      {required BuildContext context, required Size kSize, required Function(File) onPickedImage}) {
    File? image;
    return ;
  } */
  Widget eventType({required List<String> eventTypes, required Function(String) onSelected}) {
    return CustomDropDown(
      label: "Type of Event",
      required: true,
      hintText: "Select Event Type",
      onSelected: (eventType) {
        onSelected(eventType);
      },
      items: eventTypes,
    );
  }

  Widget dateTime({required Function(String) onSelectDate, required Function(String) onSelectTime}) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        CustomDatePicker(
          controller: newEventController.scheduledDate,
          type: "Date",
          label: "Date",
          onChanged: (value) {
            onSelectDate(value);
          },
        ),
        CustomDatePicker(
            controller: newEventController.scheduledTime,
            type: 'Time',
            label: 'Time',
            onChanged: (value) {
              onSelectTime(value);
            })
      ],
    );
  }

  Widget overTimeDetail(
      {required Size kSize,
      required Function(String) getNormalHours,
      required Function(String) getOverTimeRate}) {
    return Row(
      mainAxisSize: MainAxisSize.max,
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
          // width: kSize.width * 0.2,
          child: CustomTextField(
            text: '',
            controller: newEventController.normalHours,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return "Enter Normal Hours";
              }
              return null;
            },
            keyboardType: TextInputType.number,
            onChanged: (workingHours) {
              getNormalHours(workingHours);
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
            controller: newEventController.overTimeRate,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return "Enter Overtime Rates";
              }
              return null;
            },
            onChanged: (rate) {
              getOverTimeRate(rate);
            },
          ),
        ),
      ],
    );
  }
}
