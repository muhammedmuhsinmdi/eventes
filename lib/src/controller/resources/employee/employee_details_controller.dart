import 'package:evantez/src/providers/resources/employee_type/employee_type_viewstate.dart';
import 'package:evantez/src/serializer/models/employee/employee_details/employee_details_model.dart';
import 'package:evantez/src/serializer/models/employee/employee_type/employee_model.dart';
import 'package:flutter/material.dart';

class EmployeeDetasilController extends ChangeNotifier {
  final EmployeeProvider _employeeProvider = EmployeeProvider();
  final ValueNotifier<int> selectedTab = ValueNotifier<int>(0);

  bool _isloading = false;
  bool get isLoading => _isloading;
  set isLoading(bool val) {
    _isloading = val;
    notifyListeners();
  }

  EmployeeDetailsModel? _employeeDetailsModel;
  EmployeeDetailsModel? get employeeDetailsModel => _employeeDetailsModel;
  set employeeDetailsModel(EmployeeDetailsModel? val) {
    _employeeDetailsModel = val;
    notifyListeners();
  }

  Future getEmployeeDetails(
      {required String token, required int employeeId}) async {
    try {
      isLoading = true;
      selectedTab.value = 0;
      employeeDetailsModel = EmployeeDetailsModel();
      var response = await _employeeProvider.loadEmployeeDetails(
          token: token, id: employeeId);
      if (response != null) {
        employeeDetailsModel!.address = response.address;
        employeeDetailsModel!.bloodGroup = response.bloodGroup;
        employeeDetailsModel!.code = response.code;
        employeeDetailsModel!.createdAt = response.createdAt;
        employeeDetailsModel!.currentRating = response.currentRating;
        employeeDetailsModel!.dob = response.dob;
        employeeDetailsModel!.email = response.email;
        employeeDetailsModel!.employeeMobile = response.employeeMobile;
        employeeDetailsModel!.employeeName = response.employeeName;
        employeeDetailsModel!.employeeType = response.employeeType;
        employeeDetailsModel!.homeContact = response.homeContact;
        employeeDetailsModel!.id = response.id;
        employeeDetailsModel!.idProofNumber = response.idProofNumber;
        employeeDetailsModel!.idProofType = response.idProofType;
        employeeDetailsModel!.image = response.image;
        employeeDetailsModel!.isActive = response.isActive;
        employeeDetailsModel!.totalEarnings = response.totalEarnings;
        employeeDetailsModel!.updatedAt = response.updatedAt;
        employeeDetailsModel!.user = response.user;
        employeeDetailsModel!.employeeHistory = List.empty(growable: true);
        employeeDetailsModel!.employeePaymentDetails = List.empty(growable: true);
        employeeDetailsModel!.employeeEarnings = List.empty(growable: true);
        await getEmployeeTypeById(
            token: token,
            employeeTypeId: employeeDetailsModel!.employeeType as int);
        await getEmployeePaymentDetails(token: token, employeeId: employeeId);
      }
    } catch (e) {
      isLoading = false;
    }
  }

  Future getEmployeeTypeById(
      {required String token, required int employeeTypeId}) async {
    try {
      isLoading = true;
      final response = await _employeeProvider.getEmployeeType(
          token: token, typeId: employeeTypeId);
      employeeDetailsModel!.type = response;
    } catch (e) {
      isLoading = false;
    }
  }

  Future getEmployeePaymentDetails(
      {required String token, required int employeeId}) async {
    try {
      isLoading = true;
      final response = await EmployeeProvider()
          .employeePaymentDetalis(token: token, employeeId: employeeId);
      employeeDetailsModel!.employeePaymentDetails = response;
    } catch (e) {
      isLoading = false;
    }
  }

  Future getEmployeeEarnings(
      {required String token, required int employeeId}) async {
    try {
      isLoading = true;
    } catch (e) {
      isLoading = false;
    }
  }

  Future getEmployeeHistory(
      {required String token, required int employeeId}) async {
    try {
      isLoading = true;
    } catch (e) {
      isLoading = false;
    }
  }

  Future onChangeEmployeeState(value, token) async {
    employeeDetailsModel!.isActive = value;    
    await _employeeProvider.editEmployee(token: token, data: employeeDetailsModel!);  
    notifyListeners();
  }


}
