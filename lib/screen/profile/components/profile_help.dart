import 'package:flutter/material.dart';
import 'package:hotel_manager/components/buttons/button_text.dart';
import 'package:hotel_manager/components/buttons/leading_button_back.dart';
import 'package:hotel_manager/helper/config_color.dart';
import 'package:hotel_manager/helper/helper.dart';
import 'package:hotel_manager/model/feedback_service.dart';
import 'package:hotel_manager/repository/api_router.dart';

class ProfileHelp extends StatefulWidget {
  const ProfileHelp({Key? key}) : super(key: key);

  @override
  _ProfileHelpState createState() => _ProfileHelpState();
}

class _ProfileHelpState extends State<ProfileHelp> {

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
    return Scaffold(
      appBar: AppBar(
        title: Text('Службы отеля', style: Theme.of(context).textTheme.headline1,),
        shadowColor: Colors.transparent,
        backgroundColor: ConfigColor.bgColor,
        leading: iconButtonBack(context),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: FutureBuilder(
          future: ApiRouter.getServiceInfo(),
          builder: (ctx, AsyncSnapshot<List<FeedbackService>> snapshot) {
            if(snapshot.hasData) {
              return ListView.separated(
                separatorBuilder: (ctx, i) {
                  return Divider(color: Colors.grey.withOpacity(0), thickness: 1,);
                },
                shrinkWrap: true,
                itemCount: snapshot.data!.length,
                itemBuilder: (ctx, i) {
                  return contactSection(snapshot.data![i].title!, snapshot.data![i].phone!);
                }
              );
            }
            return Center(
              child: CircularProgressIndicator(color: ConfigColor.assentColor,),
            );
          },
        ),
      )
    );
  }
}