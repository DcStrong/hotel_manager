import 'package:flutter/material.dart';
import 'package:hotel_manager/components/buttons/leading_button_back.dart';
import 'package:hotel_manager/components/shimmer/vertical_shimmer.dart';
import 'package:hotel_manager/components/widget/card/vertical_card.dart';
import 'package:hotel_manager/helper/config_color.dart';
import 'package:hotel_manager/repository/api_router.dart';
import 'package:hotel_manager/screen/detail_card.dart';

class ScreenProduct extends StatelessWidget {
  final String title;
  final String path;
  final int? categoryId;
  ScreenProduct({Key ?key, required this.title, required this.path, this.categoryId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(this.title, style: Theme.of(context).textTheme.headline1,),
        backgroundColor: ConfigColor.bgColor,
        shadowColor: Colors.transparent,
        leading: iconButtonBack(context),
      ),
      backgroundColor: ConfigColor.bgColor,
      body: Container(
        child: FutureBuilder(
            initialData: [],
            future: ApiRouter.getSectionCard(this.path, categoryId: categoryId),
            builder: (ctx, AsyncSnapshot<List> snapshot) {
              print(snapshot);
              if(snapshot.hasData) {
                return ListView.separated(
                  separatorBuilder: (ctx, i) {
                    return SizedBox(height: 10,);
                  },
                  itemCount: snapshot.data!.length,
                  itemBuilder: (ctx, i) {
                    return Padding(
                      padding: const EdgeInsets.only(left: 15.0, right: 15.0),
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context) {
                            return DetailCard(id: snapshot.data?[i].id, path: this.path,);
                          }));
                        },
                        child: VerticalCard(card: snapshot.data?[i])
                      ),
                    );
                  }
                );
              }
              return VerticalShimmer();
            }
          ),
      ),
    );
  }
  // @override
  // void debugFillProperties(DiagnosticPropertiesBuilder properties) {
  //   super.debugFillProperties(properties);
  //   properties.add(StringProperty('title', title));
  // }
}