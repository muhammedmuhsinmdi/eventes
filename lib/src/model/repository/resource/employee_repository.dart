// ignore_for_file: unnecessary_null_comparison

import 'dart:developer';

import 'package:evantez/src/model/core/models/employeetype/employeetype_model.dart';
import 'package:evantez/src/model/repository/resource/employeetype_repository.dart';
import 'package:evantez/src/providers/resources/employee_type/employee_type_viewstate.dart';
import 'package:evantez/src/serializer/models/employee_details_response.dart';
import 'package:evantez/src/serializer/models/employee_list_response.dart';
import 'package:evantez/src/serializer/models/employee_payment_details.dart';
import 'package:evantez/src/serializer/models/employee_request.dart';
import 'package:evantez/src/serializer/models/employee_types_response.dart';
import 'package:evantez/src/view/core/widgets/drop_down_value.dart';
import 'package:evantez/src/view/view/resouces/employee/employee_view/employee_view.dart';
import 'package:flutter/widgets.dart';

class EmployeesController extends ChangeNotifier {
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

  bool isloading = false;
  List<EmployeeListResponse> employeeLists = [];
  Future<void> employeeList({required String token}) async {
    try {
      isloading = true;
      final response = await EmployeeProvider().loadEmployee(token: token);
      if (response != null) {
        employeeLists = response;
        notifyListeners();
      }
      isloading = false;
    } catch (e) {
      log('message');
      isloading = false;
    }
  }

  //=-=-=-=-=-=-=-= Employee Details =-=-==-=-=-=-=
  EmployeeDetails? employeeData;
  Future<void> employeeDetails({required String token, required int id}) async {
    try {
      isloading = true;
      final response =
          await EmployeeProvider().loadEmployeeDetails(token: token, id: id);
      if (response != null) {
        employeeData = response;
        notifyListeners();
      }
      isloading = false;
    } catch (e) {
      log('message');
      isloading = false;
    }
  }

  DropDownValue? selectedItem;
  void chnage(value) {
    selectedItem = value;
    log("${selectedItem?.value}");
  }

  List<EmployeesTypesList> employeeTypesList = [];
  List<DropDownValue> types = [];
  Future<void> employeeTypesData({required String token}) async {
    try {
      isloading = true;
      final response =
          await EmployeeProvider().loadEmployeesTypes(token: token);
      if (response != null) {
        employeeTypesList = response;
        types = response
            .map((e) => DropDownValue(id: e.id, value: e.name))
            .toList();
        notifyListeners();
      }
      isloading = false;
    } catch (e) {
      log('message');
      isloading = false;
    }
  }

  final ValueNotifier<List<String>> selectedEmpList =
      ValueNotifier<List<String>>([]);

  //=-=-=-=-=-=-=-= Employee Payemnt =-=-=-=-=-=-=-=
  EmployeeBank? employeePayment;
  Future<void> employeePayments(
      {required String token, required int id}) async {
    try {
      isloading = true;
      final response =
          await EmployeeProvider().employeePayment(token: token, id: id);
      if (response != null) {
        employeePayment = response;
        notifyListeners();
      }
      isloading = false;
    } catch (e) {
      log('message');
      isloading = false;
    }
  }

  //=-=-=-=-=-=-=-= Add Employee  =-=-=-=-=-=-=-=

  Future<void> employeeAdd({required String token, required int id}) async {
    try {
      isloading = true;
      final response = await EmployeeProvider()
          .addEmployee(token: token, id: id, data: EmployeeRequest());
      if (response != null) {
        notifyListeners();
      }
      isloading = false;
    } catch (e) {
      log('message');
      isloading = false;
    }
  }
}
