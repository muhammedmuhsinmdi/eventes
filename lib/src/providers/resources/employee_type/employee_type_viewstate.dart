import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:evantez/src/model/core/base_api_utilities.dart';
import 'package:evantez/src/serializer/models/employee/employee_details/employee_details_model.dart';
import 'package:evantez/src/serializer/models/employee/employee_details_response.dart';
import 'package:evantez/src/serializer/models/employee/employee_filter_model.dart';
import 'package:evantez/src/serializer/models/employee/employee_list_response.dart';
import 'package:evantez/src/serializer/models/employee/employee_payment_details.dart';
import 'package:evantez/src/serializer/models/employee/employee_type/employee_model.dart';
import 'package:evantez/src/serializer/models/employee/employee_type_request.dart';
import 'package:evantez/src/serializer/models/employee/employee_types_response.dart';
import 'package:evantez/src/serializer/models/employee_detail_reponse.dart';
import 'package:evantez/src/serializer/models/employee_rating_response.dart';
import 'package:evantez/src/view/core/event_api.dart';

import '../../../serializer/models/employee/employee_proof_response.dart';

class EmployeeProvider extends EventApi {
  Future<List<EmployeeListResponse>> loadEmployee(
      {required String token, EmployeeFilterInputModel? filterMode}) async {
    ///?${filterMode!.toQueryParam()}
    filterMode ??= EmployeeFilterInputModel();
    var queryParam = filterMode.toQueryParam();
    Response response = await get('users/employee/?$queryParam', headers: apiHeaders(token));
    switch (response.statusCode) {
      case 200:
        return (response.data['results'] as List).map((e) => EmployeeListResponse.fromJson(e)).toList();

      default:
        throw Exception('Response Error');
    }
  }

  //=-=-=-=-=-=-= Employee Details =-=-=-=-=-=-=
  Future<EmployeeDetailResponse> loadEmployeeDetails({required String token, required int id}) async {
    Response response = await get('users/employee/$id/', headers: apiHeaders(token));
    switch (response.statusCode) {
      case 200:
        return EmployeeDetailResponse.fromJson(response.data);
      default:
        throw Exception('Response Error');
    }
  }

  //=-=-=-=-=-=-=-= Employees Types =-=-=-=-=-=-=
  Future<List<EmployeesTypesList>> loadEmployeesTypes({required String token}) async {
    Response response = await get('users/employee-type/', headers: apiHeaders(token));
    switch (response.statusCode) {
      case 200:
        return (response.data['results'] as List).map((e) => EmployeesTypesList.fromJson(e)).toList();

      default:
        throw Exception('Response Error');
    }
  }

  //=-=-=-=-=-=-=-= Employees Types =-=-=-=-=-=-=
  Future<EmployeesTypesList> getEmployeeType({required String token, required int typeId}) async {
    Response response = await get('users/employee-type/$typeId', headers: apiHeaders(token));
    switch (response.statusCode) {
      case 200:
        return EmployeesTypesList.fromJson(response.data);

      default:
        throw Exception('Response Error');
    }
  }

  //=-=-=-=-=-=-= Employee Details =-=-=-=-=-=-=
  Future<EmployeeBank> employeePayment({required String token, required int id}) async {
    Response response = await get('users/employee-payment-detail/$id', headers: apiHeaders(token));
    switch (response.statusCode) {
      case 200:
        return EmployeeBank.fromJson(response.data);
      default:
        throw Exception('Response Error');
    }
  }

  //=-=-=-=-=-=-= Employee ADdd =-=-=-=-=-=-=
  Future<EmployeeDetails> addEmployee({required String token, required EmployeeModel data}) async {
    var jsonData = data.toAddJson();
    var dd = json.encode(jsonData);
    Response response =
        await post('users/employee/', data: json.encode(jsonData), headers: apiHeaders(token));
    switch (response.statusCode) {
      case 200:
      case 201:
        return EmployeeDetails.fromJson(response.data);
      default:
        throw Exception('Response Error');
    }
  }

  //=-=-=-=-=-=-= Employee Edit =-=-=-=-=-=-=
  Future<EmployeeDetails> editEmployee({required String token, required EmployeeDetailsModel data}) async {
    var jsonData = data.toJson();
    var dd = json.encode(jsonData);
    Response response =
        await patch('users/employee/${data.id}/', data: json.encode(jsonData), headers: apiHeaders(token));
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
    Response response = await get('users/employee-id-proof-type/', headers: apiHeaders(token));
    switch (response.statusCode) {
      case 200:
        return (response.data['results'] as List).map((e) => EmployeeIdList.fromJson(e)).toList();

      default:
        throw Exception('Response Error');
    }
  }

  //=-=-=-=-=-=-= Add Employee Type =-=-=-=-=-=-=

  Future<dynamic> addEmployeeType(
      {required String token, required String name, required String code, required int amount}) async {
    Response response = await post('users/employee-type/',
        data: {"name": name, "code": code, "amount": amount}, headers: apiHeaders(token));
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
      {required String token, required int id, required EmployeeTypeRequest data}) async {
    Response response =
        await patch('users/employee-type/$id/', data: data.toJson(), headers: apiHeaders(token));
    switch (response.statusCode) {
      case 200:
      case 201:
        return EmployeesTypesList.fromJson(response.data);
      default:
        throw Exception('Response Error');
    }
  }

  // delete employee type
  Future<dynamic> deleteEmployeeType({
    required String token,
    required int id,
  }) async {
    try {
      Response response = await delete('users/employee-type/$id/', headers: apiHeaders(token));
      switch (response.statusCode) {
        case 200:
        case 204:
          return true;
        default:
          throw Exception('Response Error');
      }
    } catch (e) {
      rethrow;
    }
  }

  //=-=-=-=-=-=-= Employee Rating History =-=-=-=-=-=-=

  Future<List<EmployeeRatingHistoryResponse>> employeeRatingHistory(
      {required String token, required String category}) async {
    Response response = await get('users/employee-rating-history/', headers: apiHeaders(token));
    switch (response.statusCode) {
      case 200:
      case 201:
        return (response.data['results'] as List)
            .map((e) => EmployeeRatingHistoryResponse.fromJson(e))
            .toList();
      default:
        throw Exception('Response Error');
    }
  }

  //=-=-=-=-=-=-= users_employee_payment_detalis_list =-=-=-=-=-=-=

  Future<List<EmployeePaymentDetail>> employeePaymentDetalis(
      {required String token, required int employeeId}) async {
    Response response =
        await get('users/employee-payment-detalis/?employee=$employeeId', headers: apiHeaders(token));
    switch (response.statusCode) {
      case 200:
      case 201:
        return (response.data['results'] as List).map((e) => EmployeePaymentDetail.fromJson(e)).toList();
      default:
        throw Exception('Response Error');
    }
  }
}
