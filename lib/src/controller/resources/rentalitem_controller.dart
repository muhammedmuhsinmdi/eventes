import 'dart:developer';

import 'package:evantez/app/app.dart';
import 'package:evantez/src/model/components/snackbar_widget.dart';
import 'package:evantez/src/providers/resources/rental_item_viewstate/rental_item_viewstate.dart';
import 'package:evantez/src/serializer/models/rental_item_request.dart';
import 'package:evantez/src/serializer/models/rental_items_list_reponse.dart';
import 'package:flutter/material.dart';

class RentalItemsController extends ChangeNotifier {
  bool isloading = false;
  final formKey = GlobalKey<FormState>();
  List<RentalItemsListResponse> rentalItemsList = [];

  Future<void> rentalItemList({required String token}) async {
    try {
      isloading = true;
      notifyListeners();
      final response = await RentalItemsProvider().loadRentalItems(token: token);
      if (response != null) {
        rentalItemsList = response;
        notifyListeners();
      }
      isloading = false;
    } catch (e) {
      log('message');
      isloading = false;
    }
  }

  //=-=-=-=-=-=-=-= Add Rental Items =-=-=-=-=-=-=-=

  TextEditingController itemNameController = TextEditingController();
  TextEditingController itemCodeController = TextEditingController();
  TextEditingController rentController = TextEditingController();

  Future<void> addRentalItems({required String token, required BuildContext context}) async {
    try {
      isloading = true;
      notifyListeners();
      final response = await RentalItemsProvider().addRentalItem(
        token: token,
        data: RentalItemsRequest(
            name: itemNameController.text, code: itemCodeController.text, rate: rentController.text),
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
      isloading = false;
    }
  }

  //=-=-=-=-=-=-= Edit Rental Items =-=-=-=-==-=-=-=

  Future<void> editRentalItem({required String token, required BuildContext context, required int id}) async {
    try {
      isloading = true;
      notifyListeners();
      final response = await RentalItemsProvider().editRentalItem(
          token: token,
          data: RentalItemsRequest(
              name: itemNameController.text, code: itemCodeController.text, rate: rentController.text),
          id: id);
      if (response != null) {
        int indexToUpdate = rentalItemsList.indexWhere((item) => item.id == id);
        if (indexToUpdate >= 0) {
          rentalItemsList[indexToUpdate] = response;
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

  //=-=-=-=-=-=-= Init State Loading =-=-=-=-==-=-=-=

  bool isEdit = false;
  void initStateLoading({RentalItemsListResponse? data}) {
    if (data == null) {
      itemNameController.clear();
      itemCodeController.clear();
      rentController.clear();
      isEdit = false;
    } else {
      isEdit = true;
      itemNameController.text = data.name;
      itemCodeController.text = data.code;
      rentController.text = data.rate;
    }
  }
}
