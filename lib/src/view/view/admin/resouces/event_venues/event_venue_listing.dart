import 'package:cached_network_image/cached_network_image.dart';
import 'package:evantez/app/app.dart';
import 'package:evantez/app/router/router_constant.dart';
import 'package:evantez/src/controller/auth/auth_controller.dart';
import 'package:evantez/src/controller/events/new_event_venue_controller.dart';
import 'package:evantez/src/model/components/snackbar_widget.dart';
import 'package:evantez/src/model/helper/debounce.dart';
import 'package:evantez/src/view/core/constants/app_images.dart';
import 'package:evantez/src/view/core/constants/app_strings.dart';
import 'package:evantez/src/view/core/constants/constants.dart';
import 'package:evantez/src/view/core/themes/colors.dart';
import 'package:evantez/src/view/core/themes/typography.dart';
import 'package:evantez/src/view/core/widgets/custom_back_btn.dart';
import 'package:evantez/src/view/core/widgets/custom_dialogbox.dart';
import 'package:evantez/src/view/core/widgets/custom_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

class EventVenueListingView extends StatelessWidget {
  const EventVenueListingView({super.key});

  @override
  Widget build(BuildContext context) {
    final kSize = MediaQuery.of(context).size;
    final authController = context.watch<AuthController>();
    final eventVenueController = context.watch<EventVenueController>();
    return Scaffold(
      appBar: appBar(context, kSize, eventVenueController),
      body: SizedBox(
        height: kSize.height,
        width: kSize.width,
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(vertical: kSize.height * 0.016),
              child: searchField(context, kSize),
            ),
            Expanded(
                child: ListView.separated(
              padding: EdgeInsets.only(
                  right: AppConstants.basePadding,
                  bottom: kSize.height * 0.1,
                  left: AppConstants.basePadding),
              itemCount: eventVenueController.eventVenues.length,
              separatorBuilder: (context, index) {
                return SizedBox(
                  height: kSize.height * 0.016,
                );
              },
              itemBuilder: (context, index) {
                var venue = eventVenueController.eventVenues[index];
                return ListTile(
                  minLeadingWidth: kSize.height * 0.1,
                  trailing: SizedBox(
                    width: kSize.width * 0.1,
                    child: PopupMenuButton<String>(
                      initialValue: 'delete',
                      // Callback that sets the selected popup menu item.
                      onSelected: (item) {
                        if (item == 'delete') {
                          showDialog(
                              context: context,
                              builder: (context) {
                                return CustomDialog(
                                    title: "Are you sure you want this Event Venue?",
                                    onConfirmTxt: "Delete",
                                    onConfirm: () {
                                      // confirm
                                      if (context.mounted) {
                                        Navigator.pop(context);
                                      }
                                      eventVenueController
                                          .deleteEventVenue(
                                              token: authController.accesToken!, venueId: venue.id!)
                                          .then((value) async {
                                        if (value) {
                                          await eventVenueController.getEventVenueList(
                                              token: authController.accesToken!);
                                          rootScaffoldMessengerKey.currentState!.showSnackBar(
                                              snackBarWidget('Successfully deleted!', color: Colors.green));
                                          await Future.delayed(const Duration(seconds: 2));
                                        } else {
                                          rootScaffoldMessengerKey.currentState!.showSnackBar(
                                              snackBarWidget('Delete failed!', color: Colors.red));
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
                  ),
                  leading: SizedBox(
                      height: kSize.height * 0.1,
                      width: kSize.height * 0.1,
                      child: CachedNetworkImage(
                        imageUrl: venue.image!,
                        fit: BoxFit.cover,
                        errorWidget: (context, url, error) {
                          return const SizedBox();
                        },
                      )),
                  title: Text('${venue.name}', style: AppTypography.poppinsMedium.copyWith(fontSize: 16)),
                );
              },
            )),
          ],
        ),
      ),
    );
  }
}

Widget searchField(BuildContext context, Size kSize) {
  final auth = context.watch<AuthController>();
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: AppConstants.baseBorderRadius),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Flexible(
          child: CustomTextField(
            text: '',
            hintText: AppStrings.searchText,
            onChanged: (value) {
              debounceSearch(value, (String query) async {
                //
              });
            },
            suffixIcon: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 10.0),
              child: SvgPicture.asset(
                AppImages.search,
                colorFilter: const ColorFilter.mode(AppColors.primaryColor, BlendMode.srcIn),
              ),
            ),
          ),
        ),
        /* SizedBox(
          width: kSize.width * 0.032,
        ), */
        /* SizedBox(
            width: kSize.width * 0.1,
            child: TextButton(
                style: TextButton.styleFrom(
                  backgroundColor: AppColors.transparent,
                  padding: const EdgeInsets.symmetric(
                      vertical: 12.0, horizontal: 8.0),
                ),
                onPressed: () async {
                  //
                  showModalBottomSheet(
                      backgroundColor: AppColors.accentDark,
                      isScrollControlled: true,
                      shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(
                              topLeft:
                                  Radius.circular(AppConstants.basePadding),
                              topRight: Radius.circular(
                                AppConstants.basePadding,
                              ))),
                      context: context,
                      builder: (context) {
                        return EmployeeFilter();
                      }).then((value)  {
                        if(value){
                          controller.employeeList(token: auth.accesToken!);
                        }
                      });
                  // EmployeeFilter(context).show();
                },
                child: SvgPicture.asset(
                  AppImages.filter,
                  colorFilter: const ColorFilter.mode(
                      AppColors.primaryColor, BlendMode.srcIn),
                )),
          ) */
      ],
    ),
  );
}

AppBar appBar(BuildContext context, Size kSize, EventVenueController controller) {
  return AppBar(
    elevation: 0,
    leading: const CustomBackButton(),
    backgroundColor: Theme.of(context).scaffoldBackgroundColor,
    centerTitle: true,
    title: Text(
      "Event Venues",
      style: AppTypography.poppinsSemiBold.copyWith(),
    ),
    actions: [
      IconButton(
          onPressed: () async {
            controller.intiLoading();
            Navigator.pushNamed(context, RouterConstants.newEventVenueRoute);
          },
          icon: SvgPicture.asset(
            AppImages.addCircle,
            colorFilter: const ColorFilter.mode(
              AppColors.primaryColor,
              BlendMode.srcIn,
            ),
          ))
    ],
  );
}
