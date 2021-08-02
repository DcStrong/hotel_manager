import 'dart:convert';

import 'package:hotel_manager/model/food.dart';

class UserFood {
  int id;
  UserFoodOrderStatus status;

  UserFood({
    required this.id,
    required this.status,
  });

  factory UserFood.fromJSON(Map<String, dynamic> jsonMap) => UserFood(
    id: jsonMap['id'],
    status: UserFoodOrderStatus.fromJSON(jsonMap['order_status']),
  );
}

class UserFoodOrderStatus {
  int id;
  String value;

  UserFoodOrderStatus({ required this.id, required this.value });

  factory UserFoodOrderStatus.fromJSON(Map<String, dynamic> jsonMap) => UserFoodOrderStatus(
    id: jsonMap['id'],
    value: jsonMap['value'],
  );
}

class OrderType {
  int id;
  String value;

  OrderType({ required this.id, required this.value });

  factory OrderType.fromJSON(Map<String, dynamic> jsonMap) => OrderType(
    id: jsonMap['id'],
    value: jsonMap['value'],
  );
}

class UserFoodDetail {
  int id;
  int peopleCount;
  String price;
  String deliveryAt;
  String corps;
  String roomNumber;
  UserFoodOrderStatus status;
  OrderType orderType;
  String? comment;
  int? ratinFromUser;
  String? deliveryTime;
  String? rejectReason;
  List<Food> foods;

  UserFoodDetail({
    required this.id,
    required this.peopleCount,
    required this.price,
    required this.deliveryAt,
    required this.corps,
    required this.roomNumber,
    required this.status,
    required this.orderType,
    required this.foods,
    this.comment,
    this.ratinFromUser,
    this.deliveryTime,
    this.rejectReason,
  });

   factory UserFoodDetail.fromJSON(Map<String, dynamic> jsonMap) => UserFoodDetail(
      id: jsonMap['id'],
      peopleCount: jsonMap['people_counts'],
      price: jsonMap['full_price'].toString(),
      deliveryAt: jsonMap['delivery_at'] ?? null,
      corps: jsonMap['corps'],
      roomNumber: jsonMap['room_number'],
      comment: jsonMap['comment'] == '' ? null : jsonMap['comment'],
      ratinFromUser: jsonMap['ratin_from_user'] ?? null,
      deliveryTime: jsonMap['dalivery_time'] ?? null,
      rejectReason: jsonMap['reject_reason'] ?? null,
      status: UserFoodOrderStatus.fromJSON(jsonMap['order_status']),
      orderType: OrderType.fromJSON(jsonMap['order_type']),
      foods: jsonMap['foods'].map<Food>((e) => Food.fromJSON(e['food'], quant: e['quantity'])).toList()
   );
}

