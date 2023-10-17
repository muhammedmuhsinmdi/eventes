import 'package:dio/dio.dart';
import 'package:evantez/src/model/core/base_api_utilities.dart';
import 'package:evantez/src/serializer/models/rental_item_details.dart';
import 'package:evantez/src/serializer/models/rental_item_request.dart';
import 'package:evantez/src/serializer/models/rental_items_list_reponse.dart';
import 'package:evantez/src/view/core/event_api.dart';

class RentalItemsProvider extends EventApi {
  //----------------- Rental items List----------------------

  Future<List<RentalItemsListResponse>> loadRentalItems(
      {required String token}) async {
    Response response =
        await get('inventories/rental-item/', headers: apiHeaders(token));
    switch (response.statusCode) {
      case 200:
        return (response.data['results'] as List)
            .map((e) => RentalItemsListResponse.fromJson(e))
            .toList();
      default:
        throw Exception('Response Error');
    }
  }

  //-----------------Add Rental items----------------------

  Future<RentalItemDetails> addRentalItem(
      {required String token, required RentalItemsRequest data}) async {
    Response response = await post('inventories/rental-item/',
        data: data.toJson(), headers: apiHeaders(token));
    switch (response.statusCode) {
      case 200:
      case 201:
        return RentalItemDetails.fromJson(response.data);
      default:
        throw Exception('Response Error');
    }
  }

  //-------------Edit Rental Item------------

  Future<RentalItemsListResponse> editRentalItem(
      {required String token,
      required RentalItemsRequest data,
      required int id}) async {
    Response response = await patch('inventories/rental-item/$id/',
        data: data.toJson(), headers: apiHeaders(token));
    switch (response.statusCode) {
      case 200:
      case 201:
        return RentalItemsListResponse.fromJson(response.data);
      default:
        throw Exception('Response Error');
    }
  }
}
