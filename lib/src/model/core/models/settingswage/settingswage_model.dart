import 'dart:convert';

import 'package:evantez/src/model/core/models/base_master.dart';

SettingsWage settingsWageFromJson(String str) => SettingsWage.fromJson(json.decode(str));

String settingsWageToJson(SettingsWage data) => json.encode(data.toJson());

class SettingsWage extends BaseMaster {
  double amount;

  SettingsWage({
    required int id,
    required String name,
    required String code,
    required this.amount,
  }) : super(id: id, name: name, code: code);

  static List<SettingsWage> listFromMap(List<dynamic> list) {
      List<SettingsWage> rows = list.map((i) => SettingsWage.fromJson(i)).toList();
      return rows;
    }
    
  factory SettingsWage.fromJson(Map<String, dynamic> json) {
    return SettingsWage(
      id: json['Id'] as int,
      name: json['Name'] as String,
      code: json['Code'] as String,
      amount: json['Amount'] as double,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = super.toJson();
    data['Amount'] = amount;
    return data;
  }
}
