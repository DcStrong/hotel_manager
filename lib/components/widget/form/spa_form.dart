import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import 'package:hotel_manager/components/buttons/button_elevated.dart';
import 'package:hotel_manager/helper/config_color.dart';
import 'package:hotel_manager/helper/helper.dart';
import 'package:hotel_manager/model/spa_form.dart';
import 'package:hotel_manager/model/user.dart';
import 'package:hotel_manager/provider/user.dart';
import 'package:hotel_manager/repository/api_router.dart';
import 'package:intl/intl.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:provider/provider.dart';


class SpaForm extends StatefulWidget {
  final int? categoryId;
  final int? procedureId;
  SpaForm({Key? key, this.procedureId, this.categoryId}) : super(key: key);

  @override
  _SpaFormState createState() => _SpaFormState();
}

class _SpaFormState extends State<SpaForm> {
  var maskFormatter = new MaskTextInputFormatter(mask: '+# (###) ###-##-##', filter: { "#": RegExp(r'[0-9]') });
  UserModel? _user;

  final DateLocale location = EnglishDateLocale();

  String? dateTime;

  DateTime selectedDate = DateTime.now();

  TextEditingController _dateController = TextEditingController();
  TextEditingController _timeController = TextEditingController();
  TextEditingController _lastNameController = TextEditingController();
  TextEditingController _firstNameController = TextEditingController();
  TextEditingController _phoneController = TextEditingController();
  TextEditingController _commentsController = TextEditingController();


  Future<Null> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        helpText: 'Выберите дату',
        locale: Locale('ru', 'RU'),
        context: context,
        initialDate: selectedDate,
        initialDatePickerMode: DatePickerMode.day,
        firstDate: DateTime(2015),
        lastDate: DateTime(2101));
    if (picked != null)
      setState(() {
        selectedDate = picked;
        _dateController.text = DateFormat.yMd().format(selectedDate);
      });
  }

  Future<Null> _selectTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
      confirmText: 'Установить',
      cancelText: 'Закрыть',
      helpText: 'Выберите время',
      builder: (BuildContext context, Widget? child) {
        return MediaQuery(
          data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: true),
          child: child!,
        );
      },
    );

    if (picked != null) {
      setState(() {
        _timeController.text = '${picked.hour}:${picked.minute}';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    _user = context.watch<User>().userProfile;
    return Scaffold(
      appBar: AppBar(

      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.only(top: 20, left: 15, right: 15),
          child: Form(
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
              Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      controller: _dateController,
                      onTap: () async {
                        _selectDate(context);
                        FocusScope.of(context).requestFocus(new FocusNode());
                      },
                      decoration: InputDecoration(
                        labelStyle: TextStyle(color: ConfigColor.additionalColor),
                        labelText: 'Дата'
                      ),
                    ),
                  ),
                  SizedBox(width: 25,),
                  Expanded(
                    child: TextFormField(
                      controller: _timeController,
                      onTap: () async {
                        _selectTime(context);
                        FocusScope.of(context).requestFocus(new FocusNode());
                      },
                      decoration: InputDecoration(
                        labelStyle: TextStyle(color: ConfigColor.additionalColor),
                        labelText: 'Время'
                      ),
                    ),
                  ),
                ],
              ),
              TextFormField(
                controller: _lastNameController,
                decoration: InputDecoration(
                  labelStyle: TextStyle(color: ConfigColor.additionalColor),
                  labelText: 'Фамилия'
                ),
              ),
              TextFormField(
                controller: _firstNameController,
                decoration: InputDecoration(
                  labelStyle: TextStyle(color: ConfigColor.additionalColor),
                  labelText: 'Имя'
                ),
              ),
              TextFormField(
                keyboardType: TextInputType.phone,
                inputFormatters: [maskFormatter],
                controller: _phoneController,
                decoration: InputDecoration(
                  labelStyle: TextStyle(color: ConfigColor.additionalColor),
                  labelText: 'Телефон'
                ),
              ),
              SizedBox(height: 15,),
              TextFormField(
                keyboardType: TextInputType.multiline,
                maxLines: 5,
                controller: _commentsController,
                decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(width: 2, color: ConfigColor.additionalColor),
                  borderRadius: BorderRadius.circular(10),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(width: 2, color: ConfigColor.assentColor),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  labelText: 'Комментарий',
                  labelStyle: TextStyle(color: ConfigColor.additionalColor),
                  alignLabelWithHint: true
                ),
              ),
              SizedBox(height: 15,),
              buttonElevatedCenter('Записаться', context, () async {
                FocusScope.of(context).unfocus();
                String dateString = _dateController.text + ' ' + _timeController.text;
                DateTime tempDate = new DateFormat("MM/dd/yyyy HH:mm").parse(dateString);
                SpaFormModel form = new SpaFormModel(
                  phone: maskFormatter.getUnmaskedText(),
                  categoryId: widget.categoryId ?? 0,
                  date: tempDate,
                  firstName: _firstNameController.text,
                  lastName: _lastNameController.text,
                  procedureId: widget.procedureId ?? 0,
                  ownerId: _user?.id
                );
                helper.showProgress(context, ApiRouter.createRequestForSpa(form));
                // await ApiRouter.createRequestForSpa(form);
              }),
              SizedBox(height: 15,),
            ],),
          ),
        ),
      ),
    );
  }
}