import 'package:flutter/material.dart';
import 'package:hotel_manager/components/shimmer/vertical_shimmer.dart';
import 'package:hotel_manager/components/widget/card/vertical_card.dart';
import 'package:hotel_manager/helper/config_color.dart';
import 'package:hotel_manager/repository/api_router.dart';
import 'package:hotel_manager/screen/product_section/spa/spa_product_list.dart';

class SpaCategories extends StatelessWidget {
  SpaCategories({Key? key,}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('SPA-категории', style: Theme.of(context).textTheme.headline1,),
        backgroundColor: ConfigColor.bgColor,
        shadowColor: Colors.transparent,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back_ios, color: ConfigColor.assentColor),
        )
      ),
      backgroundColor: ConfigColor.bgColor,
      body: Container(
        child: FutureBuilder(
            initialData: [],
            future: ApiRouter.getCategoriesSpa(),
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
                            return SpaProductList(snapshot.data?[i].id,);
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
}