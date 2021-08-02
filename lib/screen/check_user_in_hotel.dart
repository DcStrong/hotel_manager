import 'package:flutter/material.dart';
import 'package:hotel_manager/components/buttons/button_answer.dart';

class CheckUserInHotel extends StatefulWidget {
  const CheckUserInHotel({Key ?key}) : super(key: key);

  @override
  _CheckUserInHotelState createState() => _CheckUserInHotelState();
}

class _CheckUserInHotelState extends State<CheckUserInHotel> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Expanded(child: Container(),),
          Container(
            width: 126,
            child: Image.asset('assets/icons/manager.png', fit: BoxFit.cover),
          ), 
          SizedBox(height: 70,),
          Center(
            child: Container(
              padding: EdgeInsets.all(10),
              child: Text('Здравствуйте! \nУточните пожалуйста, Вы сейчас \nнаходитесь в отеле?', textAlign: TextAlign.center, style: Theme.of(context).textTheme.headline2)
            ),
          ),
          SizedBox(height: 100,),
          ButtonAnswer(),
          Expanded(child: Container(),),
        ],
      ),
    );
  }
}