import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hotel_manager/helper/message_exception.dart';
import 'package:hotel_manager/model/activiti_form.dart';
import 'package:hotel_manager/model/animation.dart';
import 'package:hotel_manager/model/animation_types.dart';
import 'package:hotel_manager/model/animation_week_day.dart';
import 'package:hotel_manager/model/basket_produts.dart';
import 'package:hotel_manager/model/card_model.dart';
import 'package:hotel_manager/model/detail_food.dart';
import 'package:hotel_manager/model/feedback_service.dart';
import 'package:hotel_manager/model/food.dart';
import 'package:hotel_manager/model/restourant.dart';
import 'package:hotel_manager/model/spa_form.dart';
import 'package:hotel_manager/model/user.dart';
import 'package:hotel_manager/model/user_food.dart';
import 'package:hotel_manager/provider/home_menu.dart';
import 'package:hotel_manager/repository/dio.dart';
import 'package:provider/provider.dart';

class ApiRouter {

  static Future<List> getSectionStocksForHome() async {
    String path = 'stocks';
    List data = [];
    try {
      var response = await dio.get(path, queryParameters: {'main_page': 1});
      List responseMap = response.data['data'];
      print(responseMap);
      responseMap.forEach((element) {
        data.add(CardModel.fromJSON(element));
      });

      return data;
    } catch(e) {
      return [];
    }
  }

  static Future<List> getSectionPoolForHome() async {
    String path = 'pools';
    List data = [];
    try {
      var response = await dio.get(path, queryParameters: {'main_page': 1});
      List responseMap = response.data['data'];
      print(responseMap);
      responseMap.forEach((element) {
        data.add(CardModel.fromJSON(element));
      });

      return data;
    } catch(e) {
      return [];
    }
  }

  static Future<List> getSectionActivitiesForHome({int? page = 1}) async {
    String path = 'activities';
    List data = [];
    try {
      var response = await dio.get(path, queryParameters: {'main_page': 1, 'page': page});
      List responseMap = response.data['data'];
      print(responseMap);
      responseMap.forEach((element) {
        data.add(CardModel.fromJSON(element));
      });

      return data;
    } catch(e) {
      return [];
    }
  }

  static Future<List> getSectionExcursionsForHome() async {
    String path = 'excursions';
    List data = [];
    try {
      var response = await dio.get(path, queryParameters: {'main_page': 1});
      List responseMap = response.data['data'];
      print(responseMap);
      responseMap.forEach((element) {
        data.add(CardModel.fromJSON(element));
      });

      return data;
    } catch(e) {
      return [];
    }
  }

  static Future<List<CardModel>> getSectionFitnesForHome() async {
    String path = 'fitness';
    List<CardModel> data = [];
    try {
      var response = await dio.get(path, queryParameters: {'main_page': 1});
      List responseMap = response.data['data'];
      print(responseMap);
      responseMap.forEach((element) {
        data.add(CardModel.fromJSON(element));
      });

      return data;
    } catch(e) {
      return [];
    }
  }

  static Future<List> getSectionSpaForHome() async {
    String path = 'spa-procedures';
    List data = [];
    try {
      var response = await dio.get(path, queryParameters: {'main_page': 1});
      List responseMap = response.data['data'];
      print(responseMap);
      responseMap.forEach((element) {
        data.add(CardModel.fromJSON(element));
      });

      return data;
    } catch(e) {
      return [];
    }
  }

  static Future<List> getCategoriesSpa() async {
    String path = 'spa-categories';
    List data = [];
    var response = await dio.get(path);
    List responseMap = response.data['data']['data'];
    print(responseMap);
    responseMap.forEach((element) {
      data.add(CardModel.fromJSON(element));
    });
    return data;
  }

  static Future<UserFoodDetail> getDetailMyOrder(int id) async {
    String path = 'client/user_order/${id}';
    var response = await dio.get(path);
    Map<String, dynamic> responseMap = response.data['data'];
    return UserFoodDetail.fromJSON(responseMap);
  }

   static Future<Map<String, dynamic>> getSectionSpaCard({int ?categoryId, int page = 1, int ?typeId}) async {
    List data = [];
    var response = await dio.get('spa-procedures', queryParameters: {'category_id' : categoryId, 'count': 15, 'page': page, 'type_id' : typeId});
    List responseMapProduct = response.data['data']['data'];
    List responseMapType = response.data['spa_types'];
    responseMapProduct.forEach((element) {
      data.add(CardModel.fromJSON(element));
    });
    Map<String, dynamic> result = {
      'types': responseMapType,
      'products': data
    };
    return result;
  }


  static Future<List> getSectionCard(String path, {int ?categoryId, int? page = 1}) async {
    List data = [];
    var response = await dio.get(path, queryParameters: {'category_id' : categoryId, 'page': page});
    List responseMap = response.data['data']['data'];
    responseMap.forEach((element) {
      data.add(CardModel.fromJSON(element));
    });
    return data;
  }

