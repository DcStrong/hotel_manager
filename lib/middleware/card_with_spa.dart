import 'package:dio/dio.dart';
import 'package:hotel_manager/middleware/card.dart';
import 'package:hotel_manager/model/card_with_spa.dart';

class CardWithSpaMiddleware extends Interceptor with CardMiddleware {
  CardWithSpaMiddleware();

  final type = 'spa_card';

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    final responseDataType = super.getResponseDataType(response.data);
    if (responseDataType == this.type) {
      response.data = this.createWidgetFromData(response.data['data']);
    }

    return super.onResponse(response, handler);
  }

  CardWithSpaModel createWidgetFromData(dynamic data) {
    return new CardWithSpaModel.fromJSON(data);
  }
}