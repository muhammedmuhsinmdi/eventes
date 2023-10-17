import 'package:dio/dio.dart';
import 'package:evantez/src/model/core/base_api_utilities.dart';
import 'package:evantez/src/serializer/models/settings_wage_detail_response.dart';
import 'package:evantez/src/serializer/models/settings_wage_request.dart';

import '../../../serializer/models/settings_wage_response.dart';
import '../../../view/core/event_api.dart';

class SettingsWageProvider extends EventApi {
  Future<List<SettingsWageListResponse>> loadEventSettings(
      {required String token}) async {
    Response response =
        await get('inventories/event-setting/', headers: apiHeaders(token));
    switch (response.statusCode) {
      case 200:
        return (response.data['results'] as List)
            .map((e) => SettingsWageListResponse.fromJson(e))
            .toList();
      default:
        throw Exception('Response Error');
    }
  }

  //-----------SettingsWage Add-------------

  Future<SettingsWageDetails> addSettingWork(
      {required String token, required SettingsWageRequest data}) async {
    Response response = await post('inventories/event-setting/',
        data: data.toJson(), headers: apiHeaders(token));
    switch (response.statusCode) {
      case 200:
      case 201:
        return SettingsWageDetails.fromJson(response.data);
      default:
        throw Exception('Response Error');
    }
  }

  //-------------Edit SettingsWage------------

  Future<SettingsWageListResponse> editSettingWork(
      {required String token,
      required SettingsWageRequest data,
      required int id}) async {
    Response response = await patch('inventories/event-setting/$id/',
        data: data.toJson(), headers: apiHeaders(token));
    switch (response.statusCode) {
      case 200:
      case 201:
        return SettingsWageListResponse.fromJson(response.data);
      default:
        throw Exception('Response Error');
    }
  }
}
