import 'dart:convert';

import 'package:evantez/src/model/core/app_prefs/app_prefs.dart';

BaseFilterModel baseFilterModelFromJson(String str) => BaseFilterModel.fromJson(json.decode(str));

String baseFilterModelToJson(BaseFilterModel data) => json.encode(data.toJson());

class BaseFilterModel {
    int? limit;
    int? offset;
    String? search;

    BaseFilterModel({
        this.limit = AppPrefs.limit ,
        this.offset = 0,
        this.search
    });

    factory BaseFilterModel.fromJson(Map<String, dynamic> json) => BaseFilterModel(
        limit: json["limit"],
        offset: json["offset"]
    );

    Map<String, dynamic> toJson() => {
        "limit": limit,
        "offset": offset
    };
}