  static Future<dynamic> getDetailCard(int id, String path) async {
    var response = await dio.get('$path/$id');
    return response.data;
  }

  static Future<List<AnimationType>> getAnimationType() async {
    List<AnimationType> data = [];
    var response = await dio.get('get_animations_types');
    List responseMap = response.data['data'];
    responseMap.forEach((e) {
      data.add(AnimationType.fromJSON(e));
    });
    return data;
  }

  static Future<List<AnimationWeekDay>> getDayWeekAnimation() async {
    List<AnimationWeekDay> data = [];
    var response = await dio.get('get_days_of_week');
    List responseMap = response.data['data'];
    responseMap.forEach((e) {
      data.add(AnimationWeekDay.fromJSON(e));
    });
    return data;
  }

  static Future<List<AnimationModel>> getAnimations(int forAdults, int dayOfWeekId) async {
    List<AnimationModel> data = [];
    var response = await dio.get('animations', queryParameters: {'for_adults': forAdults, 'days_of_week_id' : dayOfWeekId});
    print(response);
    List responseMap = response.data['data'];
    if(responseMap.length == 0) {
      return data;
    }
    responseMap.forEach((e) { 
      data.add(AnimationModel.fromJSON(e));
    });
    return data;
  }

  static Future<List<AnimationModel>> getAllAnimations(int forAdults) async {
    List<AnimationModel> data = [];
    var response = await dio.get('animations', queryParameters: {'for_adults': forAdults});
    print(response);
    List responseMap = response.data['data'];
    if(responseMap.length == 0) {
      return data;
    }
    responseMap.forEach((e) { 
      data.add(AnimationModel.fromJSON(e));
    });
    return data;
  }

  static Future<List<FeedbackService>> getServiceInfo() async {
    List<FeedbackService> data = [];
    var response = await dio.get('profile/service_phones');
    List responseMap = response.data['phones'];
    responseMap.forEach((element) {
      data.add(FeedbackService.fromJSON(element));
    });
    return data;
  }

  // static Future<List<FeedbackService>> 
  static Future<List<UserFood>> getUserOrdersList(String token) async {
    List<UserFood> data = [];
    dio.options.headers['Authorization'] = "Bearer " + token;
    var response = await dio.get('client/user_order_list');
    List responseMap = response.data['data']['data'];
    if(responseMap.length == 0)
      return data;
    responseMap.forEach((element) {
      data.add(UserFood.fromJSON(element));
    });
    return data;
  }

  static auth(String email, String password) async {
    Map<String, dynamic> params = {
      'login': email,
      'password': password
    };

    try {
      var response = await dio.post('sign_in', queryParameters: params);

      UserModel user = UserModel.fromJSON(response.data['user']);
      user.token = response.data['token'];

      return user;

    } on DioError catch (e) {
      print(e);
      throw MessageException(e.response?.data['message']);
    }
  }

  static register(String lastName, String name, String email, String phone, String password, String passwordConfirm) async {
    Map<String, dynamic> params = {
      'first_name': name,
      'second_name': lastName,
      'email': email,
      'phone': phone,
      'password': password,
      'password_confirmation': passwordConfirm,
    };
    try {

      dio.options.headers['content-Type'] = 'application/json';
      dio.options.headers['Accept'] = 'application/json';

      var response = await dio.post('register', queryParameters: params);
      UserModel user = UserModel.fromJSON(response.data['user']);

      user.token = response.data['token'];

      return user;

    } on DioError catch (e) {
      if(e.response?.data['errors'].containsKey('phone')){
        throw MessageException(e.response?.data['errors']['phone'][0]);
      } else if(e.response?.data['errors'].containsKey('email')) {
        throw MessageException(e.response?.data['errors']['email'][0]);
      }
    }
  }

  static Future<List> getProductCategories(int restourantId) async {
    dio.options.headers['Content-Type'] = 'application/json';
    dio.options.headers['Accept'] = 'application/json';

    var response = await dio.get('client/food-categories', queryParameters: {'restaurant_id': restourantId });
    return response.data['data'];
  }

  static Future<bool> createRequestForSpa(SpaFormModel formModel) async {
   Map<String, dynamic> params = {
     'owner_id': formModel.ownerId,
     'date_time': formModel.date,
     'first_name': formModel.lastName,
     'second_name': formModel.firstName,
     'phone': formModel.phone,
     'comment': formModel.comments ?? '',
     'category_id': formModel.categoryId,
     'procedure_id': formModel.procedureId
   };
   
    try {
      var response =  await dio.post('spa/create_request', queryParameters: params);
      if (response.statusCode == 200) {
        return true;
      }
      return false;
    } on DioError catch (e) {
      return false;
    }
  }

