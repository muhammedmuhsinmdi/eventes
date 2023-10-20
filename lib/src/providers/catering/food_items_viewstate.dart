import 'package:dio/dio.dart';
import 'package:evantez/src/model/core/base_api_utilities.dart';
import 'package:evantez/src/serializer/models/food_item_details.dart';
import 'package:evantez/src/serializer/models/food_item_type_response.dart';
import 'package:evantez/src/serializer/models/food_items_list_response.dart';
import 'package:evantez/src/serializer/models/food_items_request.dart';
import 'package:evantez/src/view/core/event_api.dart';

class FoodItemsProvider extends EventApi {
  //------------------ Food Items List --------------

  Future<List<FoodItemListResponse>> loadFoodItems(
      {required String token}) async {
    Response response =
        await get('inventories/food-item/', headers: apiHeaders(token));
    switch (response.statusCode) {
      case 200:
        return (response.data['results'] as List)
            .map((e) => FoodItemListResponse.fromJson(e))
            .toList();
      default:
        throw Exception('Response Error');
    }
  }

  //------------- Add Food Items -------------

  Future<FoodItemDetails> addFoodItem(
      {required String token, required FoodItemRequest data}) async {
    Response response = await post('inventories/food-item/',
        data: data.toJson(), headers: apiHeaders(token));
    switch (response.statusCode) {
      case 200:
      case 201:
        return FoodItemDetails.fromJson(response.data);
      default:
        throw Exception('Response Error');
    }
  }
  //-------------Edit Food Item------------

  Future<FoodItemListResponse> editFoodItem(
      {required String token,
      required FoodItemRequest data,
      required int id}) async {
    Response response = await patch('inventories/food-item/$id/',
        data: data.toJson(), headers: apiHeaders(token));
    switch (response.statusCode) {
      case 200:
      case 201:
        return FoodItemListResponse.fromJson(response.data);
      default:
        throw Exception('Response Error');
    }
  }

  //-----------------Food Item Types----------------------

  Future<List<FoodItemTypeResponse>> loadFoodItemTypes(
      {required String token}) async {
    Response response =
        await get('inventories/food-item-type/', headers: apiHeaders(token));
    switch (response.statusCode) {
      case 200:
        return (response.data['results'] as List)
            .map((e) => FoodItemTypeResponse.fromJson(e))
            .toList();
      default:
        throw Exception('Response Error');
    }
  }
}
