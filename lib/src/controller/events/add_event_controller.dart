import 'dart:io';

import 'package:evantez/src/model/core/models/event/event_site_emp_requirement/event_site_emp_req_model.dart';
import 'package:evantez/src/model/core/models/event/event_type/event_type_model.dart';
import 'package:evantez/src/model/core/models/event/new_event_model/new_event_model.dart';
import 'package:evantez/src/providers/dashboard/events_provider.dart';
import 'package:evantez/src/serializer/models/employee/employee_types_response.dart';
import 'package:evantez/src/view/core/widgets/drop_down_value.dart';
import 'package:flutter/material.dart';

class AddEventController extends ChangeNotifier {
  final GlobalKey<FormState> eventForm = GlobalKey<FormState>();

  Future<void> initFn() async {
    selectedEventType = null;
    event = NewEventModel()
      ..code = 'EV2010'
      ..eventTypeId = null
      ..eventSiteSettings = []
      ..eventSiteEmployeeRequirement = [
        EventSiteEmployeeReqModel(
          charge: '',
          employeeType: 0,
          requirementCount: 0,
        )
      ];
  }

  File? _eventImage;
  File get eventImage => _eventImage!;
  set eventImage(File val) {
    _eventImage = val;
    notifyListeners();
  }

  bool _isLoading = false;
  bool get isLoading => _isLoading;
  set isLoading(bool val) {
    _isLoading = val;
    notifyListeners();
  }

  NewEventModel _event = NewEventModel();
  NewEventModel get event => _event;
  set event(NewEventModel val) {
    _event = val;
    notifyListeners();
  }

  List<EmployeesTypesList> _employeeTypes = List<EmployeesTypesList>.empty(growable: true);
  List<EmployeesTypesList> get employeeTypes => _employeeTypes;
  set employeeTypes(List<EmployeesTypesList> val) {
    _employeeTypes = val;
    notifyListeners();
  }

  List<EventTypeModel> _eventTypes = List<EventTypeModel>.empty(growable: true);
  List<EventTypeModel> get eventTypes => _eventTypes;
  set eventTypes(List<EventTypeModel> val) {
    _eventTypes = val;
    notifyListeners();
  }

  /// TextEditing Contoller
  TextEditingController eventVenue = TextEditingController();
  TextEditingController customerName = TextEditingController();
  TextEditingController customerPhone = TextEditingController();
  TextEditingController customerAddress = TextEditingController();
  TextEditingController additionalInfo = TextEditingController();
  TextEditingController normalHours = TextEditingController();
  TextEditingController overTimeRate = TextEditingController();
  TextEditingController scheduledDate = TextEditingController();
  TextEditingController scheduledTime = TextEditingController();

  // Form Validators
  //name validators
  String? customerNameValidator(String? value) {
    if (value!.isEmpty) {
      return "Customer Name Required..";
    } else {
      return null;
    }
  }

//event Venue validators
  String? eventVenueValidator(String? value) {
    if (value!.isEmpty) {
      return "Event Venue Required..";
    } else {
      return null;
    }
  }

  //name validators
  String? customAddressValidator(String? value) {
    if (value!.isEmpty) {
      return "Customer Address Required..";
    } else {
      return null;
    }
  }

  //phone validators
  String? phoneValidator(String? value) {
    if (value!.isEmpty) {
      return "Phone Required..";
    } else if (value.length < 10 || value.length > 10) {
      return "Invalid phone number";
    } else {
      return null;
    }
  }

  //Normal Hours validators
  String? normalHoursValidator(String? value) {
    if (value!.isEmpty) {
      return "Normal Hours Required..";
    } else {
      return null;
    }
  }

  //Overtime Rate validators
  String? overTimeRateValidator(String? value) {
    if (value!.isEmpty) {
      return "Over Time Rate Required..";
    } else {
      return null;
    }
  }

  Future saveEvent() async {
    if (eventForm.currentState!.validate()) {
      eventForm.currentState!.save();
      print(event.code);
      //
    }
  }

  List<DropDownValue> types = [];
  DropDownValue? selectedEventType;
  Future getEventTypes(String token) async {
    try {
      final response = await EventProvider().getEventTypes(token: token);
      if (response.isNotEmpty) {
        eventTypes = response;
        types = response.map((e) => DropDownValue(id: e.id, value: e.name)).toList();
        notifyListeners();
      }
    } catch (e) {
      eventTypes = [];
    }
  }

  // event type validator
  String? eventTypeValidator(DropDownValue? value) {
    if (value == null) {
      return 'Please select an option';
    }
    return null;
  }

  clearData() {
    event = NewEventModel();
    eventVenue.clear();
    customerName.clear();
    customerPhone.clear();
    customerAddress.clear();
    additionalInfo.clear();
    normalHours.clear();
    overTimeRate.clear();
    scheduledDate.clear();
    scheduledTime.clear();
  }
}
