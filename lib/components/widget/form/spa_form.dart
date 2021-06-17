import 'package:flutter/material.dart';

class SpaForm extends StatefulWidget {
  SpaForm({Key? key}) : super(key: key);

  @override
  _SpaFormState createState() => _SpaFormState();
}

class _SpaFormState extends State<SpaForm> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(

      ),
      body: Form(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
          Row(
            children: [
              Expanded(
                child: TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Дата'
                  ),
                ),
              ),
              Expanded(
                child: TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Время'
                  ),
                ),
              ),
            ],
          ),
          TextFormField(
            decoration: InputDecoration(
              labelText: 'Фамилия'
            ),
          ),
          TextFormField(
            decoration: InputDecoration(
              labelText: 'Имя'
            ),
          ),
          TextFormField(
            decoration: InputDecoration(
              labelText: 'Телефон'
            ),
          ),
          TextFormField(
            decoration: InputDecoration(
              labelText: 'Комментарий'
            ),
          ),
        ],),
      ),
    );
  }
}