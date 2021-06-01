import 'package:flutter/material.dart';
import 'package:hotel_manager/components/shimmer/horizontal_shimmer.dart';
import 'package:hotel_manager/components/widget/card/horizontal_card.dart';
import 'package:hotel_manager/repository/api_router.dart';
import 'package:hotel_manager/screen/detail_card.dart';
import 'package:hotel_manager/screen/screen_product.dart';

class ActivitiesSection extends StatefulWidget {
  ActivitiesSection({Key? key}) : super(key: key);

  @override
  _ActivitiesSectionState createState() => _ActivitiesSectionState();
}

class _ActivitiesSectionState extends State<ActivitiesSection> {
  Widget buildContent() {
    return FutureBuilder(
      initialData: [],
      future: ApiRouter.getSectionActivitiesForHome(context),
      builder: (ctx, AsyncSnapshot<List> snapshot) {
        if(snapshot.hasData) {
          if(snapshot.data?.length == 0) {
            return Container();
          }
          return Column(
            children: [
              SizedBox(height: 15,),
              GestureDetector(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return ScreenProduct(title: 'Бассейны',path: 'activities');
                  }));
                },
                child: Container(
                  margin: EdgeInsets.only(right: 15, left: 15, bottom: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Мероприятия', style: Theme.of(context).textTheme.headline1,),
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
                          return DetailCard(id: snapshot.data![i].id, path: 'activities',);
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