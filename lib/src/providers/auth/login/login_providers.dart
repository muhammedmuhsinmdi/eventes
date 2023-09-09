import 'package:dio/dio.dart';
import 'package:evantez/src/model/core/app_url/app_urls.dart';
import 'package:evantez/src/model/core/base_api.dart';
import 'package:evantez/src/view/view/auth/models/authresponse.dart';
import 'package:evantez/src/view/view/auth/models/error_response.dart';

class EventsAuth extends BaseApi {
  EventsAuth() {
    BaseOptions options = BaseOptions(
      baseUrl: AppUrl.baseUrl,
      headers: {},
    );
    dio = Dio(options);
  }
  Future<bool> verifyToken() async {
    return true;
  }

  Future<dynamic> login(
      {required String email, required String? password}) async {
    Response response =
        await post('token/', data: {"email": email, "password": password});
    switch (response.statusCode) {
      case 200:
        return AuthResponse.fromJson(response.data);
      case 400:
        return ErrorResponse.fromJson(response.data);
      default:
    }
  }
}
