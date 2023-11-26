import 'dart:developer';
import 'dart:io';

import 'package:evantez/app/app.dart';
import 'package:evantez/src/model/components/snackbar_widget.dart';
import 'package:evantez/src/model/core/extensions/date_extensions.dart';
import 'package:evantez/src/providers/resources/employee_type/employee_type_viewstate.dart';
import 'package:evantez/src/serializer/models/employee/employee_details/employee_details_model.dart';
import 'package:evantez/src/serializer/models/employee/employee_type/employee_model.dart';
import 'package:evantez/src/serializer/models/employee_detail_reponse.dart';
import 'package:evantez/src/view/core/widgets/drop_down_value.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AddEmployeeController extends ChangeNotifier {
  final GlobalKey<FormState> employeeForm = GlobalKey<FormState>();
  //=-=-=-=-=-=-= TextField =-=-=-=-=-=-=-=
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController imageController = TextEditingController();
  TextEditingController totalEarningsController = TextEditingController();
  TextEditingController currentRatingController = TextEditingController();
  TextEditingController codeController = TextEditingController();
  TextEditingController dobController = TextEditingController();
  TextEditingController bloodGroupController = TextEditingController();
  TextEditingController homeContact = TextEditingController();
  TextEditingController emailTextController = TextEditingController();
  TextEditingController addressContactTxtController = TextEditingController();
  TextEditingController idNumberTxtController = TextEditingController();
  TextEditingController idProofTypeController = TextEditingController();
  TextEditingController idProofNumberController = TextEditingController();

  EmployeeModel _employee = EmployeeModel();
  EmployeeModel get employee => _employee;
  set employee(EmployeeModel val) {
    _employee = val;
    notifyListeners();
  }

  File? _employeeImage;
  File get employeeImage => _employeeImage!;
  set employeeImage(File val) {
    _employeeImage = val;
    notifyListeners();
  }

  DateTime _dob = DateTime.now();
  DateTime get dob => _dob;
  set dob(DateTime val) {
    _dob = val;
    notifyListeners();
  }

  bool _isloading = false;
  bool get isloading => isloading;
  set isloading(bool val) {
    _isloading = val;
    notifyListeners();
  }

  DropDownValue? selectedEmpType;
  DropDownValue? selectedIdType;

  Future<void> addEmployee(
      {required String token, required BuildContext context}) async {
    if (employeeForm.currentState!.validate()) {
      employeeForm.currentState!.save();
      /*     FormData formData = FormData.fromMap({
        "employee_name": employee.employeeName,
        "employee_mobile": phoneController.text,
        "image": await MultipartFile.fromFile(
          employeeImage.path,
          filename: employeeImage.path.split('/').last,
        ),
        "code": codeController.text,
        "dob": dobController.text,
        "blood_group": bloodGroupController.text,
        "home_contact": homeContact.text,
        "email": emailTextController.text,
        "address": addressContactTxtController.text,
        "id_proof_number": idProofNumberController.text,
        "employee_type": employee.employeeType,
      });
      formData.toString(); */
      final response =
          await EmployeeProvider().addEmployee(token: token, data: employee);
      if (response != null) {
        rootScaffoldMessengerKey.currentState!.showSnackBar(
            snackBarWidget('Successfully added!', color: Colors.green));
        if (context.mounted) {
          Navigator.pop(context);
        }
        notifyListeners();
      }
      isloading = false;
    }
  }

