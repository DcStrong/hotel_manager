import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  SplashScreen({Key ?key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() { 
    super.initState();
    Future.delayed(Duration(seconds: 2), () {
      // deleayed code here 
      Navigator.pushNamedAndRemoveUntil(context, 'checkUserInHotel', (route) => false);
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          width: 168,
          child: Image.asset('assets/img/Logo_fish.png', fit: BoxFit.cover,)
        ),
      ),
    );
  }
}