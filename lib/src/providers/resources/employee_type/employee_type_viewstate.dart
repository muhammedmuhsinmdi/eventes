import 'package:dio/dio.dart';
import 'package:evantez/src/model/core/base_api_utilities.dart';
import 'package:evantez/src/serializer/models/employee_details_response.dart';
import 'package:evantez/src/serializer/models/employee_list_response.dart';
import 'package:evantez/src/serializer/models/employee_payment_details.dart';
import 'package:evantez/src/serializer/models/employee_request.dart';
import 'package:evantez/src/serializer/models/employee_type_request.dart';
import 'package:evantez/src/serializer/models/employee_types_response.dart';
import 'package:evantez/src/view/core/event_api.dart';

import '../../../serializer/models/employee_proof_response.dart';

class EmployeeProvider extends EventApi {
  Future<List<EmployeeListResponse>> loadEmployee(
      {required String token}) async {
    Response response =
        await get('users/employee/', headers: apiHeaders(token));
    switch (response.statusCode) {
      case 200:
        return (response.data['results'] as List)
            .map((e) => EmployeeListResponse.fromJson(e))
            .toList();

      default:
        throw Exception('Response Error');
    }
  }

  //=-=-=-=-=-=-= Employee Details =-=-=-=-=-=-=
  Future<EmployeeDetails> loadEmployeeDetails(
      {required String token, required int id}) async {
    Response response =
        await get('users/employee/$id', headers: apiHeaders(token));
    switch (response.statusCode) {
      case 200:
        return EmployeeDetails.fromJson(response.data);
      default:
        throw Exception('Response Error');
    }
  }

  //=-=-=-=-=-=-=-= Employees Types =-=-=-=-=-=-=
  Future<List<EmployeesTypesList>> loadEmployeesTypes(
      {required String token}) async {
    Response response =
        await get('users/employee-type/', headers: apiHeaders(token));
    switch (response.statusCode) {
      case 200:
        return (response.data['results'] as List)
            .map((e) => EmployeesTypesList.fromJson(e))
            .toList();

      default:
        throw Exception('Response Error');
    }
  }

  //=-=-=-=-=-=-= Employee Details =-=-=-=-=-=-=
  Future<EmployeeBank> employeePayment(
      {required String token, required int id}) async {
    Response response = await get('users/employee-payment-detail/$id',
        headers: apiHeaders(token));
    switch (response.statusCode) {
      case 200:
        return EmployeeBank.fromJson(response.data);
      default:
        throw Exception('Response Error');
    }
  }

  //=-=-=-=-=-=-= Employee ADdd =-=-=-=-=-=-=
  Future<EmployeeDetails> addEmployee(
      {required String token, required EmployeeRequest data}) async {
    Response response = await post('users/employee/',
        data: data.toJson(), headers: apiHeaders(token));
    switch (response.statusCode) {
      case 200:
      case 201:
        return EmployeeDetails.fromJson(response.data);
      default:
        throw Exception('Response Error');
    }
  }

  //=-=-=-=-=-=-=-= Employee ID =-=-=-=-=-=-=

  Future<List<EmployeeIdList>> employeeId({required String token}) async {
    Response response =
        await get('users/employee-id-proof-type/', headers: apiHeaders(token));
    switch (response.statusCode) {
      case 200:
        return (response.data['results'] as List)
            .map((e) => EmployeeIdList.fromJson(e))
            .toList();

      default:
        throw Exception('Response Error');
    }
  }

  //=-=-=-=-=-=-= Add Employee Type =-=-=-=-=-=-=

  Future<dynamic> addEmployeeType(
      {required String token,
      required String name,
      required String code,
      required int amount}) async {
    Response response = await post('users/employee-type/',
        data: {"name": name, "code": code, "amount": amount},
        headers: apiHeaders(token));
    switch (response.statusCode) {
      case 200:
      case 201:
        return response.data;
      default:
        throw Exception('Response Error');
    }
  }

  //=-=-=-=-=-=-= Patch Employee Type =-=-=-=-=-=-=

  Future<dynamic> editEmployeeType(
      {required String token,
      required int id,
      required EmployeeTypeRequest data}) async {
    Response response = await patch('users/employee-type/$id/',
        data: data.toJson(), headers: apiHeaders(token));
    switch (response.statusCode) {
      case 200:
      case 201:
        return EmployeesTypesList.fromJson(response.data);
      default:
        throw Exception('Response Error');
    }
  }
}
