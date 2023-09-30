import 'package:flutter/material.dart';

import '../../../../../core/widgets/custom_drop_down.dart';

class EventTypeDropDown extends StatefulWidget {
  final List<String> eventTypes;
  final Function(String) onSelected;
  final String intialValue;
  const EventTypeDropDown(
      {super.key, required this.eventTypes, required this.onSelected, required this.intialValue});

  @override
  State<EventTypeDropDown> createState() => _EventTypeDropDownState();
}

class _EventTypeDropDownState extends State<EventTypeDropDown> {
  @override
  Widget build(BuildContext context) {
    return CustomDropDown(
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
    );
  }
}
