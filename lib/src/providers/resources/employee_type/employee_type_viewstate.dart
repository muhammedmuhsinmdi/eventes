import 'package:evantez/src/model/core/models/employeetype/employeetype_model.dart';
import 'package:evantez/src/model/services/services.dart';
import 'package:evantez/src/model/repository/resource/employeetype_repository.dart';
import 'package:flutter/material.dart';

class EmployeeTypeViewstate extends ChangeNotifier {
  late IEmployeeTypeRepository employeeTypeRepo;
  TextEditingController nameEditingController = TextEditingController();
  TextEditingController codeEditingController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  // EmployeeTypeViewstate() {
  //   employeeTypeRepo = Services.employeeTypeRepo;
  // }

  int _selectedIndex = 0;
  int get selectedIndex => _selectedIndex;
  set selectedIndex(int val) {
    _selectedIndex = val;
    notifyListeners();
  }

  late EmployeeType _employeeType;
  EmployeeType get employeeType => _employeeType;
  set employeeType(EmployeeType val) {
    _employeeType = val;
    notifyListeners();
  }

  late List<EmployeeType> _employeeTypes;
  List<EmployeeType> get employeeTypes => _employeeTypes;
  set employeeTypes(List<EmployeeType> val) {
    _employeeTypes = val;
    notifyListeners();
  }

  // validators
  String? nameValidator(String? value) {
    if (value!.isEmpty) {
      return "Name Required..";
    } else {
      return null;
    }
  }

  // validators
  String? codeValidator(String? value) {
    if (value!.isEmpty) {
      return "Code Required..";
    } else {
      return null;
    }
  }

  Future save() async {
    if (formKey.currentState!.validate()) {
      formKey.currentState!.save();
      if (employeeType.id != null && employeeType.id! > 0) {
        await employeeTypeRepo.update(employeeType);
      } else {
        await employeeTypeRepo.save(employeeType);
      }
    }
  }

  Future getAll() async {
    employeeTypes = List<EmployeeType>.empty(growable: true);
    try {
      employeeTypes = await employeeTypeRepo.getAll();
    } catch (e) {
      employeeTypes = List<EmployeeType>.empty(growable: true);
    }
  }
}
