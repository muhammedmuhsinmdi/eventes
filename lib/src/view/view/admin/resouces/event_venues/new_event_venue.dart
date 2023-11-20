import 'package:dio/dio.dart';
import 'package:evantez/src/controller/auth/auth_controller.dart';
import 'package:evantez/src/controller/events/new_event_venue_controller.dart';
import 'package:evantez/src/model/components/snackbar_widget.dart';
import 'package:evantez/src/serializer/models/event_model.dart';
import 'package:evantez/src/view/core/constants/constants.dart';
import 'package:evantez/src/view/core/themes/colors.dart';
import 'package:evantez/src/view/core/themes/typography.dart';
import 'package:evantez/src/view/core/widgets/custom_back_btn.dart';
import 'package:evantez/src/view/core/widgets/custom_textfield.dart';
import 'package:evantez/src/view/core/widgets/footer_button.dart';
import 'package:evantez/src/view/view/admin/transactions/new_event/widgets/event_image_upload.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class NewEventVenue extends StatelessWidget {
  const NewEventVenue({super.key});

  @override
  Widget build(BuildContext context) {
    final kSize = MediaQuery.of(context).size;
    final authController = context.watch<AuthController>();
    final newEventVenueController = context.watch<EventVenueController>();
    return Scaffold(
      appBar: appBar(context, kSize),
      body: Form(
        key: newEventVenueController.eventVenueForm,
        child: SizedBox(
          height: kSize.height,
          width: kSize.width,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: AppConstants.baseBorderRadius),
            child: Column(
              children: [
                EventImageUpload(
                  imgUrl: newEventVenueController.eventVenue.text ,
                  onPicked: (pickedImage) {
                  newEventVenueController.eventImage = pickedImage;
                }),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: kSize.height * 0.032),
                  child: Divider(
                    color: AppColors.secondaryColor.withOpacity(0.2),
                  ),
                ),
                CustomTextField(
                  text: "Event Venue",
                  hintText: 'Enter Venue',
                  controller: newEventVenueController.eventVenue,
                  validator: newEventVenueController.eventVenueValidator,
                  required: true,
                  onSave: (value) {
                    if (value != null) {
                      newEventVenueController.eventVenue.text = value;
                    }
                  },
                ),
                const Spacer(),
                newEventVenueController.isLoading
                    ? const Center(
                        child: CircularProgressIndicator(color: AppColors.primaryColor),
                      )
                    : Padding(
                        padding: EdgeInsets.only(bottom: kSize.height * 0.032),
                        child: FooterButton(
                            label: "Save",
                            onTap: () async {
                              if (newEventVenueController.eventVenueForm.currentState!.validate()) {
                                if (newEventVenueController.eventImage != null) {
                                  FormData formData = FormData.fromMap({
                                    'name': newEventVenueController.eventVenue.text,
                                    'image': await MultipartFile.fromFile(
                                      newEventVenueController.eventImage!.path,
                                      filename: newEventVenueController.eventImage!.path.split('/').last,
                                    ),
                                    'lat': '23.075689',
                                    'log': '72.772426',
                                  });

                                  await newEventVenueController
                                      .addEventvenue(token: authController.accesToken!, data: formData)
                                      .then((eventVenue) async {
                                    if (eventVenue.id != 0) {
                                      ScaffoldMessenger.of(context).showSnackBar(snackBarWidget(
                                          'Event Venue added Successfully!',
                                          color: Colors.green,
                                          duration: const Duration(seconds: 2)));
                                      await newEventVenueController.getEventVenueList(
                                          token: authController.accesToken!);
                                      newEventVenueController.intiLoading();
                                      if (context.mounted) {
                                        Navigator.pop(context);
                                      }
                                    }
                                  });
                                } else {
                                  ScaffoldMessenger.of(context).showSnackBar(snackBarWidget(
                                      'Please select an Image',
                                      color: Colors.black26,
                                      duration: const Duration(seconds: 2)));
                                }
                              }
                            }),
                      )
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
        "New Event Venue",
        style: AppTypography.poppinsSemiBold.copyWith(),
      ),
    );
  }
}
