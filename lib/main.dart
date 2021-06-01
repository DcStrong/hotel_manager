import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:hotel_manager/helper/config_color.dart';
import 'package:hotel_manager/provider/home_menu.dart';
import 'package:hotel_manager/provider/user.dart';
import 'package:hotel_manager/provider/widget_factory_provider.dart';
import 'package:hotel_manager/routes.dart';
import 'package:provider/provider.dart';

void main() => runApp(
   MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => User()),
        ChangeNotifierProvider(create: (_) => HomeMenuProvider()),
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
    return WidgetFactoryProvider(
      child: MaterialApp(
        onGenerateRoute: RouteGenerator.generateRoute,
        initialRoute: 'checkUserInHotel',
        theme: ThemeData(
          fontFamily: 'MontseratMedium',
          textTheme: TextTheme(
            headline1: TextStyle(
              fontWeight: FontWeight.w600,
              color: ConfigColor.assentColor,
              fontSize: 20,
              fontFamily: 'MontseratMedium'
            ),
            headline2: TextStyle(
              fontFamily: 'MontseratMedium',
              color: ConfigColor.assentColor,
              fontSize: 18,
            ),
            headline3: TextStyle(
              fontFamily: 'MontseratMedium',
              fontWeight: FontWeight.w600,
              color: ConfigColor.additionalColor,
              fontSize: 18,
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
              fontSize: 14,
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
