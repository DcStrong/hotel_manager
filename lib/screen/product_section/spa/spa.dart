import 'package:flutter/material.dart';
import 'package:hotel_manager/components/shimmer/horizontal_shimmer.dart';
import 'package:hotel_manager/components/widget/card/horizontal_card.dart';
import 'package:hotel_manager/repository/api_router.dart';
import 'package:hotel_manager/screen/detail_card.dart';
import 'package:hotel_manager/screen/product_section/spa/spa_categories.dart';

class SpaSection extends StatefulWidget {
  SpaSection({Key ?key}) : super(key: key);

  @override
  _SpaSectionState createState() => _SpaSectionState();
}

class _SpaSectionState extends State<SpaSection> {
  Widget buildContent() {
    return FutureBuilder(
      initialData: [],
      future: ApiRouter.getSectionSpaForHome(context),
      builder: (ctx, AsyncSnapshot<List> snapshot) {
        if(snapshot.hasData) {
          if(snapshot.data!.length == 0) {
            return Container();
          }
          return Column(
            children: [
              SizedBox(height: 15,),
              GestureDetector(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return SpaCategories();
                  }));
                },
                child: Container(
                  margin: EdgeInsets.only(right: 15, left: 15, bottom: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('SPA-Центр', style: Theme.of(context).textTheme.headline1,),
                      Image.asset('assets/icons/arrow.png', width: 8,)
                    ],
                  ),
                ),
              ),
              Container(
                height: 235,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: snapshot.data?.length,
                  itemBuilder: (ctx, i) {
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) {
                          return DetailCard(id: snapshot.data![i].id, path: 'spa-procedures',);
                        }));
                      },
                      child: HorizontalCard(card: snapshot.data![i])
                    );
                  }
                ),
              ),
            ],
          );
        }
        return HorizontalShimmer();
      }
    );
  }

  @override
  Widget build(BuildContext context) {
    return buildContent();
  }
}