//=-=-=-=-=-=-=-=-= Employee Types =-=-=-=-=-=-=
  List<DropDownValue> types = [];
  Future<void> employeeTypesData({required String token}) async {
    try {
      isloading = true;
      final response =
          await EmployeeProvider().loadEmployeesTypes(token: token);
      if (response != null) {
        types = response
            .map((e) => DropDownValue(id: e.id, value: e.name))
            .toList();
        notifyListeners();
      }
      isloading = false;
    } catch (e) {
      isloading = false;
    }
  }

  //=-=-=-=-=-=-=-= Employee Id =-=-=-=-=-=-=-=
  List<DropDownValue> employeeIdLists = [];
  Future<void> employeeIdList({required String token}) async {
    try {
      isloading = true;
      final response = await EmployeeProvider().employeeId(token: token);
      if (response != null) {
        employeeIdLists = response
            .map((e) => DropDownValue(id: e.id, value: e.name))
            .toList();
        notifyListeners();
      }
      isloading = false;
    } catch (e) {
      isloading = false;
    }
  }

  Future resetData() async {
    employee = EmployeeModel(id: 0);
    nameController = TextEditingController();
    phoneController = TextEditingController();
    totalEarningsController = TextEditingController();
    currentRatingController = TextEditingController();
    codeController = TextEditingController();
    dobController = TextEditingController();
    bloodGroupController = TextEditingController();
    homeContact = TextEditingController();
    emailTextController = TextEditingController();
    addressContactTxtController = TextEditingController();
    idNumberTxtController = TextEditingController();
    idProofTypeController = TextEditingController();
    idProofNumberController = TextEditingController();
  }

  //name validators
  String? nameValidator(String? value) {
    if (value!.isEmpty) {
      return "Name Required..";
    } else {
      return null;
    }
  }

  String? codeValidator(String? val) {
    if (val!.isEmpty) {
      return "Code Required..";
    } else {
      return null;
    }
  }

  // emp type validator
  String? empTypeValidator(DropDownValue? value) {
    if (value == null) {
      return 'Please select an option';
    }
    return null;
  }

  //phone validators
  String? phoneValidator(String? value) {
    if (value!.isEmpty) {
      return "Phone Required..";
    } else if (value.length < 10 || value.length > 10) {
      return "Invalid phone number";
    } else {
      return null;
    }
  }

  // email validator
  String? emailValidator(String? value) {
    if (value == null || value.isEmpty) {
      return "Email is required";
    }
    const emailPattern = r'^[\w-]+(\.[\w-]+)*@[\w-]+(\.[\w-]+)+$';
    final regExp = RegExp(emailPattern);
    if (!regExp.hasMatch(value)) {
      return "Invalid email address";
    }
    return null;
  }

  //dob validators
  String? dobValidator(String? value) {
    if (value!.isEmpty) {
      return "Date of birth Required..";
    } else {
      return null;
    }
  }

  //home contact validators
  String? homeContactValidator(String? value) {
    if (value!.isEmpty) {
      return "home Contact Required..";
    } else {
      return null;
    }
  }

  //address validators
  String? addressValidator(String? value) {
    if (value!.isEmpty) {
      return "Address Required..";
    } else {
      return null;
    }
  }

  // id type validator
  String? idTypeValidator(DropDownValue? value) {
    if (value == null) {
      return 'Please select an option';
    }
    return null;
  }

  //id proof validators
  String? idProofValidator(int? value) {
    if (value == 0) {
      return "Id proof type Required..";
    } else {
      return null;
    }
  }

  //id number validators
  String? idNumberValidator(String? value) {
    if (value!.isEmpty) {
      return "Id number Required..";
    } else {
      return null;
    }
  }

  //Blood Group Validator
  String? bloodGroupValidator(String? value) {
    if (value == 0) {
      return "Id number Required..";
    } else {
      return null;
    }
  }

  changeDateOfBirth(BuildContext context) async {
    DateTime? date = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1960),
      lastDate: DateTime(2100),
    );

    if (date != null) {
      dob = date;
      dobController.text = formatDate(dob);
      log(dobController.text);
      employee.dob = dobController.text;
    }
  }

  String formatDate(DateTime inputDate) {
    try {
      final inputFormat = DateFormat('dd-MMM-yyyy').format(inputDate);
      return inputFormat;
    } catch (e) {
      return "Invalid Date";
    }
  }

  //=-=-=-=-=-=-= Employee Init State Loading =-=-=-=-==-=-=-=

  bool isEdit = false;
  Future<void> employeeInitStateLoading(
      {EmployeeDetailResponse? data, String token = ""}) async {
    await employeeIdList(token: token);
    await employeeTypesData(token: token);
    if (data == null) {
      nameController.clear();
      phoneController.clear();
      addressContactTxtController.clear();
      bloodGroupController.clear();
      homeContact.clear();
      emailTextController.clear();
      codeController.clear();
      idNumberTxtController.clear();
      dobController.clear();
      selectedIdType = null;
      selectedEmpType = null;
      isEdit = false;
    } else {
      isEdit = true;
      employee = EmployeeModel(
        address: data.address,
        bloodGroup: data.bloodGroup,
        code: data.code,
        createdAt: data.createdAt!.toIso8601String(),
        currentRating: data.currentRating,
        dob: data.dob!.toIso8601String(),
        email: data.email,
        employeeMobile: data.employeeMobile,
        employeeName: data.employeeName,
        employeeType: data.employeeType,
        homeContact: data.homeContact,
        id: data.id,
        idProofNumber: data.idProofNumber,
        idProofType: data.idProofType,
        image: data.image,
        isActive: data.isActive,
        totalEarnings: data.totalEarnings,
        updatedAt: data.updatedAt!.toIso8601String(),
        user: data.user
      );
      nameController.text = data.employeeName ?? '';
      phoneController.text = data.employeeMobile ?? '';
      addressContactTxtController.text = data.address ?? '';
      bloodGroupController.text = data.bloodGroup ?? '';
      homeContact.text = data.homeContact ?? '';
      emailTextController.text = data.email ?? '';
      codeController.text = data.code ?? '';
      idNumberTxtController.text = data.idProofNumber ?? '';
      dobController.text = formatDate(data.dob!);
      selectedEmpType = types.singleWhere((x) => x.id == data.employeeType!);
      selectedIdType =
          employeeIdLists.singleWhere((x) => x.id == data.idProofType!);
    }
  }

  Future<void> editEmployee(
      {required String token, required BuildContext context}) async {
    if (employeeForm.currentState!.validate()) {
      employeeForm.currentState!.save();
      EmployeeDetailsModel itemToUpdate = EmployeeDetailsModel();
      itemToUpdate.address = employee.address;
      itemToUpdate.bloodGroup = employee.bloodGroup;
      itemToUpdate.code = employee.code;
      itemToUpdate.createdAt = DateTime.parse(employee.createdAt!);
      itemToUpdate.currentRating = employee.currentRating;
      itemToUpdate.dob = employee.dob!.toDate();
      itemToUpdate.email = employee.email;
      itemToUpdate.employeeMobile = employee.employeeMobile;
      itemToUpdate.employeeName = employee.employeeName;
      itemToUpdate.employeeType = employee.employeeType;
      itemToUpdate.homeContact = employee.homeContact;
      itemToUpdate.id = employee.id;
      itemToUpdate.idProofNumber = employee.idProofNumber;
      itemToUpdate.idProofType = employee.idProofType;
      itemToUpdate.image = employee.image;
      itemToUpdate.isActive = employee.isActive;
      itemToUpdate.totalEarnings = employee.totalEarnings;
      itemToUpdate.updatedAt = DateTime.parse(employee.updatedAt!);
      itemToUpdate.user = employee.user;
      final response = await EmployeeProvider()
          .editEmployee(token: token, data: itemToUpdate);
      if (response != null) {
        rootScaffoldMessengerKey.currentState!.showSnackBar(
            snackBarWidget('Successfully Updated!', color: Colors.green));
        if (context.mounted) {
          Navigator.pop(context);
        }
        notifyListeners();
      }
      isloading = false;
    }
  }
}
