import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:evantez/app/app.dart';
import 'package:evantez/src/controller/auth/auth_controller.dart';
import 'package:evantez/src/controller/events/events_controller.dart';
import 'package:evantez/src/model/components/snackbar_widget.dart';
import 'package:evantez/src/model/core/models/event_site/event_site_model.dart';
import 'package:evantez/src/serializer/models/event_model.dart';
import 'package:evantez/src/serializer/models/event_response.dart';
import 'package:evantez/src/view/core//constants/constants.dart';
import 'package:evantez/src/view/core//themes/colors.dart';
import 'package:evantez/src/view/core//themes/typography.dart';
import 'package:evantez/src/view/core/widgets/custom_dialogbox.dart';
import 'package:evantez/src/view/core/widgets/time.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class EventTile extends StatefulWidget {
  final bool? isBoy;
  final EventSiteModel event;
  final EventVenue? eventVenue;
  const EventTile({super.key, this.isBoy = false, this.eventVenue, required this.event});

  @override
  State<EventTile> createState() => _EventTileState();
}

class _EventTileState extends State<EventTile> {
  late EventController eventController;

  EventVenue? eventVenue;

  @override
  void initState() {
    if (widget.eventVenue != null) {
      eventVenue = widget.eventVenue;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final authController = context.watch<AuthController>();
    eventController = context.watch<EventController>();
    final kSize = MediaQuery.of(context).size;
    return SizedBox(
      width: kSize.width,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                clipBehavior: Clip.antiAlias,
                decoration: BoxDecoration(borderRadius: BorderRadius.circular(8)),
                margin: EdgeInsets.only(right: kSize.width * 0.024),
                height: kSize.height * 0.085,
                width: kSize.height * 0.085,
                child: eventVenue != null
                    ? CachedNetworkImage(
                        imageUrl: eventVenue!.image ?? "",
                        errorWidget: (context, url, error) {
                          return const SizedBox();
                        },
                      )
                    : const SizedBox(),
              ),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      eventVenue!.name!,
                      style:
                          AppTypography.poppinsMedium.copyWith(color: AppColors.secondaryColor, fontSize: 14),
                    ),
                    SizedBox(
                      height: kSize.height * 0.003,
                    ),
                    Text(
                      apiFormat.format(widget.event.scheduledDatetime!),
                      style: AppTypography.poppinsRegular.copyWith(
                        color: AppColors.secondaryColor,
                        fontSize: 12,
                      ),
                    ),
                    SizedBox(
                      height: kSize.height * 0.003,
                    ),
                    Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                      Text(
                        DateFormat("hh:mm a").format(widget.event.scheduledDatetime!),
                        style: AppTypography.poppinsRegular.copyWith(
                          color: AppColors.secondaryColor,
                        ),
                      ),
                      eventStatus(eventController),
                    ])
                  ],
                ),
              ),
              /* SizedBox(
                width: kSize.width * 0.1,
                child: PopupMenuButton<String>(
                  initialValue: 'delete',
                  // Callback that sets the selected popup menu item.
                  onSelected: (item) {
                    if (item == 'delete') {
                      log("delete");
                      showDialog(
                          context: context,
                          builder: (context) {
                            return CustomDialog(
                                title: "Are you sure you want this Event?",
                                onConfirmTxt: "Delete",
                                onConfirm: () {
                                  // confirm
                                  if (context.mounted) {
                                    Navigator.pop(context);
                                  }
                                  eventController
                                      .deleteEvent(
                                          token: authController.accesToken!, eventId: widget.event.id!)
                                      .then((value) async {
                                    if (value) {
                                      await eventController.events(authController.accesToken!);
                                      rootScaffoldMessengerKey.currentState!.showSnackBar(
                                          snackBarWidget('Successfully deleted!', color: Colors.green));
                                      await Future.delayed(const Duration(seconds: 2));
                                    } else {
                                      rootScaffoldMessengerKey.currentState!
                                          .showSnackBar(snackBarWidget('Delete failed!', color: Colors.red));
                                      await Future.delayed(const Duration(seconds: 2));
                                    }
                                  });
                                });
                          });
                    }
                  },
                  clipBehavior: Clip.antiAlias,
                  padding: EdgeInsets.symmetric(horizontal: kSize.height * 0.024),
                  shape: RoundedRectangleBorder(
                      side: const BorderSide(
                        color: AppColors.accentColor,
                      ),
                      borderRadius: BorderRadius.circular(
                        AppConstants.basePadding,
                      )),

                  itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
                    PopupMenuItem<String>(
                      padding: EdgeInsets.symmetric(
                        horizontal: kSize.width * 0.05,
                      ),
                      value: "delete",
                      child: Text(
                        'Delete',
                        textAlign: TextAlign.start,
                        style: AppTypography.poppinsMedium.copyWith(),
                      ),
                    ),
                  ],
                ),
              ), */
            ],
          ),
          if (!widget.isBoy!) ...{
            SizedBox(
              height: kSize.height * 0.008,
            ),
            eventProgressLine(kSize, widget.event.progress!),
          }
        ],
      ),
    );
  }

  Widget eventProgressLine(Size kSize, int progress) {
    return Container(
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25),
      ),
      height: kSize.height * 0.005,
      width: kSize.height * 0.085,
      child: LinearProgressIndicator(
        value: double.parse("$progress"),
        color: AppColors.statusSuccess,
      ),
    );
  }

  Widget eventStatus(EventController controller) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppConstants.marginSpace,
        vertical: AppConstants.smallPadding,
      ),
      decoration: BoxDecoration(
          color: AppColors.secondaryColor.withOpacity(0.4),
          borderRadius: BorderRadius.circular(AppConstants.basePadding)),
      child: Text(
        "${widget.event.status}",
        style: AppTypography.poppinsRegular.copyWith(
          fontSize: 12,
        ),
      ),
    );
  }
}
