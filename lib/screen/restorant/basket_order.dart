import 'package:flutter/material.dart';
import 'package:hotel_manager/components/buttons/button_text.dart';
import 'package:hotel_manager/components/buttons/leading_button_back.dart';
import 'package:hotel_manager/helper/config_color.dart';
import 'package:hotel_manager/helper/helper.dart';
import 'package:hotel_manager/model/basket_produts.dart';
import 'package:hotel_manager/model/user.dart';
import 'package:hotel_manager/provider/basket_product.dart';
import 'package:hotel_manager/provider/user.dart';
import 'package:hotel_manager/repository/api_router.dart';
import 'package:provider/provider.dart';

enum SingingCharacter { delivery, reservation }

class BasketOrder extends StatefulWidget {
  BasketOrder({Key? key}) : super(key: key);

  @override
  _BasketOrderState createState() => _BasketOrderState();
}

class _BasketOrderState extends State<BasketOrder> {

  String _initTimeValue = 'Ближайшему времени';

  final _formKey = GlobalKey<FormState>();
  TextEditingController _roomNumber = TextEditingController();
  TextEditingController _timeController = TextEditingController();
  TextEditingController _commentsController = TextEditingController();

  bool isDelivery = true;


  SingingCharacter? _character = SingingCharacter.delivery;

  String corps = 'Центральный корпус';

  var _currencies = [
    "Пансионат Гринцовский",
    "Азор",
    "Центральный корпус",
  ];

  @override
  void initState() {
    super.initState();
    _timeController.text = _initTimeValue;
  }
  Widget orderForm(String phone) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Корпус проживания', style: TextStyle(color: ConfigColor.additionalColor, fontSize: 14),),
          Container(
            width: double.infinity,
            child: DropdownButton<String>(
            isExpanded: true,
            value: corps,
            icon: const Icon(Icons.arrow_downward),
            iconSize: 24,
            elevation: 20,
            style: TextStyle(color: ConfigColor.assentColor, fontSize: 16),
            underline: Container(
              height: 1,
              color: ConfigColor.additionalColor,
            ),
            onChanged: (String? newValue) {
              setState(() {
                corps = newValue!;
              });
            },
            items: _currencies
                .map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: Text(value, style: Theme.of(context).textTheme.headline2,),
                ),
              );
            }).toList(),
        ),
        ),
        TextFormField(
          keyboardType: TextInputType.number,
          validator: (value) {
            if (value?.isEmpty ?? false) return 'Поле не может быть пустым';
            return null;
          },
          style: Theme.of(context).textTheme.headline2,
          controller: _roomNumber,
          decoration: InputDecoration(
            enabledBorder: UnderlineInputBorder(
              borderSide:  BorderSide(
                color: ConfigColor.additionalColor, width: 1.0),
            ),
            focusedBorder: UnderlineInputBorder(
              borderSide:  BorderSide(
                color: ConfigColor.assentColor, width: 1.0),
            ),
            labelStyle: TextStyle(color: ConfigColor.additionalColor, fontSize: 14),
            labelText: 'Номер проживания',
          ),
        ),
        Column(
          children: <Widget>[
            ListTile(
              dense:true,
              contentPadding: EdgeInsets.only(left: 0.0, right: 0.0),
              title: Text('Принести в номер', style: Theme.of(context).textTheme.headline2),
              leading: Radio<SingingCharacter>(
                focusColor: ConfigColor.assentColor,
                activeColor: ConfigColor.assentColor,
                value: SingingCharacter.delivery,
                groupValue: _character,
                onChanged: (SingingCharacter? value) {
                  setState(() {
                    _character = value;
                  });
                },
              ),
            ),
            ListTile(
              dense:true,
              contentPadding: EdgeInsets.only(left: 0.0, right: 0.0),
              title: Text('Забронировать столик', style: Theme.of(context).textTheme.headline2),
              leading: Radio<SingingCharacter>(
                focusColor: ConfigColor.assentColor,
                activeColor: ConfigColor.assentColor,
                value: SingingCharacter.reservation,
                groupValue: _character,
                onChanged: (SingingCharacter? value) {
                  setState(() {
                    _character = value;
                  });
                },
              ),
            ),
          ],
        ),
        TextFormField(
          style: Theme.of(context).textTheme.headline2,
          validator: (value) {
            if(value == _initTimeValue) return null;
            if (value?.isEmpty ?? false) return 'Поле не может быть пустым';
            String hour = value?.split(':')[0] as String;
            if(int.parse(hour) >= 21) {
              helper.showMessageSnackBar(
                context, 'Извините ресторан в это время не работает, установите другое время или дату'
              );
              return 'Извините время или дату';
            }
            return null;
          },
          controller: _timeController,
          onTap: () async {
            String time = await helper.selectTime(context);
            if (time == '') {
              time = 'К ближайшему времени';
            }
            setState(() {
              _timeController.text = time;
            });
            FocusScope.of(context).requestFocus(new FocusNode());
          },
          decoration: InputDecoration(
            labelStyle: TextStyle(color: ConfigColor.additionalColor, fontSize: 14),
            labelText: 'Доставить к'
          ),
        ),
        SizedBox(height: 20,),
        Text('$phone - Ваш текущий номер телефона', style: Theme.of(context).textTheme.headline2,),
        SizedBox(height: 20,),
        Text(
          'В комментариях вы можете указать другой номер телефона для связи или уточнить детали заказа',
          style: TextStyle(color: ConfigColor.additionalColor, fontSize: 14)
        ),
        SizedBox(height: 20,),
        TextFormField(
          keyboardType: TextInputType.multiline,
          maxLines: 5,
          controller: _commentsController,
          decoration: InputDecoration(
            enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(width: 1, color: ConfigColor.additionalColor),
            borderRadius: BorderRadius.circular(10),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(width: 1, color: ConfigColor.assentColor),
              borderRadius: BorderRadius.circular(10),
            ),
            labelText: 'Комментарий к заказу',
            labelStyle: TextStyle(color: ConfigColor.additionalColor),
            alignLabelWithHint: true
          ),
        ),
      ],)
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Оформление заказа', style: Theme.of(context).textTheme.headline1,),
        shadowColor: Colors.transparent,
        backgroundColor: ConfigColor.bgColor,
        leading: iconButtonBack(context),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
            child: Consumer<Basket>(
              builder: (BuildContext context, _store, _) {
                UserModel user = Provider.of<User>(context, listen: false).userProfile;
                return Column(
                  children: [
                    orderForm(user.phone ?? ''),
                    Center(
                      child: buttonText('Заказать', context, func: () async {
                        if(_formKey.currentState!.validate()) {
                          List foodsByOrder = [];
                          _store.basketInFood.forEach((e) {
                            foodsByOrder.add({'food_id' : e.id, 'quantity': e.quantity});
                          });
                          FocusScope.of(context).unfocus();
                          var res = await helper.showProgress(
                            context, ApiRouter.sendOrder(
                                user.token!,
                                int.parse(_roomNumber.text),
                                foodsByOrder,
                                _store.totalPrice,
                                corps,
                                _character == SingingCharacter.delivery ? 1 : 2,
                                _commentsController.text,
                                _store.quantityPerson,
                                _timeController.text
                              )
                            );
                          if(res)
                            _store.clearBasketProduct();
                        }
                        // helper.showProgress(context,);
                      }),
                    )]);
              }
            ),
        )
      )
    );
  }
}