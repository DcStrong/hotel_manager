import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:hotel_manager/helper/config_color.dart';
import 'package:hotel_manager/provider/user.dart';
import 'package:provider/provider.dart';

class ButtonAnswer extends StatefulWidget {
  const ButtonAnswer({Key? key}) : super(key: key);

  @override
  _ButtonAnswerState createState() => _ButtonAnswerState();
}

class _ButtonAnswerState extends State<ButtonAnswer> {
  NeumorphicBoxShape boxShape =
      NeumorphicBoxShape.roundRect(BorderRadius.circular(10));
  double depth = 5;
  double intensity = 0.8;
  double surfaceIntensity = 0.5;
  double cornerRadius = 20;
  double height = 40.0;
  double width = 86.0;

  Widget button(String buttonText, Function func) {
    return Container(
      width: this.width,
      height: this.height,
      child: NeumorphicButton(
        padding: EdgeInsets.zero,
        duration: Duration(milliseconds: 300),
        onPressed: () {
          func();
          Navigator.pushNamedAndRemoveUntil(context, 'tabNavigator', (route) => false);
        },
        style: NeumorphicStyle(
          color: ConfigColor.bgColor,
          boxShape: boxShape,
          // boxShape: boxShape,
          // shape: this.shape,
          intensity: this.intensity,
          shadowLightColor: ConfigColor.shadowLightColor,
          shadowDarkColor: ConfigColor.shadowDarkColor.withOpacity(0.6),
          surfaceIntensity: this.surfaceIntensity,
          depth: depth,
          // lightSource: this.lightSource,
        ),
        child: Center(
          child: Text(buttonText, style: Theme.of(context).textTheme.headline2,),
        )
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        button('Да', () {
          context.read<User>().setUserInHotel(true);
        }),
        SizedBox(width: 26,),
        button('Нет', () {
          context.read<User>().setUserInHotel(false);
        }),
      ],
    );
  }
}