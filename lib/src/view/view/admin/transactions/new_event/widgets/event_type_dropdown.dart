import 'package:evantez/src/model/core/models/event/event_type/event_type_model.dart';
import 'package:evantez/src/view/core/constants/app_images.dart';
import 'package:evantez/src/view/core/constants/constants.dart';
import 'package:evantez/src/view/core/themes/colors.dart';
import 'package:evantez/src/view/core/themes/typography.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class EventTypeDropDown extends StatefulWidget {
  final List<EventTypeModel> eventTypes;
  final Function(EventTypeModel) onSelected;
  final String intialValue;
  const EventTypeDropDown(
      {super.key, required this.eventTypes, required this.onSelected, required this.intialValue});

  @override
  State<EventTypeDropDown> createState() => _EventTypeDropDownState();
}

class _EventTypeDropDownState extends State<EventTypeDropDown> {
  EventTypeModel? dropDownValue;

  EventTypeModel intialValue = EventTypeModel(id: 0, createdAt: '', updatedAt: '', name: "");

  @override
  void initState() {
    if (widget.eventTypes.isNotEmpty) {
      intialValue = widget.eventTypes.first;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final kSize = MediaQuery.of(context).size;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(bottom: kSize.height * 0.010),
          child: RichText(
              text: TextSpan(
                  text: '*  ',
                  style: AppTypography.poppinsBold.copyWith(
                    color: AppColors.statusCritical,
                    fontSize: 16,
                  ),
                  children: [
                TextSpan(
                    text: "",
                    style: AppTypography.poppinsMedium.copyWith(
                      fontSize: 16,
                      color: AppColors.secondaryColor,
                    ))
              ])),
        ),
        DropdownButtonHideUnderline(
          child: DecoratedBox(
            decoration: BoxDecoration(
                color: AppColors.accentDark.withOpacity(0.1),
                border: const Border(bottom: BorderSide(width: 2, color: AppColors.primaryColor))),
            child: DropdownButton(
              icon: SvgPicture.asset(
                AppImages.arrowDropDown,
                colorFilter: const ColorFilter.mode(AppColors.primaryColor, BlendMode.srcIn),
              ),
              style: AppTypography.poppinsMedium.copyWith(color: AppColors.secondaryColor),
              hint: Text(
                "Select Event Type",
                style:
                    AppTypography.poppinsRegular.copyWith(color: AppColors.secondaryColor.withOpacity(0.4)),
              ),
              isExpanded: true,
              iconSize: 0,
              // style: FontUtils.getFont14Style(color: AppColors.black),
              items: widget.eventTypes.map(
                (val) {
                  return DropdownMenuItem<EventTypeModel>(
                    value: val,
                    child: Text(
                      val.name!,
                    ),
                  );
                },
              ).toList(),
              onChanged: (val) {
                // if (val != null) {
                dropDownValue = val ?? intialValue;

                widget.onSelected(dropDownValue!);

                // }

                // widget.onSelected(ConvertService.convertString(val));
                // setState(
                //   () {
                //     dropDownValue = val as String;
                //   },
                // );
              },

              value: dropDownValue,
              borderRadius: BorderRadius.circular(AppConstants.basePadding),
              padding: const EdgeInsets.symmetric(
                vertical: 10.0,
                horizontal: AppConstants.basePadding,
              ),
            ),
          ),
        )
      ],
    );
    /*  return CustomDropDown(
      label: "Type of Event",
      required: true,
      intialValue: widget.intialValue,
      hintText: "Select Event Type",
      onSelected: (eventType) {
        if (eventType.isNotEmpty) {
          widget.onSelected(eventType);
        }
      },
      items: widget.eventTypes,
    ); */
  }
}
