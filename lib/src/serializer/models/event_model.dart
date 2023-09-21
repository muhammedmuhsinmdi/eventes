

//-=-=-=-=-=-= EventType Model -=-=-=-=-=-=-=-=-=

class Eventtype {
  int? id;
  String? createdAt;
  String? updatedAt;
  String? name;

  Eventtype({this.id, this.createdAt, this.updatedAt, this.name});

  Eventtype.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['name'] = this.name;
    return data;
  }
}

//-=-=-=-=-=-=-= EventVenue Model -=-=-=-=-=-=-=-=-=

class EventVenue {
  int? id;
  String? createdAt;
  String? updatedAt;
  String? name;
  String? image;
  String? lat;
  String? log;

  EventVenue(
      {this.id,
      this.createdAt,
      this.updatedAt,
      this.name,
      this.image,
      this.lat,
      this.log});

  EventVenue.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    name = json['name'];
    image = json['image'];
    lat = json['lat'];
    log = json['log'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['name'] = this.name;
    data['image'] = this.image;
    data['lat'] = this.lat;
    data['log'] = this.log;
    return data;
  }
}



//-=-=-=-=-=-=-=-= EmployeeType Requirement Model -=-=-=-=--=-=-=


class EmpType {
  int? id;
  String? createdAt;
  String? updatedAt;
  String? name;
  String? rate;
  String? code;

  EmpType(
      {this.id,
      this.createdAt,
      this.updatedAt,
      this.name,
      this.rate,
      this.code});

  EmpType.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    name = json['name'];
    rate = json['rate'];
    code = json['code'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['name'] = this.name;
    data['rate'] = this.rate;
    data['code'] = this.code;
    return data;
  }
}