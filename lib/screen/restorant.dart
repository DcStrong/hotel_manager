import 'package:flutter/material.dart';

class ResorantScreen extends StatelessWidget {
  const ResorantScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(child: Container(),),
          Container(
            width: 126,
            child: Image.asset('assets/icons/manager.png', fit: BoxFit.cover),
          ),
          SizedBox(height: 30,),
          Container(
            child: Text('Страница ресторана находится в разработке', style: Theme.of(context).textTheme.headline2, textAlign: TextAlign.center,),
          ),
          Expanded(child: Container(),),
        ],
      ),
    );
  }
}