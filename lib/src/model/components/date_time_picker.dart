import 'package:evantez/src/view/core/themes/colors.dart';
import 'package:evantez/src/view/core/themes/typography.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DatePickerContainer extends StatefulWidget {
  final String? hintText;
  final String? value;
  final Function changeDate;
  final bool clearDate;
  final bool isDisable;
  final DateTime? initialDate;
  const DatePickerContainer({
    Key? key,
    required this.hintText,
    this.value,
    required this.changeDate,
    this.clearDate = false,
    this.isDisable = false,
    this.initialDate,
  }) : super(key: key);

  @override
  State<DatePickerContainer> createState() => _DatePickerContainerState();
}

class _DatePickerContainerState extends State<DatePickerContainer> {
  DateTime selectedDate = DateTime.now();

  String? pickedDate;

  @override
  void initState() {
    super.initState();
    if (widget.value == null) {
      if (widget.clearDate == false) {
        pickedDate = apiFormat.format(selectedDate);
      }
    } else {
      pickedDate = widget.value;
      selectedDate = DateTime.parse(pickedDate!);
    }
  }

  @override
  Widget build(BuildContext context) {
    final kSize = MediaQuery.of(context).size;
    return Container(
      clipBehavior: Clip.antiAliasWithSaveLayer,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        // border: Border.all(color: const Color(0xffB3B3BF).withOpacity(0.5)),
        color: AppColors.darkBgColor1,
      ),
      child: Material(
        color: Colors.transparent,
        child: Column(
          children: [
            InkWell(
              onTap: () async {
                FocusManager.instance.primaryFocus?.unfocus();
                final DateTime? picked = await showDatePicker(
                  context: context,
                  initialDate: widget.initialDate ?? DateTime.now(),
                  firstDate: DateTime(1960),
                  lastDate: DateTime(2101),
                  builder: (BuildContext context, Widget? child) {
                    return Theme(
                      data: ThemeData.light().copyWith(
                        colorScheme: const ColorScheme.light(
                          primary: AppColors.accentColor,
                          onPrimary: Colors.black,
                          // surface: primaryColor,
                          onSurface: Colors.black,
                        ),
                        dialogBackgroundColor: Colors.white,
                      ),
                      child: child!,
                    );
                  },
                );
                if (picked != null) {
                  setState(() {
                    pickedDate = apiFormat.format(picked);
                    widget.changeDate(picked);
                  });
                } else {
                  if (widget.clearDate) {
                    setState(() {
                      pickedDate = null;
                      widget.changeDate(picked);
                    });
                  }
                }
              },
              child: Padding(
                padding: const EdgeInsets.only(left: 15, right: 10, top: 13, bottom: 13),
                child: Row(
                  children: [
                    Expanded(
                        child: pickedDate != null
                            ? Text(
                                pickedDate ?? '',
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: AppTypography.poppinsMedium.copyWith(
                                  color: AppColors.primaryColor,
                                  fontSize: kSize.height * 0.021,
                                ),
                              )
                            : Text(
                                widget.hintText ?? '',
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                    color: Colors.white, fontSize: 10, fontWeight: FontWeight.w500),
                              )),
                    const Icon(
                      Icons.calendar_month_outlined,
                      color: Colors.orange,
                      size: 24,
                    )
                  ],
                ),
              ),
            ),
            const Divider(
              color: AppColors.primaryColor,
              thickness: 2,
            )
          ],
        ),
      ),
    );
  }
}

final apiFormat = DateFormat('yyyy-MM-dd');
