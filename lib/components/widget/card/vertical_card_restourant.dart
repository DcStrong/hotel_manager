import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:hotel_manager/components/buttons/button_elevated.dart';
import 'package:hotel_manager/helper/config_color.dart';
import 'package:hotel_manager/model/card_model.dart';
import 'package:hotel_manager/model/restourant.dart';
import 'package:hotel_manager/screen/restorant/products.dart';

class VerticalCardRestourant extends StatefulWidget {
  final Restourant restourant;
  VerticalCardRestourant({Key? key, required this.restourant}) : super(key: key);

  @override
  _VerticalCardRestourantState createState() => _VerticalCardRestourantState();
}

class _VerticalCardRestourantState extends State<VerticalCardRestourant> {
  double imageHeight = 150;
  double defaultHeightCuisines = 25;
  double? heightCuisines;
  double _height = 0;
  double? _heightCard = 200.0;

  @override
  void initState() { 
    super.initState();
    initHeightCuisines();
  }

  initHeightCuisines() {
    if (widget.restourant.cuisines.length > 1) {
      for (int i = 0; i <= widget.restourant.cuisines.length; i++ ) {
        setState(() {
          _heightCard = _heightCard! + defaultHeightCuisines;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return GestureDetector(
      onTap: () {
        if (_height == _heightCard) {
          setState(() {
            _height = 0;
          });
        } else {
          setState(() {
            _height = _heightCard!;
          });
        }
      },
      child: Container(
        child: Neumorphic(
          style: NeumorphicStyle(
            color: ConfigColor.bgColor,
            boxShape: NeumorphicBoxShape.roundRect(BorderRadius.circular(15)),
            shadowLightColor: ConfigColor.shadowLightColor,
            shadowDarkColor: ConfigColor.shadowDarkColor.withOpacity(0.6),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: EdgeInsets.all(3),
                height: imageHeight,
                child: ClipRRect(
                  borderRadius: BorderRadius.only(topLeft: Radius.circular(12), topRight: Radius.circular(12)),
                  child: Image.network(widget.restourant.preview, fit: BoxFit.fitWidth, width: width)
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 12, top: 10, bottom: 10, right: 12),
                child: Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(widget.restourant.title, style: Theme.of(context).textTheme.headline1, overflow: TextOverflow.ellipsis,),
                      Text('${widget.restourant.openTime} - ${widget.restourant.closeTime}', style: Theme.of(context).textTheme.bodyText1,),
                    ],
                  )
                ),
              ),
              AnimatedContainer(
                padding: EdgeInsets.only(left: 12, right: 12),
                margin: EdgeInsets.only(bottom: 10),
                height: _height,
                curve: Curves.fastOutSlowIn,
                duration: Duration(milliseconds: 800),
                child: SingleChildScrollView(
                  child: Container(
                    height: _heightCard,
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        ListView.builder(
                          physics: NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: widget.restourant.cuisines.length,
                          itemBuilder: (ctx, i) {
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  widget.restourant.cuisines[i].title,
                                  style: Theme.of(context).textTheme.headline2,
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  widget.restourant.cuisines[i].subtitle,
                                  style: Theme.of(context).textTheme.bodyText1,
                                ),
                                SizedBox(
                                  height: 15,
                                ),
                              ],
                            );
                          }
                        ),
                        SizedBox(height: 15,),
                        Text('Среднее время доставки: ${widget.restourant.deliveryTime}', style: Theme.of(context).textTheme.bodyText1,),
                        SizedBox(height: 15,),
                        buttonElevated(
                          'Посмотреть меню',
                          context,
                          () {
                            Navigator.push(context, MaterialPageRoute(builder: (context) {
                              return ProductsScreen(id: widget.restourant.id);
                            }));
                          }
                        )
                    ],),
                  ),
                ),
              ),
          ],)
        )
      ),
    );
  }
}