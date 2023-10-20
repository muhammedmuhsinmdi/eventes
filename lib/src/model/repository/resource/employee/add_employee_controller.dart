import 'package:evantez/app/app.dart';
import 'package:evantez/src/model/components/snackbar_widget.dart';
import 'package:evantez/src/providers/resources/employee_type/employee_type_viewstate.dart';
import 'package:evantez/src/serializer/models/employee_type/employee_model.dart';
import 'package:evantez/src/view/core/widgets/drop_down_value.dart';
import 'package:flutter/material.dart';

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
      final response = await EmployeeProvider().addEmployee(
          token: token,
          data: employee);
      if (response != null) {
        rootScaffoldMessengerKey.currentState!
            .showSnackBar(snackBarWidget('Successfully added!', color: Colors.green));
        Navigator.pop(context);
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
    imageController = TextEditingController();
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

}
