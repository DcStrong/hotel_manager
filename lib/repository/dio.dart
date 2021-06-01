import 'package:dio/dio.dart';
import 'package:hotel_manager/middleware/card_with_activity.dart';
import 'package:hotel_manager/middleware/card_with_spa.dart';
import 'package:hotel_manager/middleware/card_with_excursion.dart';
import 'package:hotel_manager/middleware/card_with_text.dart';

Dio dio = Dio(BaseOptions(
  baseUrl: 'https://hotel-manager.ru/api/',
  headers: {'Content-Type': 'application/json'}
))
..interceptors.addAll([
  CardWithTextMiddleware(),
  CardWithExcursionMiddleware(),
  CardWithSpaMiddleware(),
  CardWithActivityTypeMiddleware()
]);