import 'package:flutter/material.dart';
import 'package:hotel_manager/components/buttons/leading_button_back.dart';
import 'package:hotel_manager/components/widget/card/vartical_card_my_order.dart';
import 'package:hotel_manager/helper/config_color.dart';
import 'package:hotel_manager/model/user_food.dart';
import 'package:hotel_manager/provider/user.dart';
import 'package:hotel_manager/repository/api_router.dart';
import 'package:provider/provider.dart';

class ProfileMyOrders extends StatefulWidget {
  ProfileMyOrders({Key? key}) : super(key: key);

  @override
  _ProfileMyOrdersState createState() => _ProfileMyOrdersState();
}

class _ProfileMyOrdersState extends State<ProfileMyOrders> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Службы отеля', style: Theme.of(context).textTheme.headline1,),
        shadowColor: Colors.transparent,
        backgroundColor: ConfigColor.bgColor,
        leading: iconButtonBack(context),
      ),
      body: Consumer<User>(
        builder: (context, _user, _) {
          return Padding(
            padding: const EdgeInsets.all(15.0),
            child: FutureBuilder(
              future: ApiRouter.getUserOrdersList(_user.userProfile.token!),
              builder: (ctx, AsyncSnapshot<List<UserFood>> snapshot) {
                if(snapshot.hasData) {
                  if(snapshot.data?.length == 0)
                    return Center(
                      child: Text('Список заказов пуст'),
                    );
                  return ListView.separated(
                    separatorBuilder: (ctx, i) {
                      return Divider(color: Colors.grey.withOpacity(0), thickness: 1,);
                    },
                    shrinkWrap: true,
                    itemCount: snapshot.data!.length,
                    itemBuilder: (ctx, i) {
                      return VerticalCardMyOrder(item: snapshot.data![i]);
                    }
                  );
                }
                return Center(
                  child: CircularProgressIndicator(color: ConfigColor.assentColor,),
                );
              },
            ),
          );
        }
      )
    );
  }
}