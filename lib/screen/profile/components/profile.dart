import 'package:flutter/material.dart';
import 'package:hotel_manager/components/buttons/outline_button.dart';
import 'package:hotel_manager/helper/config_color.dart';
import 'package:hotel_manager/model/user.dart';
import 'package:hotel_manager/provider/user.dart';
import 'package:hotel_manager/repository/api_router.dart';
import 'package:hotel_manager/screen/profile/components/profile_pic.dart';
import 'dart:core';
import 'package:provider/provider.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class Profile extends StatefulWidget {
  final String? pathRoute;
  Profile({Key? key, this.pathRoute}) : super(key: key);

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  final TextEditingController textController = TextEditingController();
  final MaskTextInputFormatter formatter = MaskTextInputFormatter(mask: "+# (###) ###-##-##");
  UserModel? _user;
  bool _isLoad = true;
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      initUser();
    });
  }

  initUser() async {
    UserModel user = Provider.of<User>(context, listen: false).userProfile;
    if(user.token == null && mounted) {
      await Navigator.pushNamedAndRemoveUntil(context, 'auth', (route) => false);
    }else{
      setState(() {
        _isLoad = false;
        _user = user;
      });
    }

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


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Профиль', style: Theme.of(context).textTheme.headline1,),
        shadowColor: Colors.transparent,
        backgroundColor: ConfigColor.bgColor,
        leading: null,
      ),
      body: 
      _isLoad
      ?
      Center(
        child: CircularProgressIndicator(backgroundColor: ConfigColor.assentColor,),
      )
      :
      SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          child: Column(
            children: [
              // ProfilePic(),
              SizedBox(height: 40,),
              outlineButton(Icons.history_sharp, 'История заказов', () {
                Navigator.pushNamed(context, 'profile_my_orders');
              }),
              outlineButton(Icons.help_center, 'Помощь', () {
                Navigator.pushNamed(context, 'profile_help');
              }),
              outlineButton(Icons.exit_to_app, 'Выход', () {
                context.read<User>().removeUser();
                initUser();
                if( _user?.token == null ) Navigator.pushNamed(context, 'auth');
              }),
              Expanded(child: Container(),),
            ],
          )
        ),
      )
    );
  }
}