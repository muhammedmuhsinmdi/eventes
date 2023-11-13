import 'package:cached_network_image/cached_network_image.dart';
import 'package:evantez/src/controller/events/events_controller.dart';
import 'package:evantez/src/model/core/models/event_site/event_site_model.dart';
import 'package:evantez/src/serializer/models/event_response.dart';
import 'package:evantez/src/view/core//constants/constants.dart';
import 'package:evantez/src/view/core//themes/colors.dart';
import 'package:evantez/src/view/core//themes/typography.dart';
import 'package:evantez/src/view/core/widgets/time.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class EventTile extends StatefulWidget {
  final bool? isBoy;
  final EventSiteModel event;
  final EventsVenue? eventVenue;
  const EventTile({super.key, this.isBoy = false, this.eventVenue, required this.event});

  @override
  State<EventTile> createState() => _EventTileState();
}

class _EventTileState extends State<EventTile> {
  late EventController eventController;

  EventsVenue? eventVenue;

  @override
  void initState() {
    if (widget.eventVenue != null) {
      eventVenue = widget.eventVenue;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    eventController = context.watch<EventController>();
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
                      apiFormat.format(/* eventList[i].createdAt ?? */ DateTime.now()),
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
          if (!widget.isBoy!) ...{
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
        "${widget.event.status}",
        style: AppTypography.poppinsRegular.copyWith(
          fontSize: 12,
        ),
      ),
    );
  }
}
