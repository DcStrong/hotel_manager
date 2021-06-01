import 'package:flutter/rendering.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:hotel_manager/components/widget/home_menu.dart';
import 'package:hotel_manager/helper/config_color.dart';
import 'package:hotel_manager/screen/product_section/activities.dart';
import 'package:hotel_manager/screen/product_section/excursions.dart';
import 'package:hotel_manager/screen/product_section/fitness.dart';
import 'package:hotel_manager/screen/product_section/pools.dart';
import 'package:hotel_manager/screen/product_section/spa/spa.dart';
import 'package:hotel_manager/screen/product_section/stocks.dart';


class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ConfigColor.bgColor,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
            StocksSection(),
            HomeMenu(),
            SpaSection(),
            ActivitiesSection(),
            ExcursionSection(),
            FitnesSection(),
            PoolsSection()
          ],
        ),
        ),
      )
    );
  }
}