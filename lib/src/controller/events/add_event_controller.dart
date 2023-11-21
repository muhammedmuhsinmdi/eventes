import 'dart:developer';
import 'dart:io';

import 'package:evantez/src/model/core/models/event/event_site_emp_requirement/event_site_emp_req_model.dart';
import 'package:evantez/src/model/core/models/event/event_type/event_type_model.dart';
import 'package:evantez/src/model/core/models/event/new_event_model/new_event_model.dart';
import 'package:evantez/src/model/core/models/event_site/event_site_model.dart';
import 'package:evantez/src/providers/dashboard/events_provider.dart';
import 'package:evantez/src/serializer/models/employee/employee_types_response.dart';
import 'package:evantez/src/view/core/widgets/drop_down_value.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../model/core/models/event/event_site_settings/event_site_settings_model.dart';

class AddEventController extends ChangeNotifier {
  final GlobalKey<FormState> eventForm = GlobalKey<FormState>();

  int eventId = 0;

  Future<void> initFn() async {
    selectedEventType = null;
    selectedEventVenue = null;
    event = NewEventModel()
      // ..scheduleDateTime = DateTime.now()
      ..code = ''
      ..eventTypeId = null
      ..eventSiteSettings = []
      ..status = 'hold'
      ..venueId = 0
      ..eventSiteSettings = []
      ..eventSiteEmployeeRequirement = [
        InputEventSiteEmployeeReqModel(
          charge: '',
          employeeType: 0,
          eventSite: 0,
          id: 0,
          requirementCount: 0,
        )
      ];
  }

  getEventDetail(String token, int eventid) async {
    final response = await EventProvider().getEventDetail(token, eventid);
    eventId = response.id!;
    customerAddress.text = response.customerAddress!;
    customerName.text = response.customerName!;
    additionalInfo.text = response.notes!;
    selectedEventVenue = DropDownValue(id: response.venue!.id, value: response.venue!.name);
    // eventVenue.text = response.venue!.name!;
    normalHours.text = response.normalHours!;
    overTimeRate.text = response.overtimeHourlyCharge!;
    customerPhone.text = response.customerPhone!;
    if (response.scheduledDate != null) {
      scheduledDate.text = DateFormat('dd MMM, yyyy').format(response.scheduledDate!);
      scheduledTime.text = DateFormat('hh:mm a').format(response.scheduledDate!);
    }
    List<InputEventSiteEmployeeReqModel> empList = [];
    if (response.eventSiteEmployeeRequirement!.isNotEmpty) {
      for (var empType in response.eventSiteEmployeeRequirement!) {
        empList.add(InputEventSiteEmployeeReqModel(
          charge: empType.charge,
          eventSite: empType.eventSite,
          id: empType.id,
          employeeType: empType.employeeType!.id,
          requirementCount: empType.requirementCount,
        ));
      }
    } else {
      empList.add(InputEventSiteEmployeeReqModel(
        charge: '',
        employeeType: 0,
        eventSite: response.id,
        id: 0,
        requirementCount: 0,
      ));
    }

    event = NewEventModel(
      code: response.code,
      /*  scheduleDateTime: response.scheduledDate != null
          ? DateFormat('yyyy-MM-dd HH:mm:ss').format(response.scheduledDate!)
          : "", */
      customerAddress: response.customerAddress,
      customerName: response.customerName,
      customerPhone: response.customerPhone,
      eventSiteEmployeeRequirement: empList,
      eventSiteSettings: [],
      // eventSiteSettings: List<InputEventSiteSettingsModel>.from(
      //     response.eventSiteSettings!.map((x) => InputEventSiteSettingsModel.fromJson(x.toJson()))),
      eventTypeId: response.eventType!.id,
      normalHours: response.normalHours,
      notes: response.notes,
      overtimeHourlyCharge: response.overtimeHourlyCharge,
      status: response.status,
      venueId: response.venue!.id,
    );
    if (response.eventSiteSettings!.isNotEmpty) {
      for (var settings in response.eventSiteSettings!) {
        event.eventSiteSettings!.add(InputEventSiteSettingsModel(
          eventSite: settings.eventSite,
          id: settings.id,
          service: settings.service.id,
        ));
      }
    }
    selectedEventType = DropDownValue(id: response.eventType!.id, value: response.eventType!.name);
    eventImagePath = response.venue!.image!;
    log("${event.toJson()}");
  }

  File? _eventImage;
  File get eventImage => _eventImage!;
  set eventImage(File val) {
    _eventImage = val;
    notifyListeners();
  }

  DateTime? eventDateTime;
  TimeOfDay? eventTime;

  String? _eventImagePath;
  String get eventImagePath => _eventImagePath ?? '';
  set eventImagePath(String val) {
    _eventImagePath = val;
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
  TextEditingController eventCode = TextEditingController();
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

  // Event Code
  String? eventCodeValidator(String? value) {
    if (value!.isEmpty) {
      return "Event Code Required..";
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

  Future saveEvent(String? token) async {
    if (eventForm.currentState!.validate()) {
      isLoading = true;
      eventForm.currentState!.save();
      // var data = json.encode(event.toJson());
      // log(data);
      return await EventProvider().eventSiteAdd(token: token!, eventSite: event);
    }
  }

  Future updateEvent(String? token) async {
    if (eventForm.currentState!.validate()) {
      isLoading = true;
      eventForm.currentState!.save();
      log("Event ID >>> $eventId");
      // var data = json.encode(event.toJson());
      // log(data);
      return await EventProvider().updateEventSite(token: token!, eventSite: event, eventId: eventId);
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

  List<DropDownValue> eventVenues = [];
  DropDownValue? selectedEventVenue;
  Future getEventVenues(String token) async {
    try {
      final response = await EventProvider().loadEventVenue(token);
      if (response.results!.isNotEmpty) {
        eventVenues = response.results!.map((e) => DropDownValue(id: e.id, value: e.name)).toList();
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

  // event venue validator
  String? eventVenueValidator(DropDownValue? value) {
    if (value == null) {
      return 'Please select an option';
    }
    return null;
  }

  clearData() {
    eventId = 0;
    event = NewEventModel();
    selectedEventType = null;
    selectedEventVenue = null;
    eventImagePath = '';
    customerName.clear();
    customerPhone.clear();
    customerAddress.clear();
    additionalInfo.clear();
    normalHours.clear();
    overTimeRate.clear();
    scheduledDate.clear();
    scheduledTime.clear();
    eventCode.clear();
  }
}
