// import 'dart:io';
// import 'package:evantez/src/model/core/app_prefs/app_prefs.dart';
// import 'package:evantez/src/model/helper/http_helper/http_exceptions.dart';
// import 'package:http/http.dart' as http;
// import 'dart:convert';
// import 'dart:async';

// class ApiBaseHelper {
//   final String _baseUrl = "http://13.232.16.235/api";

//   Future<dynamic> get(String url, {bool authorizedPost = true}) async {
//     var header = {
//       "content-type": "application/json",
//       "accept": "application/json",
//       'Authorization': 'Bearer ${AppPrefs.token}',
//     };
//     if (!authorizedPost) {
//       header = {"content-type": "application/json", "accept": "application/json"};
//     }
//     print('Api Get, url ${_baseUrl + url}');
//     var responseJson;
//     try {
//       final response = await http.get(Uri.parse(_baseUrl + url), headers: header);
//       responseJson = _returnResponse(response);
//     } on SocketException {
//       print('No net');
//       throw FetchDataException('No Internet connection');
//     }
//     print('api get recieved!');
//     return responseJson;
//   }

//   Future<dynamic> post(String url, dynamic body, {bool authorizedPost = true}) async {
//     print('Api Post, url $url');
//     var responseJson;
//     String urls = _baseUrl + url;
//     print(urls);
//     var header = {
//       "content-type": "application/json",
//       'Authorization': 'Bearer ${AppPrefs.token}',
//       "Access-Control-Allow-Origin": "*",
//       "Access-Control-Allow-Methods": "POST,GET,DELETE,PUT,OPTIONS"
//     };
//     if (!authorizedPost) {
//       header = {
//         "content-type": "application/json",
//         "Accept": "application/json",
//         "Access-Control-Allow-Origin": "*",
//         "Access-Control-Allow-Methods": "POST,GET,DELETE,PUT,OPTIONS"
//       };
//     }
//     try {
//       final response = await http.post(
//         Uri.parse(urls),
//         body: jsonEncode(body),
//         headers: header,
//       );
//       // var header1 = {
//       //   "content-type": "application/json",
//       //   'Authorization':
//       //       "Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1bmlxdWVfbmFtZSI6Ijg2MDY0NzEwOTYiLCJyb2xlIjoiQWRtaW4iLCJEYk5hbWUiOiJQQl8xIiwiQ2xpZW50TWFzdGVySUQiOiIxIiwiTWFzdGVyRGRJZCI6IjEiLCJVc2VySWQiOiIxIiwiQnJhbmNoSUQiOiIwIiwibmJmIjoxNjI5MjY1MzQ0LCJleHAiOjE2Mjk4NzAxNDQsImlhdCI6MTYyOTI2NTM0NH0.w1i9F_zOiT3-555boiG7F2qbG5hEhyF5QVz_Vuois38"
//       // };
//       // final response1 = await http.post(
//       //   Uri.parse('https://192.168.0.153:45455/Party/Save'),
//       //   body: jsonEncode(body),
//       //   headers: header,
//       // );
//       responseJson = await _returnResponse(response);
//     } on SocketException {
//       print('No net');
//       throw FetchDataException('No Internet connection');
//     }
//     print('api post.');
//     return responseJson;
//   }

//   Future<dynamic> put(String url, dynamic body) async {
//     print('Api Put, url $url');
//     var responseJson;
//     try {
//       final response = await http.put(Uri.parse(_baseUrl + url), body: body);
//       responseJson = _returnResponse(response);
//     } on SocketException {
//       print('No net');
//       throw FetchDataException('No Internet connection');
//     }
//     print('api put.');
//     print(responseJson.toString());
//     return responseJson;
//   }

//   Future<dynamic> delete(String url, {bool authorizedPost = true}) async {
//     print('Api delete, url $url');
//     var apiResponse;
//     var header = {
//       "content-type": "application/json",
//       'Authorization': 'Bearer ${AppPrefs.token}',
//       "Access-Control-Allow-Origin": "*",
//       "Access-Control-Allow-Methods": "POST,GET,DELETE,PUT,OPTIONS"
//     };
//     if (!authorizedPost) {
//       header = {
//         "content-type": "application/json",
//         "Accept": "application/json",
//         "Access-Control-Allow-Origin": "*",
//         "Access-Control-Allow-Methods": "POST,GET,DELETE,PUT,OPTIONS"
//       };
//     }
//     try {
//       final response = await http.delete(
//         Uri.parse(
//           _baseUrl + url,
//         ),
//         headers: header,
//       );
//       apiResponse = _returnResponse(response);
//     } on SocketException {
//       print('No net');
//       throw FetchDataException('No Internet connection');
//     }
//     print('api delete.');
//     return apiResponse;
//   }
// }

// dynamic _returnResponse(http.Response response) {
//   switch (response.statusCode) {
//     case 200:
//       var responseJson = json.decode(response.body.toString());
//       print(responseJson);
//       return responseJson;
//     case 400:
//       throw BadRequestException(response.body.toString());
//     case 401:
//     case 403:
//       throw UnauthorisedException(response.body.toString());
//     case 500:
//     default:
//       throw FetchDataException(
//           'Error occured while Communication with Server with StatusCode : ${response.statusCode}');
//   }
// }
