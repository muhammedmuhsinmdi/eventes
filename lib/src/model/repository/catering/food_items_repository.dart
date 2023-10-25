import 'dart:developer';

import 'package:evantez/app/app.dart';
import 'package:evantez/src/model/components/snackbar_widget.dart';
import 'package:evantez/src/providers/catering/food_items_viewstate.dart';
import 'package:evantez/src/serializer/models/food_item_type_response.dart';
import 'package:evantez/src/serializer/models/food_items_list_response.dart';
import 'package:evantez/src/serializer/models/food_items_request.dart';
import 'package:evantez/src/view/core/widgets/drop_down_value.dart';
import 'package:flutter/material.dart';

class FoodItemsController extends ChangeNotifier {
  bool isloading = false;
  List<FoodItemListResponse> foodItemsList = [];
  Future<void> foodItemList({required String token}) async {
    try {
      isloading = true;
      final response = await FoodItemsProvider().loadFoodItems(token: token);
      if (response != null) {
        foodItemsList = response;
        notifyListeners();
      }
      isloading = false;
    } catch (e) {
      log('message');
      isloading = false;
    }
  }

  //=-=-=-=-=-=-=-= Add Food Items =-=-=-=-=-=-=-==-=

  TextEditingController nameController = TextEditingController();
  TextEditingController rateController = TextEditingController();
  TextEditingController foodItemTypeController = TextEditingController();
  TextEditingController foodItemUnitController = TextEditingController();

  Future<void> addFoodItems({required String token, required BuildContext context}) async {
    try {
      isloading = true;
      final response = await FoodItemsProvider().addFoodItem(
        token: token,
        data: FoodItemRequest(
            name: nameController.text,
            foodItemType: selectedId!.id!,
            foodItemUnit: 0,
            rate: rateController.text),
      );
      if (response != null) {
        rootScaffoldMessengerKey.currentState!
            .showSnackBar(snackBarWidget('Successfully added!', color: Colors.green));
        await Future.delayed(const Duration(seconds: 2));
        if (context.mounted) Navigator.of(context).pop();
        notifyListeners();
      }
      isloading = false;
    } catch (e) {
      log('message');
      log(e.toString());
      isloading = false;
    }
  }

  //=-=-=-=-=-=-= Edit Food Items =-=-=-=-==-=-=-=

  Future<void> editFoodItem({required String token, required BuildContext context, required int id}) async {
    try {
      isloading = true;
      final response = await FoodItemsProvider().editFoodItem(
          token: token,
          data: FoodItemRequest(
              name: nameController.text,
              foodItemType: int.parse(foodItemTypeController.text),
              foodItemUnit: int.parse(foodItemUnitController.text),
              rate: rateController.text),
          id: id);
      if (response != null) {
        int indexToUpdate = foodItemsList.indexWhere((item) => item.id == id);
        if (indexToUpdate >= 0) {
          foodItemsList[indexToUpdate] = response;
        }
        rootScaffoldMessengerKey.currentState!
            .showSnackBar(snackBarWidget('Successfully upadted!', color: Colors.green));
        await Future.delayed(const Duration(seconds: 2));
        if (context.mounted) Navigator.of(context).pop();
        notifyListeners();
      }
      isloading = false;
    } catch (e, s) {
      log('message', stackTrace: s);
      isloading = false;
    }
  }

//--------------load food item types-------------
  List<FoodItemTypeResponse> foodItemTypes = [];
  List<DropDownValue> foodItemTypesList = [];
  Future<void> foodItemTypeList({required String token}) async {
    try {
      isloading = true;
      final response = await FoodItemsProvider().loadFoodItemTypes(token: token);
      if (response != null) {
        foodItemTypes = response;
        foodItemTypesList = response.map((e) => DropDownValue(id: e.id, value: e.name)).toList();
        notifyListeners();
      }
      isloading = false;
    } catch (e) {
      log('message');
      isloading = false;
    }
  }

  //=-=-=-=-=-= Change food type Id =--=--=-=-=-=
  DropDownValue? selectedId;
  void changeId(value) {
    selectedId = value;
  }

  //=-=-=-=-=-=-= Init State Loading =-=-=-=-==-=-=-=

  bool isEdit = false;
  void initStateLoading({FoodItemListResponse? data}) {
    if (data == null) {
      nameController.clear();
      foodItemTypeController.clear();
      foodItemUnitController.clear();
      rateController.clear();
      isEdit = false;
    } else {
      isEdit = true;
      nameController.text = data.name!;
      foodItemTypeController.text = data.foodItemType.toString();
      foodItemUnitController.text = data.foodItemUnit.toString();
      rateController.text = data.rate!;
    }
  }
}
