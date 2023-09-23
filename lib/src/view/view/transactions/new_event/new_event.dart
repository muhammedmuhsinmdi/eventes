import 'dart:developer';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:evantez/src/model/components/snackbar_widget.dart';

import 'package:evantez/src/view/core//constants/app_strings.dart';
import 'package:evantez/src/view/core//constants/constants.dart';
import 'package:evantez/src/view/core//themes/colors.dart';
import 'package:evantez/src/view/core//widgets/custom_back_btn.dart';
import 'package:evantez/src/view/core//widgets/custom_date_picker.dart';
import 'package:evantez/src/view/core//widgets/custom_drop_down.dart';
import 'package:evantez/src/view/core//widgets/custom_textfield.dart';
import 'package:evantez/src/view/core//widgets/footer_button.dart';
import 'package:evantez/src/view/view/transactions/new_event/widgets/custom_service_counter.dart';
import 'package:evantez/src/view/view/transactions/new_event/widgets/event_image_upload.dart';
import 'package:evantez/src/view/view/transactions/new_event/widgets/filter_boys_rating.dart';
import 'package:evantez/src/view/view/transactions/new_event/widgets/service_boys.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../model/repository/auth/auth_controller.dart';
import '../../../../model/repository/events/events_controller.dart';

import '../../../../serializer/models/event_site_model.dart';
import '../../../core/themes/typography.dart';

class NewEventView extends StatefulWidget {
  const NewEventView({super.key});
  @override
  State<NewEventView> createState() => _NewEventViewState();
}

class _NewEventViewState extends State<NewEventView> {
  List<String> serviceReq = [
    "Head",
    "Captain",
    "Hosting",
  ];

