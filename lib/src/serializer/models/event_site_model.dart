class EventSite {
  int? eventTypeId;
  int? venueId;
  String? scheduledDatetime;
  String? customerName;
  String? customerPhone;
  String? customerAddress;
  String? notes;
  String? normalHours;
  String? overtimeHourlyCharge;
  List<EventSiteSettings>? eventSiteSettings;
  List<EventSiteEmployeeRequirement>? eventSiteEmployeeRequirement;
  String? code;
  String? status;

  EventSite(
      {this.eventTypeId,
      this.venueId,
      this.scheduledDatetime,
      this.customerName,
      this.customerPhone,
      this.customerAddress,
      this.notes,
      this.normalHours,
      this.overtimeHourlyCharge,
      this.eventSiteSettings,
      this.eventSiteEmployeeRequirement,
      this.code,
      this.status});

  EventSite.fromJson(Map<String, dynamic> json) {
    eventTypeId = json['event_type_id'];
    venueId = json['venue_id'];
    scheduledDatetime = json['scheduled_datetime'];
    customerName = json['customer_name'];
    customerPhone = json['customer_phone'];
    customerAddress = json['customer_address'];
    notes = json['notes'];
    normalHours = json['normal_hours'];
    overtimeHourlyCharge = json['overtime_hourly_charge'];
    if (json['event_site_settings'] != null) {
      eventSiteSettings = <EventSiteSettings>[];
      json['event_site_settings'].forEach((v) {
        eventSiteSettings!.add(new EventSiteSettings.fromJson(v));
      });
    }
    if (json['event_site_employee_requirement'] != null) {
      eventSiteEmployeeRequirement = <EventSiteEmployeeRequirement>[];
      json['event_site_employee_requirement'].forEach((v) {
        eventSiteEmployeeRequirement!
            .add(new EventSiteEmployeeRequirement.fromJson(v));
      });
    }
    code = json['code'];
    status = json['status'];
  }

   Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['event_type_id'] = this.eventTypeId;
    data['venue_id'] = this.venueId;
    data['scheduled_datetime'] = this.scheduledDatetime;
    data['customer_name'] = this.customerName;
    data['customer_phone'] = this.customerPhone;
    data['customer_address'] = this.customerAddress;
    data['notes'] = this.notes;
    data['normal_hours'] = this.normalHours;
    data['overtime_hourly_charge'] = this.overtimeHourlyCharge;
    if (this.eventSiteSettings != null) {
      data['event_site_settings'] =
          this.eventSiteSettings!.map((v) => v.toJson()).toList();
    }
    if (this.eventSiteEmployeeRequirement != null) {
      data['event_site_employee_requirement'] =
          this.eventSiteEmployeeRequirement!.map((v) => v.toJson()).toList();
    }
    data['code'] = this.code;
    data['status'] = this.status;
    return data;
  }
}

class EventSiteSettings {
  int? service;

  EventSiteSettings({this.service});

  EventSiteSettings.fromJson(Map<String, dynamic> json) {
    service = json['service'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['service'] = this.service;
    return data;
  }
}

class EventSiteEmployeeRequirement {
  int? requirementCount;
  String? charge;
  int? employeeType;

  EventSiteEmployeeRequirement(
      {this.requirementCount, this.charge, this.employeeType});

  EventSiteEmployeeRequirement.fromJson(Map<String, dynamic> json) {
    requirementCount = json['requirement_count'];
    charge = json['charge'];
    employeeType = json['employee_type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['requirement_count'] = this.requirementCount;
    data['charge'] = this.charge;
    data['employee_type'] = this.employeeType;
    return data;
  }
}