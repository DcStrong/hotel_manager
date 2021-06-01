import 'package:dio/dio.dart';
import 'package:hotel_manager/middleware/card.dart';
import 'package:hotel_manager/model/card_with_excursion.dart';

class CardWithExcursionMiddleware extends Interceptor with CardMiddleware {
  CardWithExcursionMiddleware();

  final type = 'excursion_card';

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    final responseDataType = super.getResponseDataType(response.data);
    if (responseDataType == this.type) {
      response.data = this.createWidgetFromData(response.data['data']);
    }

    return super.onResponse(response, handler);
  }

  CardWithExcursionModel createWidgetFromData(dynamic data) {
    return new CardWithExcursionModel.fromJSON(data);
  }
}