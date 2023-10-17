import 'dart:convert';

import 'package:evantez/src/model/core/app_prefs/app_prefs.dart';
import 'package:shared_preferences/shared_preferences.dart';

PagedInput pagedInputFromJson(String str) => PagedInput.fromJson(json.decode(str));

String pagedInputToJson(PagedInput data) => json.encode(data.toJson());

class PagedInput {
    final int? limit;
    final int? offset;

    PagedInput({
        this.limit = AppPrefs.limit ,
        this.offset = 0,
    });

    factory PagedInput.fromJson(Map<String, dynamic> json) => PagedInput(
        limit: json["limit"],
        offset: json["offset"],
    );

    Map<String, dynamic> toJson() => {
        "limit": limit,
        "offset": offset,
    };
}





