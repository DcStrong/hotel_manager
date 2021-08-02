import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:hotel_manager/helper/config_color.dart';

Widget buttonNeumorphic(String buttonText, BuildContext context, Function func ) {
    NeumorphicBoxShape boxShape =
      NeumorphicBoxShape.roundRect(BorderRadius.circular(10));
  double depth = 5;
  double intensity = 0.8;
  double surfaceIntensity = 0.5;
  double cornerRadius = 20;
  double height = 40.0;
  double width = 86.0;

  return Container(
    width: width,
    height: height,
    child: NeumorphicButton(
      padding: EdgeInsets.zero,
      duration: Duration(milliseconds: 300),
      onPressed: () {
        Navigator.pushNamedAndRemoveUntil(context, 'tabNavigator', (route) => false);
      },
      style: NeumorphicStyle(
        color: ConfigColor.bgColor,
        boxShape: boxShape,
        // boxShape: boxShape,
        // shape: this.shape,
        intensity: intensity,
        shadowLightColor: ConfigColor.shadowLightColor,
        shadowDarkColor: ConfigColor.shadowDarkColor.withOpacity(0.6),
        surfaceIntensity: surfaceIntensity,
        depth: depth,
        // lightSource: this.lightSource,
      ),
      child: Center(
        child: Text(buttonText, style: Theme.of(context).textTheme.headline2,),
      )
    ),
  );
}


Widget flatButtonNeumorphic(IconData icon,Function func) {
  return NeumorphicFloatingActionButton(
    style: NeumorphicStyle(
      color: Colors.transparent,
      shape: NeumorphicShape.flat,
      depth: 0,
    ),
    child: Container(
      child: Icon(icon, color: ConfigColor.assentColor,),
    ),
    onPressed: () {
      func();
    }
  );
}