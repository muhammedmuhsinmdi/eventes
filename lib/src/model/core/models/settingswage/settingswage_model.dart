import 'dart:convert';

import 'package:evantez/src/model/core/models/base_master.dart';

SettingsWage settingsWageFromJson(String str) => SettingsWage.fromJson(json.decode(str));

String settingsWageToJson(SettingsWage data) => json.encode(data.toJson());

class SettingsWage extends BaseMaster{
    final double? amount;

    SettingsWage({
        this.amount,
    }) : super(name: '', code: '');

    factory SettingsWage.fromJson(Map<String, dynamic> json) => SettingsWage(
        amount: json["amount"]?.toDouble(),
    );

    @override
      Map<String, dynamic> toJson() => {
        "amount": amount,
        ...super.toJson()
    };
}
