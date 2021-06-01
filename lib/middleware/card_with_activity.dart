import 'package:dio/dio.dart';
import 'package:hotel_manager/middleware/card.dart';
import 'package:hotel_manager/model/card_with_activity.dart';

class CardWithActivityTypeMiddleware extends Interceptor with CardMiddleware {
  CardWithActivityTypeMiddleware();

  final type = 'activity_card';

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    final responseDataType = super.getResponseDataType(response.data);
    if (responseDataType == this.type) {
      response.data = this.createWidgetFromData(response.data['data']);
    }

    return super.onResponse(response, handler);
  }

  CardWithActivityModel createWidgetFromData(dynamic data) {
    return new CardWithActivityModel.fromJSON(data);
  }
}