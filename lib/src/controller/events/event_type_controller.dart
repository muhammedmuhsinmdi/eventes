import 'package:evantez/src/model/core/models/event/event_type/event_type_model.dart';
import 'package:evantez/src/providers/dashboard/events_provider.dart';
import 'package:flutter/material.dart';

class EventTypeController extends ChangeNotifier {
  final GlobalKey<FormState> eventTypeForm = GlobalKey<FormState>();

  TextEditingController eventTypeTxt = TextEditingController();

  bool _isLoading = false;
  bool get isLoading => _isLoading;
  set isLoading(bool val) {
    _isLoading = val;
    notifyListeners();
  }

  List<EventTypeModel> eventTypes = [];

  EventTypeModel? _eventType = EventTypeModel();
  EventTypeModel? get eventType => _eventType;
  set eventType(EventTypeModel? val) {
    _eventType = val;
    notifyListeners();
  }

  bool isEdit = false;
  Future getEventTypeById({required String token, required int typeId}) async {
    try {
      final response = await EventProvider().getEventTypeById(token, typeId);
      eventType = response;
      eventTypeTxt.text = eventType!.name!;
      if (eventTypeTxt.text.isNotEmpty) {
        isEdit = true;
      }
      notifyListeners();
    } catch (_) {}
  }

  Future getEventTypeList({required String token}) async {
    try {
      final response = await EventProvider().getEventTypes(token: token);
      eventTypes = response;
      notifyListeners();
    } catch (_) {}
  }

  Future intiLoading() async {
    isEdit = false;
    eventType = EventTypeModel(id: 0);
    eventTypeTxt.clear();
  }

  Future deleteEventType({required String token, required int typeId}) async {
    try {
      final response = await EventProvider().deleteEventType(token, typeId);
      if (response == 204) {
        return true;
      } else {
        return false;
      }
    } catch (_) {
      return false;
    }
  }

  //event Venue validators
  String? eventTypeValidator(String? value) {
    if (value!.isEmpty) {
      return "Event Type Required..";
    } else {
      return null;
    }
  }

  Future<EventTypeModel> addEventType({
    required String token,
    required EventTypeModel data,
  }) async {
    try {
      isLoading = true;
      final response = (data.id! > 0)
          ? await await EventProvider().updateEventType(token: token, eventType: data)
          : await EventProvider().addEventType(token: token, eventadd: data.name!);
      isLoading = false;
      notifyListeners();
      return EventTypeModel.fromJson(response);
    } catch (e) {
      return EventTypeModel();
    }
  }
}