  @override
  Widget build(BuildContext context) {
    final controller = context.watch<EventController>();
    final authcontroller = context.watch<AuthController>();
    final kSize = MediaQuery.of(context).size;
    String? eventtype;
    String? eventvenu;
    File? imagefile;
    String? customername;
    String? customerphone;
    String? customeraddress;
    String? additionalnote;
    String? normalhours;
    String? addtionalhours;
    String? scheduleddate;
    String? scheduledtime;

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
                Divider(
                  color: AppColors.secondaryColor.withOpacity(0.2),
                ),
                SizedBox(
                  height: kSize.height * 0.024,
                ),
                eventType(
                  eventTypes: const [
                    "Marriage Function",
                    "Nikkhah",
                    "Meetings",
                    "House Warming"
                  ],
                  onSelected: (eventType) {
                    eventtype = eventType;
                  },
                ),
                SizedBox(
                  height: kSize.height * 0.024,
                ),
                eventVenue(
                    eventVenues: const [
                      "Malappuram",
                      "Valenchery",
                      "Palakkad",
                      "Manjeri"
                    ],
                    onSelected: (venue) {
                      eventvenu = venue;
                    }),
                SizedBox(
                  height: kSize.height * 0.024,
                ),
                dateTime(onSelectDate: (date) {
                  scheduleddate = date;
                }, onSelectTime: (time) {
                  scheduledtime = time;
                }),
                SizedBox(
                  height: kSize.height * 0.024,
                ),
                CustomTextField(
                  text: AppStrings.customerName,
                  required: true,
                  hintText: "Name",
                  onChanged: (customerName) {
                    customername = customerName;
                  },
                ),
                SizedBox(
                  height: kSize.height * 0.024,
                ),
                CustomTextField(
                  text: AppStrings.phoneText,
                  required: true,
                  hintText: "Phone Number",
                  onChanged: (phone) {
                    customerphone = phone;
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
                  onChanged: (address) {
                    customeraddress = address;
                  },
                ),
                SizedBox(
                  height: kSize.height * 0.024,
                ),
                CustomTextField(
                  text: 'Additional Information',
                  hintText: "Notes/Instructions",
                  onChanged: (notes) {
                    additionalnote = notes;
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
                      normalhours = workingHours;
                    },
                    getOverTimeRate: (overTimeRate) {
                      addtionalhours = overTimeRate;
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
                    items: serviceReq,
                    onSelected: (serviceBoysList) {
                      //
                    }),
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
                      int? eventTypeid;
                      int? eventVenueId;
                      int? empTypeId;

                      if (imagefile == null) {
                        ScaffoldMessenger.of(context).showSnackBar(
                            snackBarWidget('Please select an Image',
                                color: Colors.black26,
                                duration: const Duration(seconds: 2)));
                      } else {
                        if (eventtype == null ||
                            eventvenu == null ||
                            customername == null ||
                            customeraddress == null ||
                            // customerphone == null ||
                            // scheduledtime == null ||
                            // scheduleddate == null ||
                            addtionalhours == null ||
                            normalhours == null) {
                          ScaffoldMessenger.of(context).showSnackBar(
                              snackBarWidget('Please Fill all the Parameter',
                                  color: Colors.black26,
                                  duration: const Duration(seconds: 2)));
                        } else {
                          // -=-= -=--=-=-=-=-= EventType -=-=-=-=-==-=--=-

                          await controller
                              .addEventType(
                                  token: authcontroller.accesToken ?? '',
                                  eventadd: eventtype!)
                              .then((value) {
                            eventTypeid = value.id;
                          });

                          // -=-=-=-=-=-=-=-=- Event Venue -=-=-=-=-=-=-=-=-=-=-=-

                          FormData formData = FormData.fromMap({
                            'name': eventvenu,
                            'image': await MultipartFile.fromFile(
                              imagefile!.path,
                              filename: imagefile!.path.split('/').last,
                            ),
                            'lat': '23.075689',
                            'log': '72.772426',
                          });

                          await controller
                              .addEventvenue(
                                  token: authcontroller.accesToken ?? '',
                                  data: formData)
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
                      }
                    }),
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

  Widget eventID(String eventCode) {
    return RichText(
        text: TextSpan(
            text: AppStrings.eventCodeText,
            style: AppTypography.poppinsMedium
                .copyWith(fontSize: 16, color: AppColors.secondaryColor),
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
  Widget eventType(
      {required List<String> eventTypes,
      required Function(String) onSelected}) {
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

  Widget eventVenue(
      {required List<String> eventVenues,
      required Function(String) onSelected}) {
    return CustomDropDown(
      label: "Event Venue",
      required: true,
      onSelected: (eventVenue) {
        log(eventVenue);
        onSelected(eventVenue);
      },
      hintText: "Select Event Venue",
      items:
          eventVenues, // const ["Malappuram", "Valenchery", "Palakkad", "Manjeri"],
    );
  }

  Widget dateTime(
      {required Function(String) onSelectDate,
      required Function(String) onSelectTime}) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        CustomDatePicker(
            controller: TextEditingController(),
            type: "Date",
            label: "Date",
            onChanged: (value) {
              onSelectDate(value);
            }),
        CustomDatePicker(
            controller: TextEditingController(),
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
      // mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        SizedBox(
          width: kSize.width * 0.17,
          child: Text(
            "Normal Hours",
            textAlign: TextAlign.end,
            maxLines: 2,
            style: AppTypography.poppinsMedium
                .copyWith(color: AppColors.secondaryColor.withOpacity(0.6)),
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
            onChanged: (workingHours) {
              getNormalHours(workingHours);
            },
            suffixIcon: Padding(
              padding: EdgeInsets.only(top: kSize.height * 0.015),
              child: Text(
                'Hrs',
                textAlign: TextAlign.end,
                style: AppTypography.poppinsSemiBold
                    .copyWith(color: AppColors.secondaryColor, fontSize: 16),
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
            style: AppTypography.poppinsMedium
                .copyWith(color: AppColors.secondaryColor.withOpacity(0.6)),
          ),
        ),
        SizedBox(
          width: kSize.width * 0.015,
        ),
        Flexible(
          child: CustomTextField(
            keyboardType: TextInputType.number,
            text: '',
            onChanged: (rate) {
              getOverTimeRate(rate);
            },
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
              ? FooterButton(
                  fillColor: AppColors.transparent,
                  label: "Add +",
                  onTap: () {
                    // serviceReq.length++;
                  },
                )
              : CustomServiceCounter(
                  label: "",
                  items: serviceReq,
                ),
        ),
      ),
    );
  }
}
