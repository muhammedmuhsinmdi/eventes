import 'dart:convert';

import 'package:evantez/src/model/core/models/base_master.dart';

RentalItem rentalItemFromJson(String str) => RentalItem.fromJson(json.decode(str));

String rentalItemToJson(RentalItem data) => json.encode(data.toJson());

class RentalItem extends BaseMaster{
    final double? amount;

    RentalItem({
        this.amount,
    }) : super(name: '', code: '');

    factory RentalItem.fromJson(Map<String, dynamic> json) => RentalItem(
        amount: json["amount"]?.toDouble(),
    );

    @override
      Map<String, dynamic> toJson() => {
        "amount": amount,
        ...super.toJson()
    };
}
