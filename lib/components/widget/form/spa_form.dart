import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import 'package:hotel_manager/components/buttons/button_elevated.dart';
import 'package:hotel_manager/components/buttons/leading_button_back.dart';
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

  final DateLocale location = EnglishDateLocale();
  final _formKey = GlobalKey<FormState>();
  String? dateTime;

  TextEditingController _dateController = TextEditingController();
  TextEditingController _timeController = TextEditingController();
  TextEditingController _lastNameController = TextEditingController();
  TextEditingController _firstNameController = TextEditingController();
  TextEditingController _phoneController = TextEditingController();
  TextEditingController _commentsController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: iconButtonBack(context),
      ),
      body: Consumer<User>(
        builder: (BuildContext context, user, _) {
          UserModel _user = user.userProfile;
          if (_user.phone != null) {
            _phoneController.text = _user.phone ?? '';
          }
          if (_user.lastName != null) {
            _lastNameController.text = _user.lastName ?? '';
          }
          if (_user.name != null) {
            _firstNameController.text = _user.name ?? '';
          }
          return SingleChildScrollView(
            child: Container(
              padding: EdgeInsets.only(top: 20, left: 15, right: 15),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                  Text('?????????????? ?????????????? ?????? ?????? ?????????? ?? ????????. ?? ???????? ???????????????? ???????????????? ?????? ??????????????????????????.'),
                  Row(
                    children: [
                      Expanded(
                        child: TextFormField(
                          validator: (value) {
                            if (value?.isEmpty ?? false) return '???? ?????????? ???????? ????????????';
                            return null;
                          },
                          controller: _dateController,
                          onTap: () async {
                            String date = await helper.selectDate(context);
                            _dateController.text = date;
                            FocusScope.of(context).requestFocus(new FocusNode());
                          },
                          decoration: InputDecoration(
                            labelStyle: TextStyle(color: ConfigColor.additionalColor),
                            labelText: '????????'
                          ),
                        ),
                      ),
                      SizedBox(width: 25,),
                      Expanded(
                        child: TextFormField(
                          validator: (value) {
                            if (value?.isEmpty ?? false) return '???? ?????????? ???????? ????????????';
                            String hour = value?.split(':')[0] as String;
                            if(int.parse(hour) >= 21) {
                              helper.showMessageSnackBar(
                                context, '???????????????? ???????????????? ?? ?????? ?????????? ???? ????????????????, ???????????????????? ???????????? ?????????? ?????? ????????'
                              );
                              return '???????????????? ?????????? ?????? ????????';
                            }
                            return null;
                          },
                          controller: _timeController,
                          onTap: () async {
                            String time = await helper.selectTime(context);
                            setState(() {
                              _timeController.text = time;
                            });
                            FocusScope.of(context).requestFocus(new FocusNode());
                          },
                          decoration: InputDecoration(
                            labelStyle: TextStyle(color: ConfigColor.additionalColor),
                            labelText: '??????????'
                          ),
                        ),
                      ),
                    ],
                  ),
                  TextFormField(
                    validator: (value) {
                      if (value?.isEmpty ?? false) return '???????? ???? ?????????? ???????? ????????????';
                      return null;
                    },
                    controller: _lastNameController,
                    decoration: InputDecoration(
                      labelStyle: TextStyle(color: ConfigColor.additionalColor),
                      labelText: '??????????????'
                    ),
                  ),
                  TextFormField(
                    validator: (value) {
                      if (value?.isEmpty ?? false) return '???????? ???? ?????????? ???????? ????????????';
                      return null;
                    },
                    controller: _firstNameController,
                    decoration: InputDecoration(
                      labelStyle: TextStyle(color: ConfigColor.additionalColor),
                      labelText: '??????'
                    ),
                  ),
                  TextFormField(
                    validator: (value) {
                      if (value?.isEmpty ?? false) return '???????? ???? ?????????? ???????? ????????????';
                      return null;
                    },
                    keyboardType: TextInputType.phone,
                    inputFormatters: [maskFormatter],
                    controller: _phoneController,
                    decoration: InputDecoration(
                      labelStyle: TextStyle(color: ConfigColor.additionalColor),
                      labelText: '??????????????'
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
                      labelText: '??????????????????????',
                      labelStyle: TextStyle(color: ConfigColor.additionalColor),
                      alignLabelWithHint: true
                    ),
                  ),
                  SizedBox(height: 15,),
                  buttonElevatedCenter('????????????????????', context, () async {
                    if(_formKey.currentState!.validate()) {
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
                        ownerId: _user.id ?? null
                      );
                      helper.showProgress(context, ApiRouter.createRequestForSpa(form));
                    }
                  }),
                  SizedBox(height: 15,),
                ],),
              ),
            ),
          );
      }),
    );
  }
}