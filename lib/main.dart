import 'package:flutter/services.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:hotel_manager/helper/config_color.dart';
import 'package:hotel_manager/provider/basket_product.dart';
import 'package:hotel_manager/provider/home_menu.dart';
import 'package:hotel_manager/provider/user.dart';
import 'package:hotel_manager/provider/widget_factory_provider.dart';
import 'package:hotel_manager/routes.dart';
import 'package:provider/provider.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

void main() => runApp(
   MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => User()),
        ChangeNotifierProvider(create: (_) => HomeMenuProvider()),
        ChangeNotifierProvider(create: (_) => Basket()),
      ],
      child:  MyApp(),
    ),
);

class MyApp extends StatefulWidget {
  // This widget is the root of your application.
  @override
  MyAppState createState() => MyAppState();
}

class MyAppState extends State<MyApp> {

  @override
  Widget build(BuildContext context) {

    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    
    return WidgetFactoryProvider(
      child: MaterialApp(
        localizationsDelegates: [
          GlobalMaterialLocalizations.delegate
        ],
        onGenerateRoute: RouteGenerator.generateRoute,
        initialRoute: 'checkUserInHotel',
        theme: ThemeData(
          inputDecorationTheme: InputDecorationTheme(
            enabledBorder: UnderlineInputBorder(      
              borderSide: BorderSide(color: ConfigColor.additionalColor),   
            ),  
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: ConfigColor.assentColor, width: 3),
            ),
            border: UnderlineInputBorder(
              borderSide: BorderSide(color: ConfigColor.additionalColor),
            ),
          ),
          pageTransitionsTheme: PageTransitionsTheme(
            builders: {
              TargetPlatform.android: CupertinoPageTransitionsBuilder(),
              TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
            }
          ),
          fontFamily: 'MontseratMedium',
          textTheme: TextTheme(
            headline1: TextStyle(
              fontWeight: FontWeight.w600,
              color: ConfigColor.assentColor,
              fontSize: 16,
              fontFamily: 'MontseratMedium'
            ),
            headline2: TextStyle(
              fontFamily: 'MontseratMedium',
              color: ConfigColor.assentColor,
              fontSize: 14,
            ),
            headline3: TextStyle(
              fontFamily: 'MontseratMedium',
              fontWeight: FontWeight.w600,
              color: ConfigColor.additionalColor,
              fontSize: 14,
            ),
            bodyText1: TextStyle(
              fontFamily: 'MontseratRegular',
              height: 1.5,
              fontWeight: FontWeight.w300,
              fontSize: 14,
              color: ConfigColor.additionalColor
            ),
            bodyText2: TextStyle(
              fontFamily: 'MontseratMedium',
              height: 1.5,
              letterSpacing: 0.5,
              fontWeight: FontWeight.w400,
              fontSize: 12,
              color: ConfigColor.additionalColor
            ),
          ),
          accentColor: ConfigColor.bgColor,
          backgroundColor: ConfigColor.bgColor,
          primaryColor: ConfigColor.bgColor,
          scaffoldBackgroundColor: ConfigColor.bgColor
        ),
      ),
    );
  }
}
