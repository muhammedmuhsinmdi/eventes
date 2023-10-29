import 'package:evantez/src/model/core/models/event/event_type/event_type_model.dart';
import 'package:evantez/src/model/core/models/event/event_venue/event_venue_model.dart';
import 'package:evantez/src/model/core/models/event/new_event_model/new_event_model.dart';
import 'package:flutter/material.dart';

class NewEventController extends ChangeNotifier {
  TextEditingController eventVenue = TextEditingController();
  TextEditingController customerName = TextEditingController();
  TextEditingController customerPhone = TextEditingController();
  TextEditingController customerAddress = TextEditingController();
  TextEditingController additionalInfo = TextEditingController();
  TextEditingController normalHours = TextEditingController();
  TextEditingController overTimeRate = TextEditingController();
  TextEditingController scheduledDate = TextEditingController();
  TextEditingController scheduledTime = TextEditingController();

  EventTypeModel? eventType;
  EventVenueModel? eventVenueValue;

  NewEventModel? eventModel;

  bool _isLoading = false;
  bool get isLoading => _isLoading;
  set isLoading(bool isLoading) {
    _isLoading = isLoading;
    notifyListeners();
  }

  initData() {
    eventModel = NewEventModel(
      code: "",
      customerAddress: '',
      customerName: '',
      customerPhone: '',
      eventSiteEmployeeRequirement: [],
      eventSiteSettings: [],
      eventTypeId: 0,
      normalHours: '',
      notes: '',
      overtimeHourlyCharge: '',
      status: '',
      venueId: 0,
    );
  }
}
