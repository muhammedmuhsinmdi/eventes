import 'package:dio/dio.dart';
import 'package:evantez/src/model/core/base_api_utilities.dart';
import 'package:evantez/src/serializer/models/event_details.response.dart';
import 'package:evantez/src/serializer/models/event_response.dart';
import 'package:evantez/src/view/core/event_api.dart';

class EventProvider extends EventApi {
  //=-=-=-=-=-=-=-=-= Events =-=-=-=-=-=-=-=-=-=
  Future<EventsResponse> loadEvents(String token) async {
    Response response =
        await get('events/event-venue/', headers: apiHeaders(token));

    switch (response.statusCode) {
      case 200:
        return EventsResponse.fromJson(response.data);

      default:
        throw Exception('Error');
    }
  }

  //=-=-=-=-=-=-==-=-= Events Details =-=-=-=-=-=-=
  Future<EventsDetailResponse> loadEventDetails(
      {required String token, required int id}) async {
    Response response =
        await get('events/event-venue/$id', headers: apiHeaders(token));
    switch (response.statusCode) {
      case 200:
        return EventsDetailResponse.fromJson(response.data);
      default:
        throw Exception('Error');
    }
  }
}
