import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:hotel_manager/components/buttons/button_elevated.dart';
import 'package:hotel_manager/components/buttons/leading_button_back.dart';
import 'package:hotel_manager/helper/config_color.dart';
import 'package:hotel_manager/model/restourant.dart';
import 'package:hotel_manager/screen/restorant/products.dart';

class VerticalCardRestourant extends StatefulWidget {
  VerticalCardRestourant({Key? key, required this.restourant}) : super(key: key);
  final Restourant restourant;

  @override
  _VerticalCardRestourantState createState() => _VerticalCardRestourantState();
}

class _VerticalCardRestourantState extends State<VerticalCardRestourant> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Container(
      height: 200,
      padding: EdgeInsets.all(15),
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
            Flexible(
              flex: 3,
              child: PhotoHero(
                photo: widget.restourant.preview,
                width: width,
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return DetailRestourant(restourant: widget.restourant,);
                  }));
                },
              ),
            ),
            Flexible(
              child: Center(
                child: Text(
                  widget.restourant.title, 
                  style: Theme.of(context).textTheme.headline1?.copyWith(fontSize: 14),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            )
        ],),
      ),
    );
  }
}

class PhotoHero extends StatelessWidget {
  const PhotoHero({ Key? key, required this.photo, this.onTap, required this.width }) : super(key: key);

  final String photo;
  final VoidCallback? onTap;
  final double width;

  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      child: Hero(
        tag: photo,
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: onTap,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.network(
                photo,
                width: width,
                fit: BoxFit.fitWidth,
                errorBuilder: (BuildContext context, Object exception, StackTrace? stackTrace) {
                  return Center(
                    child: Image.asset(
                      'assets/img/image_not_found.jpg',
                      width: width,
                      fit: BoxFit.fitWidth,
                    )
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}



class DetailRestourant extends StatelessWidget {
  final Restourant restourant;
  const DetailRestourant({Key? key, required this.restourant}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(restourant.title, style: Theme.of(context).textTheme.headline1,),
        shadowColor: Colors.transparent,
        backgroundColor: ConfigColor.bgColor,
        leading: iconButtonBack(context),
      ),
      bottomNavigationBar: 
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: buttonElevated(
            'Посмотреть меню',
            context,
            () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return ProductsScreen(id: restourant.id);
              }));
            }
          ),
        ),
      body: Container(
        padding: EdgeInsets.only(left: 12, right: 12),
        margin: EdgeInsets.only(bottom: 10),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              PhotoHero(
                photo: restourant.preview,
                width: MediaQuery.of(context).size.width,
                onTap: () {
                  Navigator.pop(context);
                },
              ),
              SizedBox(height: 15,),
              Text(
                'Время работы ${restourant.openTime} - ${restourant.closeTime}', 
                style: Theme.of(context).textTheme.headline2?.copyWith(fontWeight: FontWeight.w600)
              ),
              SizedBox(height: 5,),
              ListView.builder(
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: restourant.cuisines.length,
                itemBuilder: (ctx, i) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        restourant.cuisines[i].title,
                        style: Theme.of(context).textTheme.headline2,
                      ),
                    ],
                  );
                }
              ),
              SizedBox(
                height: 5,
              ),
              Container(
                child: Text(
                  restourant.description ?? ''
                ),
              ),
              SizedBox(
                height: 5,
              ),
              SizedBox(height: 15,),
              Text('Среднее время доставки: ${restourant.deliveryTime}'),
              SizedBox(height: 15,),
          ],),
        ),
      ),
    );
  }
}