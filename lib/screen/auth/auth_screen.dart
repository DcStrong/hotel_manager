import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:hotel_manager/components/buttons/button_elevated.dart';
import 'package:hotel_manager/components/buttons/button_text.dart';
import 'package:hotel_manager/helper/config_color.dart';
import 'package:hotel_manager/helper/message_exception.dart';
import 'package:hotel_manager/model/user.dart';
import 'package:hotel_manager/provider/user.dart';
import 'package:hotel_manager/repository/api_router.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthScreen extends StatefulWidget {
  final bool pathRoute;
  AuthScreen({Key? key, this.pathRoute = false}) : super(key: key);

  @override
  _AuthScreenState createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  final _formKey = GlobalKey<FormState>();
  TextEditingController _authController = TextEditingController();
  TextEditingController _authPasswordController = TextEditingController();

  @override
  void initState() { 
    super.initState();
  }

  Widget authForm() {
    return  Form(
      key: _formKey,
      child: Column(children: [
        TextFormField(
          keyboardType: TextInputType.phone,
          style: TextStyle(fontSize: 14),
          validator: (value) {
            if (value?.isEmpty ?? false) return 'Поле не может быть пустым';
            return null;
          },
          controller: _authController,
          decoration: InputDecoration(
            enabledBorder: UnderlineInputBorder(
              borderSide:  BorderSide(
                color: Colors.grey, width: 1.0),
            ),
            focusedBorder: UnderlineInputBorder(
              borderSide:  BorderSide(
                color: Colors.grey, width: 1.0),
            ),
            labelStyle: TextStyle(color: Colors.grey, fontSize: 12),
            labelText: 'Телефон',
          ),
        ),
        TextFormField(
          style: TextStyle(fontSize: 14),
          validator: (value) {
            if (value?.isEmpty ?? false) return 'Поле не может быть пустым';
            return null;
          },
          controller: _authPasswordController,
          obscureText: true,
          decoration: InputDecoration(
            enabledBorder: UnderlineInputBorder(
              borderSide:  BorderSide(
                color: Colors.grey, width: 1.0),
            ),
            focusedBorder: UnderlineInputBorder(
              borderSide:  BorderSide(
                color: Colors.grey, width: 1.0),
            ),
            labelStyle: TextStyle(color: Colors.grey, fontSize: 12),
            labelText: 'Пароль',
          ),
        ),
        // buttonText('Восстановить пароль', context, color: ConfigColor.additionalColor),
        buttonText('Восстановить пароль', context, func: () {Navigator.pushNamed(context, 'reset_password');}),
        buttonText('Зарегистрироваться', context, func: () {Navigator.pushNamed(context, 'register');}),
      ],)
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: widget.pathRoute == false ? AppBar(
        leadingWidth: 0,
        leading: Container(),
        title: Text('Авторизация', style: Theme.of(context).textTheme.headline1,),
        shadowColor: Colors.transparent,
      ) : AppBar(
        title: Text('Авторизация', style: Theme.of(context).textTheme.headline1,),
      ),
      body:
      Container(
        padding: EdgeInsets.all(20),
        child: ListView(
          children: [
            authForm(),
            buttonElevatedCenter('Войти', context, () async {
              if(_formKey.currentState!.validate()) {
                try {
                  var result = await ApiRouter.auth(_authController.text, _authPasswordController.text);

                  context.read<User>().setUser(result);
                  if(widget.pathRoute) {
                    Navigator.pop(context);
                    return;
                  }
                  await Navigator.pushNamedAndRemoveUntil(context, 'profile', (route) => false);

                } on MessageException catch(e) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(e.message),
                    ),
                  );
                }
              }
            })
          ],
        ),
      ),
    );
  }
}