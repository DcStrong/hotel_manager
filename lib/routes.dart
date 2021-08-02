import 'package:flutter/material.dart';
import 'package:hotel_manager/components/tab_navigator/tab_navigator.dart';
import 'package:hotel_manager/screen/animation.dart';
import 'package:hotel_manager/screen/auth/auth_screen.dart';
import 'package:hotel_manager/screen/auth/register_screen.dart';
import 'package:hotel_manager/screen/check_user_in_hotel.dart';
import 'package:hotel_manager/screen/home.dart';
import 'package:hotel_manager/screen/product_section/activities.dart';
import 'package:hotel_manager/screen/product_section/excursions.dart';
import 'package:hotel_manager/screen/product_section/fitness.dart';
import 'package:hotel_manager/screen/product_section/pools.dart';
import 'package:hotel_manager/screen/product_section/spa/spa_categories.dart';
import 'package:hotel_manager/screen/product_section/stocks.dart';
import 'package:hotel_manager/screen/profile/components/profile.dart';
import 'package:hotel_manager/screen/profile/components/profile_help.dart';
import 'package:hotel_manager/screen/profile/components/profile_my_orders.dart';
import 'package:hotel_manager/screen/restorant/basket.dart';
import 'package:hotel_manager/screen/restorant/basket_order.dart';
import 'package:hotel_manager/screen/restorant/products.dart';
import 'package:hotel_manager/screen/restorant/restorant.dart';
import 'package:hotel_manager/screen/restorant/restorant_dev.dart';

import 'components/widget/form/spa_form.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    // final Map arguments;
    // Getting arguments passed in while calling Navigator.pushNamed
    // final Object? args = settings.arguments;
    switch (settings.name) {
      case 'home':
        return MaterialPageRoute(builder: (_) => MyHomePage());
      case 'tabNavigator':
        return MaterialPageRoute(builder: (_) => TabNavigator());
      case 'checkUserInHotel':
        return MaterialPageRoute(builder: (_) => CheckUserInHotel());
      case 'auth':
        return MaterialPageRoute(builder: (_) => AuthScreen());
      case 'register':
        return MaterialPageRoute(builder: (_) => RegisterScreen());
      case 'animation':
        return MaterialPageRoute(builder: (_) => AnimationScreen());
      case 'profile':
        return MaterialPageRoute(builder: (_) => Profile());
      case 'fitness':
        return MaterialPageRoute(builder: (_) => FitnesSection());
      case 'pools':
        return MaterialPageRoute(builder: (_) => PoolsSection());
      case 'stocks':
        return MaterialPageRoute(builder: (_) => StocksSection());
      case 'excursions':
        return MaterialPageRoute(builder: (_) => ExcursionSection());
      case 'activities':
        return MaterialPageRoute(builder: (_) => ActivitiesSection());
      case 'spaCategories':
        return MaterialPageRoute(builder: (_) => SpaCategories());
      case 'restorant_dev':
        return MaterialPageRoute(builder: (_) => RestorantDevScreen());
      case 'restorant':
        return MaterialPageRoute(builder: (_) => RestorantScreen());
      case 'spa_form':
        return MaterialPageRoute(builder: (_) => SpaForm());
      case 'basket':
        return MaterialPageRoute(builder: (_) => BasketScreen());
      case 'basket_order':
        return MaterialPageRoute(builder: (_) => BasketOrder());
      case 'profile_help':
        return MaterialPageRoute(builder: (_) => ProfileHelp());
      case 'profile_my_orders':
        return MaterialPageRoute(builder: (_) => ProfileMyOrders());
      default:
        // If there is no such named route in the switch statement, e.g. /third
        return MaterialPageRoute(
            builder: (_) =>
                Scaffold(body: SafeArea(child: Text('Route Error'))));
    }
  }
}