import 'package:flutter/material.dart';
import 'package:hotel_manager/components/buttons/button_elevated.dart';
import 'package:hotel_manager/helper/message_exception.dart';
import 'package:hotel_manager/provider/user.dart';
import 'package:hotel_manager/repository/api_router.dart';
import 'package:provider/provider.dart';

class RegisterScreen extends StatefulWidget {
  RegisterScreen({Key ?key}) : super(key: key);

  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController _lastNameController = TextEditingController();
  TextEditingController _nameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _phoneController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _passwordConfirmController = TextEditingController();


  Widget registerForm() {
    return  Form(
      key: _formKey,
      child: Column(children: [
        TextFormField(
          style: TextStyle(fontSize: 14),
          validator: (value) {
            if (value?.isEmpty ?? false) return 'Пожалуйста, введите фамилию';
            return null;
          },
          controller: _lastNameController,
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
            labelText: 'Фамилия',
          ),
        ),
        TextFormField(
          style: TextStyle(fontSize: 14),
          validator: (value) {
            if (value!.isEmpty) return 'Пожалуйста, введите имя';
            return null;
          },
          controller: _nameController,
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
            labelText: 'Имя',
          ),
        ),
        TextFormField(
          style: TextStyle(fontSize: 14),
          validator: (value) {
            if (value!.isEmpty) return 'Пожалуйста введите E-Mail';
            String p = "[a-zA-Z0-9+.\_\%-+]{1,256}@[a-zA-Z0-9][a-zA-Z0-9-]{0,64}(.[a-zA-Z0-9][a-zA-Z0-9-]{0,25})+";
            RegExp regExp = new RegExp(p);
            if (regExp.hasMatch(value)) return null;
            return 'Это не Email';
          },
          controller: _emailController,
          decoration: InputDecoration(
            enabledBorder: UnderlineInputBorder(
              borderSide:  BorderSide(
                color:  Colors.grey, width: 1.0),
            ),
            focusedBorder: UnderlineInputBorder(
              borderSide:  BorderSide(
                color: Colors.grey, width: 1.0),
            ),
            labelStyle: TextStyle(color: Colors.grey, fontSize: 12),
            labelText: 'E-Mail',
          ),
        ),
        TextFormField(
          style: TextStyle(fontSize: 14),
          validator: (value) {
            if (value?.isEmpty ?? false) return 'Пожалуйста, введите телефон';
            return null;
          },
          controller: _phoneController,
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
            if (value?.isEmpty ?? false) return 'Пожалуйста, введите пароль';
            if (value!.length < 5) return 'Пароль должен быть больше 5 символов';
            return null;
          },
          controller: _passwordController,
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
        TextFormField(
          style: TextStyle(fontSize: 14),
          validator: (value) {
            if(_passwordController.text != _passwordConfirmController.text) return 'Пароли не совпадают';
            if (value?.isEmpty ?? false) return 'Пожалуйста, повторите пароль';
            return null;
          },
          controller: _passwordConfirmController,
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
            labelText: 'Повторите пароль',
          ),
        ),
      ],)
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Регистрация', style: Theme.of(context).textTheme.headline1,),
        shadowColor: Colors.transparent,
      ),
      body: Container(
        padding: EdgeInsets.all(20),
        child: ListView(
          shrinkWrap: true,
          children: [
            registerForm(),
            SizedBox(height: 20,),
            buttonElevatedCenter('Зарегистрироваться', context, () async {
              if(_formKey.currentState!.validate()) {
                try {
                  var result = await ApiRouter.register(
                  _lastNameController.text,
                  _nameController.text,
                  _emailController.text,
                  _phoneController.text,
                  _passwordController.text,
                  _passwordConfirmController.text);

                  context.read<User>().setUser(result);

                  Navigator.pushNamedAndRemoveUntil(context, 'profile', (route) => false);

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