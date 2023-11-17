import 'package:evantez/src/controller/auth/auth_controller.dart';
import 'package:evantez/src/controller/events/event_type_controller.dart';
import 'package:evantez/src/model/components/snackbar_widget.dart';
import 'package:evantez/src/view/core/constants/constants.dart';
import 'package:evantez/src/view/core/themes/colors.dart';
import 'package:evantez/src/view/core/themes/typography.dart';
import 'package:evantez/src/view/core/widgets/custom_back_btn.dart';
import 'package:evantez/src/view/core/widgets/custom_textfield.dart';
import 'package:evantez/src/view/core/widgets/footer_button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class NewEventType extends StatelessWidget {
  const NewEventType({super.key});

  @override
  Widget build(BuildContext context) {
    final kSize = MediaQuery.of(context).size;
    final authController = context.watch<AuthController>();
    final newEventTypeController = context.watch<EventTypeController>();
    return Scaffold(
      appBar: appBar(context, kSize),
      body: Form(
        key: newEventTypeController.eventTypeForm,
        child: SizedBox(
          height: kSize.height,
          width: kSize.width,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: AppConstants.baseBorderRadius),
            child: Column(
              children: [                
                CustomTextField(
                  text: "Event Type",
                  hintText: 'Enter Type',
                  controller: newEventTypeController.eventTypeTxt,
                  validator: newEventTypeController.eventTypeValidator,
                  required: true,
                  onSave: (value) {
                    if (value != null && value.trim().isNotEmpty) {
                      newEventTypeController.eventType!.name = value;
                    }
                  },
                ),
                const Spacer(),
                newEventTypeController.isLoading
                    ? const Center(
                        child: CircularProgressIndicator(color: AppColors.primaryColor),
                      )
                    : Padding(
                        padding: EdgeInsets.only(bottom: kSize.height * 0.032),
                        child: FooterButton(
                            label: newEventTypeController.eventType!.id! > 0? "Update":"Save",
                            onTap: () async {
                              if (newEventTypeController.eventTypeForm.currentState!.validate()) {                                
                                  newEventTypeController.eventTypeForm.currentState!.save();
                                  await newEventTypeController
                                      .addEventType(token: authController.accesToken!, data: newEventTypeController.eventType!)
                                      .then((eventType) async {
                                    if (eventType.id != 0) {
                                      ScaffoldMessenger.of(context).showSnackBar(snackBarWidget(
                                          'Event Type ${newEventTypeController.eventType!.id! > 0? 'Updated':'Added'} Successfully!',
                                          color: Colors.green,
                                          duration: const Duration(seconds: 2)));
                                      await newEventTypeController.getEventTypeList(
                                          token: authController.accesToken!);
                                      newEventTypeController.intiLoading();
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
                            ),
                      )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

AppBar appBar(BuildContext context, Size kSize) {
    return AppBar(
      elevation: 0,
      leading: const CustomBackButton(),
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      centerTitle: true,
      title: Text(
        "Event Type",
        style: AppTypography.poppinsSemiBold.copyWith(),
      ),
    );
  }