import 'package:dio/dio.dart';
import 'package:evantez/src/model/core/app_url/app_urls.dart';
import 'package:evantez/src/model/core/base_api.dart';
import 'package:evantez/src/providers/auth/login/login_providers.dart';

class EventApi extends BaseApi {
  EventsAuth? eventAuthApi;

  EventApi() {
    BaseOptions options = BaseOptions(
      baseUrl: AppUrl.baseUrl,
      headers: {},
    );
    dio = Dio(options);
    eventAuthApi = EventsAuth();
  }

  Future<bool> verifyToken() async {
    bool tokenVerified = await eventAuthApi!.verifyToken();
    if (tokenVerified) {}
    return tokenVerified;
  }
}
