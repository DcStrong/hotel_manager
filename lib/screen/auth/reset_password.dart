import 'package:flutter/material.dart';
import 'package:hotel_manager/components/buttons/button_text.dart';
import 'package:hotel_manager/repository/api_router.dart';
import 'package:timer_count_down/timer_controller.dart';
import 'package:timer_count_down/timer_count_down.dart';

class ResetPasswordPage extends StatefulWidget {
  ResetPasswordPage({Key? key}) : super(key: key);

  @override
  _ResetPasswordPageState createState() => _ResetPasswordPageState();
}

class _ResetPasswordPageState extends State<ResetPasswordPage> {
  final _resetPasswordKey = GlobalKey<FormState>();
  final _phoneKey = GlobalKey<FormState>();
  final _phoneAndCodeKey = GlobalKey<FormState>();
  TextEditingController _phoneController = TextEditingController();
  TextEditingController _codeController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _passwordConfirmController = TextEditingController();

  final CountdownController _timerController =
      new CountdownController(autoStart: true);

  late bool _sendSmsCode;
  late bool _timeOut;

  @override
  void initState() {
    super.initState();
    setState(() {
      _sendSmsCode = false;
      _timeOut = false;
    });
  }

  Widget phoneForm() {
    return  Form(
      key: _phoneKey,
      child: Column(children: [
        TextFormField(
          keyboardType: TextInputType.phone,
          style: TextStyle(fontSize: 14),
          validator: (value) {
            if (value?.isEmpty ?? false) return 'Поле не может быть пустым';
            if (value!.length < 9) return 'Пожалуйста введите номер телефона';
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
        // buttonText('Восстановить пароль', context, color: ConfigColor.additionalColor),
        buttonText('Отправить код', context, func: () async {
          if (_phoneKey.currentState!.validate()) {
            try {
              await ApiRouter.sendSmsForResetPassword(_phoneController.text);
              setState(() {
                _sendSmsCode = true;
              });
            } catch (e) {
              ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Пользователь не существует')));
            }
          }
        }),
      ],)
    );
  }

Widget phoneAndCodeForm() {
    return  Form(
      key: _phoneAndCodeKey,
      child: Column(children: [
        TextFormField(
          keyboardType: TextInputType.phone,
          style: TextStyle(fontSize: 14),
          validator: (value) {
            if (value?.isEmpty ?? false) return 'Поле не может быть пустым';
            if (value!.length < 9) return 'Пожалуйста введите номер телефона';
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
          keyboardType: TextInputType.phone,
          style: TextStyle(fontSize: 14),
          controller: _codeController,
          validator: (value) {
            if (value?.isEmpty ?? false) return 'Пожалуйста, введите код';
            if (value!.length < 4) return 'Код должен содержать 4 цифры';
            return null;
          },
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
            labelText: 'Код из СМС',
          ),
        ),
      ],)
    );
  }

  Widget resetPasswordForm() {
    return  Form(
      key: _resetPasswordKey,
      child: Column(children: [
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
            labelText: 'Новый пароль',
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
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            buttonText(
              'Выслать код повторно',
              context,
              color: _timeOut ? null : Colors.grey,
              func: () async {
              if (_phoneAndCodeKey.currentState!.validate() && _timeOut) {
                try {
                  await ApiRouter.sendSmsForResetPassword(_phoneController.text);
                  _timerController.restart();
                } catch (e) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Телефон не существует')));
                }
              }
            }),
            if (!_timeOut)
            Countdown(
              controller: _timerController,
              seconds: 30,
              build: (_, double time) => Text(
                time.toString(),
                style: TextStyle(fontFamily: 'MontseratMedium', fontSize: 14, fontWeight: FontWeight.w600),
              ),
              interval: Duration(milliseconds: 100),
              onFinished: () {
                setState(() {
                  _timeOut = true;
                });
              },
            )
          ],
        ),
        buttonText('Задать новый пароль', context, func: () async {
          if (_phoneAndCodeKey.currentState!.validate() && _resetPasswordKey.currentState!.validate()) {
            try {
              await ApiRouter.resetPassword(_phoneController.text, _codeController.text, _passwordController.text);
              Navigator.of(context).pop();
            } catch (e) {
              ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Не удалось задать новый пароль')));
            }
          }
        }),
      ],)
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Восстановление пароля', style: Theme.of(context).textTheme.headline1,),
        shadowColor: Colors.transparent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: 
        _sendSmsCode 
        ? Column(
          children: [
            phoneAndCodeForm(),
            resetPasswordForm(),
          ],
        )
        : phoneForm(),
      ),
    );
  }
}