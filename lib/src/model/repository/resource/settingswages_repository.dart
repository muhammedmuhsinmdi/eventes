import 'dart:developer';

import 'package:evantez/app/app.dart';
import 'package:evantez/src/model/components/snackbar_widget.dart';
import 'package:evantez/src/providers/resources/settings_wages_viewstate/settings_wages_viewstate.dart';
import 'package:evantez/src/serializer/models/settings_wage_request.dart';
import 'package:evantez/src/serializer/models/settings_wage_response.dart';
import 'package:flutter/material.dart';

class SettingsWageController extends ChangeNotifier {
  bool isloading = false;
  final formKey = GlobalKey<FormState>();
  List<SettingsWageListResponse> settingsWageLists = [];

  Future<void> settingsWageList({required String token}) async {
    try {
      isloading = true;
      notifyListeners();
      final response = await SettingsWageProvider().loadEventSettings(token: token);
      if (response != null) {
        settingsWageLists = response;
      }
      isloading = false;
      notifyListeners();
    } catch (e) {
      log('message');
      isloading = false;
    }
  }

  //=-=-=-=-=-=-=-= Add Task =-=-=-=-=-=-=-=
  TextEditingController taskNameController = TextEditingController();
  TextEditingController taskCodeController = TextEditingController();
  TextEditingController pieceRateController = TextEditingController();

  Future<void> settingsWageAdd({required String token, required BuildContext context}) async {
    try {
      isloading = true;
      notifyListeners();
      final response = await SettingsWageProvider().addSettingWork(
        token: token,
        data: SettingsWageRequest(
            name: taskNameController.text, code: taskCodeController.text, rate: pieceRateController.text),
      );
      if (response != null) {
        rootScaffoldMessengerKey.currentState!
            .showSnackBar(snackBarWidget('Successfully added!', color: Colors.green));
        await Future.delayed(const Duration(seconds: 2));
        if (context.mounted) Navigator.of(context).pop();
      }
      isloading = false;
      notifyListeners();
    } catch (e) {
      log('message');
      isloading = false;
    }
  }

  //=-=-=-=-=-=-= Edit SettingsWages=-=-=-=-==-=-=-=



  Future<void> editEmployeeType(
      {required String token, required BuildContext context, required int id}) async {
    try {
      isloading = true;
      notifyListeners();
      final response = await SettingsWageProvider().editSettingWork(
          token: token,
          data: SettingsWageRequest(
              name: taskNameController.text, code: taskCodeController.text, rate: pieceRateController.text),
          id: id);
      if (response != null) {
        int indexToUpdate = settingsWageLists.indexWhere((item) => item.id == id);
        if (indexToUpdate >= 0) {
          settingsWageLists[indexToUpdate] = response;
        }

        rootScaffoldMessengerKey.currentState!
            .showSnackBar(snackBarWidget('Successfully upadted!', color: Colors.green));
        await Future.delayed(const Duration(seconds: 2));
        if (context.mounted) Navigator.of(context).pop();
      }
      isloading = false;
      notifyListeners();
    } catch (e, s) {
      log('message', stackTrace: s);
      isloading = false;
    }
  }

  //=-=-=-=-=-=-= Init State Loading =-=-=-=-==-=-=-=
  bool isEdit = false;
  void initStateLoading({SettingsWageListResponse? data}) {
    if (data == null) {
      taskNameController.clear();
      taskCodeController.clear();
      pieceRateController.clear();
      isEdit = false;
    } else {
      isEdit = true;
      taskNameController.text = data.name;
      taskCodeController.text = data.code;
      pieceRateController.text = data.rate;
    }
  }
}
