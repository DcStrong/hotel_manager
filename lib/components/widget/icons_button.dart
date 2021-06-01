

import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:hotel_manager/helper/config_color.dart';
import 'package:hotel_manager/screen/screen_product.dart';

class NeomorfIconButton extends StatefulWidget {
  final String icons;
  final String text;
  final String path;
  final String routePath;
  NeomorfIconButton({Key ?key, required this.icons, required this.text, required this.path, required this.routePath}) : super(key: key);
  @override
  _NeomorfIconButtonState createState() => _NeomorfIconButtonState();
}

class _NeomorfIconButtonState extends State<NeomorfIconButton> {
  NeumorphicBoxShape boxShape =
      NeumorphicBoxShape.roundRect(BorderRadius.circular(10));
  double depth = 5;
  double intensity = 0.8;
  double surfaceIntensity = 0.5;
  double cornerRadius = 20;
  double height = 60.0;
  double width = 60.0;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: width,
          height: height,
          child: NeumorphicButton(
            padding: EdgeInsets.zero,
            duration: Duration(milliseconds: 300),
            onPressed: () {
              if(widget.routePath == 'screenProduct') {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return ScreenProduct(title: widget.text, path: widget.path,);
                }));
              } else {
                Navigator.pushNamed(context, widget.routePath);
              }
            },
            style: NeumorphicStyle(
              boxShape: boxShape,
              color: ConfigColor.bgColor,
              intensity: this.intensity,
              shadowLightColor: ConfigColor.shadowLightColor,
              shadowDarkColor: ConfigColor.shadowDarkColor.withOpacity(0.6),
              surfaceIntensity: this.surfaceIntensity,
              depth: depth,
            ),
            child: Container(
              margin: EdgeInsets.all(12),
              child: Image.asset(widget.icons),
            )
          ),
        ),
        SizedBox(height: 10,),
        Text(widget.text, style: Theme.of(context).textTheme.bodyText1,)
      ],
    );
  }
}