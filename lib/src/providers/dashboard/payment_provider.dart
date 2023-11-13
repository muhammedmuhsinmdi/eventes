import 'package:dio/dio.dart';
import 'package:evantez/src/view/core/event_api.dart';

class PaymentProvider extends EventApi {
  // load payment list
  Future getPaymentList(String token) async {
    Response response = await get('');
  }
}
