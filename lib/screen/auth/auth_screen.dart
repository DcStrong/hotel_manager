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
  AuthScreen({Key ?key}) : super(key: key);

  @override
  _AuthScreenState createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  final _formKey = GlobalKey<FormState>();
  TextEditingController _authController = TextEditingController();
  TextEditingController _authPasswordController = TextEditingController();
  bool _isLoad = true;

  @override
  void initState() { 
    super.initState();
    initUser();
  }

  initUser() async {
    final SharedPreferences prefs = await _prefs;
    var userJson = jsonDecode(prefs.getString('user') ?? '');
    UserModel _user = UserModel.fromJSON(userJson);
    if(_user.token != null && _user.token != '') {
      await Navigator.pushNamedAndRemoveUntil(context, 'profile', (route) => false);
      setState(() {
        _isLoad = false;
      });
    } else {
      setState(() {
        _isLoad = false;
      });
    }
  }

  Widget authForm() {
    return  Form(
      key: _formKey,
      child: Column(children: [
        TextFormField(
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
            labelStyle: TextStyle(color: Colors.grey,),
            labelText: 'Телефон или e-mail',
          ),
        ),
        TextFormField(
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
            labelStyle: TextStyle(color: Colors.grey,),
            labelText: 'Пароль',
          ),
        ),
        buttonText('Восстановить пароль', context, color: ConfigColor.additionalColor),
        buttonText('Зарегестрироваться', context, func: () {Navigator.pushNamed(context, 'register');}),
      ],)
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Авторизация', style: Theme.of(context).textTheme.headline1,),
        shadowColor: Colors.transparent,
      ),
      body:
      _isLoad ?
      Center(child: CircularProgressIndicator(backgroundColor: ConfigColor.assentColor,),) :
      Container(
        padding: EdgeInsets.all(20),
        child: ListView(
          shrinkWrap: true,
          children: [
            authForm(),
            SizedBox(
              height: 150,
            ),
            buttonElevatedCenter('Войти', context, () async {
              if(_formKey.currentState!.validate()) {
                try {
                  var result = await ApiRouter.auth(_authController.text, _authPasswordController.text);

                  context.read<User>().setUser(result);

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