import 'package:dio/dio.dart';
import 'package:hotel_manager/middleware/card.dart';
import 'package:hotel_manager/model/card_with_text.dart';

class CardWithTextMiddleware extends Interceptor with CardMiddleware {
  CardWithTextMiddleware();

  final type = 'default_card';

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    final responseDataType = super.getResponseDataType(response.data);
    if (responseDataType == this.type) {
      response.data = this.createWidgetFromData(response.data['data']);
    }

    if (responseDataType == ' ') {
      response.data = this.createWidgetFromData(response.data['data']);
    }

    return super.onResponse(response, handler);
  }

  CardWithTextModel createWidgetFromData(dynamic data) {
    return new CardWithTextModel.fromJSON(data);
  }
}