  static Future<bool> createRequestForActiviti(ActivitiFormModel formModel) async {
   Map<String, dynamic> params = {
     'owner_id': formModel.ownerId,
     'date_time': formModel.date,
     'first_name': formModel.lastName,
     'second_name': formModel.firstName,
     'phone': formModel.phone,
     'comment': formModel.comments ?? '',
     'activity_id': formModel.activityId,
   };
   
    try {
      var response =  await dio.post('activities/create_request', queryParameters: params);
      if (response.statusCode == 200) {
        return true;
      }
      return false;
    } on DioError catch (e) {
      return false;
    }
  }

  static Future<List<Restourant>> getRestorantList() async {
    List<Restourant> data = [];
    var response = await dio.get('client/restaurants');
    print(response);
    List responseMap = response.data['data'];
    responseMap.forEach((element) {
      data.add(Restourant.fromJSON(element));
    });
    return data;
  }

  static Future<List<Food>> getRestourantFoods(int id, {int? categoryId, int? page = 1}) async {
    print(page);
    List<Food> data = [];
    Map<String, dynamic> params = {
     'restaurant_id': id,
     'food_category_id': categoryId,
     'page': page,
     'count': 14,
   };

    var response = await dio.get('client/foods', queryParameters: params);
    List responseMap = response.data['data']['data'];
    responseMap.forEach((element) {
      data.add(Food.fromJSON(element));
    });

    return data;
  }

  static Future<List<BasketProducts>> addBasketFood(int id, String token) async {
    Map<String, dynamic> params = {
     'food_id': id,
    };

    List<BasketProducts> data = [];

    dio.options.headers['Authorization'] = "Bearer " + token;
    var response = await dio.get('client/basket_add_food', queryParameters: params);
    List responseMap = response.data['data'];
    responseMap.forEach((element) {
      data.add(BasketProducts.fromJSON(element));
    });

    return data;
  }

  static Future<DetailFood> getDetailFood(int id) async {
    String idFood = id.toString();
    var response = await dio.get('client/foods/$idFood');

    Map<String, dynamic> responseMap = response.data['data'];

    return DetailFood.fromJSON(responseMap);
  }

  static Future<void> sendSmsForResetPassword(String phone) async {
    await dio.post('reset_password_request', queryParameters: { "phone": phone });
  }

  static Future<void> resetPassword(String phone, String code, String password) async {
    Map<String, dynamic> param = {
      "phone": phone,
      "code": code,
      "new_password": password
    };

    await dio.post('reset_password', queryParameters: param);
  }

  static Future<List<BasketProducts>> removeBasketFood(int id, String token) async {
    Map<String, dynamic> params = {
     'food_id': id,
    };

    List<BasketProducts> data = [];

    dio.options.headers['Authorization'] = "Bearer " + token;
    var response = await dio.get('client/basket_delete_food', queryParameters: params);
    List responseMap = response.data['data'];
    responseMap.forEach((element) {
      data.add(BasketProducts.fromJSON(element));
    });

    return data;
  }

  static Future<List<BasketProducts>> getBasketFood(String token) async {
    List<BasketProducts> data = [];
    dio.options.headers['Authorization'] = "Bearer " + token;
    var response = await dio.get('client/get_basket');
    List responseMap = response.data['data'];
    responseMap.forEach((element) {
      data.add(BasketProducts.fromJSON(element));
    });

    return data;
  }

  static Future<List<Food>> getOrderHistoryDetail(int id, String token) async {
    List<Food> data = [];
    dio.options.headers['Authorization'] = "Bearer " + token;
    var response = await dio.get('client/user_order/${id}');
    List responseMap = response.data['data']['foods'];
    responseMap.forEach((element) {
      data.add(Food.fromJSON(element));
    });

    return data;
  }

  static Future<bool> sendOrder(
    String token,
    int roomNumber,
    List productList,
    int fullPrice,
    String corps,
    int orderTypeId,
    String comment,
    int pepleCount,
    String time,
  ) async {
    Map<String, dynamic> params = {
      'order_type_id': orderTypeId,
      'room_number': roomNumber,
      'basket': productList,
      'full_price': fullPrice,
      'people_counts': pepleCount,
      'corps': corps,
      'comment': comment,
      'delivery_at': time,
    };
    List<BasketProducts> data = [];
    dio.options.headers['Content-Type'] = 'application/json';
    dio.options.headers['Accept'] = 'application/json';
    dio.options.headers['Authorization'] = "Bearer " + token;
     try {
      var response = await dio.post('client/create_order', data: jsonEncode(params),);
      if (response.statusCode == 200) {
        return true;
      }
      return false;
    } on DioError catch (e) {
      print(e);
      return false;
    }
  }
}