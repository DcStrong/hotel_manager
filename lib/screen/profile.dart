import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:hotel_manager/components/buttons/button_text.dart';
import 'package:hotel_manager/helper/helper.dart';
import 'package:hotel_manager/model/feedback_service.dart';
import 'package:hotel_manager/model/user.dart';
import 'package:hotel_manager/provider/user.dart';
import 'package:hotel_manager/repository/api_router.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:core';
import 'package:url_launcher/url_launcher.dart';
import 'package:provider/provider.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class Profile extends StatefulWidget {
  Profile({Key ?key}) : super(key: key);

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  final TextEditingController textController = TextEditingController();
  final MaskTextInputFormatter formatter = MaskTextInputFormatter(mask: "+# (###) ###-##-##");

  @override
  void initState() {
    super.initState();
    getService();
  }

  getService() {
    ApiRouter.getServiceInfo();
  }
  Widget rowNameAndDescription(String name, String description) {
    return Padding(
      padding: EdgeInsets.only(bottom: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(name, style: Theme.of(context).textTheme.headline2,),
          Text(description, style: Theme.of(context).textTheme.headline2,)
      ],),
    );
  }

  Widget contactSection(String name, String phone) {

    String formattedPhoneNumber = phone.substring(0, 2) + " (" + phone.substring(2,5) + ") " +  phone.substring(5,8) + "-" + phone.substring(8,10) + '-' + phone.substring(10,phone.length);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(name, style: Theme.of(context).textTheme.headline2,),
        buttonText(formattedPhoneNumber, context, isPadding: false, func: () {
          helper.launchUrl("tel:$phone");
        }),
      ],
    );
  }


  @override
  Widget build(BuildContext context) {
    UserModel _user = context.watch<User>().userProfile;
    return Scaffold(
      appBar: AppBar(
        leading: Container(),
        shadowColor: Colors.transparent,
        actions: [
          IconButton(onPressed: () async {
            Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
            final SharedPreferences prefs = await _prefs;
            await prefs.remove('user');
            Navigator.pushNamed(context, 'auth');
          },
          icon: Icon(Icons.exit_to_app))
        ],
        // title: Text('Профиль', style: Theme.of(context).textTheme.headline1),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(left: 15.0, right: 15.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 140,
                    height: 140,
                    child: Image.asset('assets/icons/personal.png', fit: BoxFit.contain,),
                  ),
                  SizedBox(width: 40,),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(_user.name!, style: Theme.of(context).textTheme.headline2,),
                        SizedBox(height: 6,),
                        Text(_user.lastName!, style: Theme.of(context).textTheme.headline2,),
                        SizedBox(height: 6,),
                        Text(_user.phone!, style: Theme.of(context).textTheme.headline2,),
                        SizedBox(height: 6,),
                        Text(_user.email!, style: Theme.of(context).textTheme.headline2,),
                        SizedBox(height: 6,),
                        Text(_user.inHotel! ? 'В отеле' : 'Не в отеле', style: Theme.of(context).textTheme.headline2,),
                      ],
                    ),
                  )
              ],),
              SizedBox(height: 30,),
              FutureBuilder(
                future: ApiRouter.getServiceInfo(),
                builder: (ctx, AsyncSnapshot<List<FeedbackService>> snapshot) {
                  if(snapshot.hasData) {
                    return ListView.builder(
                      shrinkWrap: true,
                      itemCount: snapshot.data!.length,
                      itemBuilder: (ctx, i) {
                        return contactSection(snapshot.data![i].title!, snapshot.data![i].phone!);
                      }
                    );
                  }
                  return Container();
                },
              )
            ],
          ),
        ),
      )
    );
  }
}