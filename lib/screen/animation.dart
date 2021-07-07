import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:hotel_manager/helper/config_color.dart';
import 'package:hotel_manager/model/animation_week_day.dart';
import 'package:hotel_manager/repository/api_router.dart';
import 'package:hotel_manager/model/animation.dart';

class AnimationScreen extends StatefulWidget {
  AnimationScreen({Key? key}) : super(key: key);

  @override
  _AnimationScreenState createState() => _AnimationScreenState();
}

class _AnimationScreenState extends State<AnimationScreen> with SingleTickerProviderStateMixin {
  List<AnimationWeekDay> weekDayList = [];
  List<AnimationModel> animationList = [];
  int weekDayId = 1;
  int adults = 0;
  bool loadingList = true;
  TabController? _tabController;
  List statusDayOfWeek = [
    true,
    false,
    false,
    false,
    false,
    false,
    false,
  ];

  @override
  void initState() { 
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _tabController?.addListener(_handleTabSelection);
    // getAnimationType();
    getAnimation(dayOfWeekId: weekDayId, forAdults: adults);
  }

  @override
  void dispose() {
    _tabController!.dispose();
    super.dispose();
  }

  void _handleTabSelection() {
    switch (_tabController?.index) {
      case 0:
        setState(() {
          adults = 0;
        });
        getAnimation(forAdults: 0, dayOfWeekId: weekDayId);
        break;
      case 1:
        setState(() {
          adults = 1;
        });
        getAnimation(forAdults: 1, dayOfWeekId: weekDayId);
        break;
    }
  }

  getAnimationType() async {
    var animationType = await ApiRouter.getAnimationType();
  }

  getAnimation({required int forAdults, required int dayOfWeekId,}) async {
    setState(() {
      loadingList = true;
    });
    List<AnimationModel> result = await ApiRouter.getAllAnimations();
    setState(() {
      loadingList = false;
      animationList = sortAnimationList(result);
    });
  }

  getDayWeek() async {
    var weekDay = await ApiRouter.getDayWeekAnimation();
    setState(() {
      weekDayList = weekDay;
    });
  }

  Widget weekDayButton(AnimationWeekDay weekDay, bool active, int index) {
    NeumorphicBoxShape boxShape =
        NeumorphicBoxShape.roundRect(BorderRadius.circular(10));
    double intensity = 0.8;
    double surfaceIntensity = 0.5;
    double height = 70.0;
    double width = 70.0;
    
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          padding: EdgeInsets.all(5),
          width: width,
          height: height,
          child: NeumorphicButton(
            padding: EdgeInsets.zero,
            duration: Duration(milliseconds: 300),
            onPressed: () {
              // getAnimation(forAdults: adults, dayOfWeekId: weekDay.id!);
              for(int i = 0; i < statusDayOfWeek.length; i++) {
                setState(() {
                  statusDayOfWeek[i] = false;
                });
              }
              setState(() {
                weekDayId = weekDay.id!;
                statusDayOfWeek[index] = statusDayOfWeek[index] ? false : true;
                weekDay.active = 0;
              });
            },
            style: NeumorphicStyle(
              boxShape: boxShape,
              // boxShape: boxShape,
              color: ConfigColor.bgColor,
              // shape: this.shape,
              intensity: intensity,
              shadowLightColor: ConfigColor.shadowLightColor ,
              shadowDarkColor: ConfigColor.shadowDarkColor.withOpacity(0.6),
              surfaceIntensity: surfaceIntensity,
              depth: active ? 0 : 5,
              // lightSource: this.lightSource,
            ),
            child: Container(
              margin: EdgeInsets.all(12),
              child: Center(child: Text(weekDay.shortTitle!, style: Theme.of(context).textTheme.headline1)),
            )
          ),
        ),
      ],
    );
  }

  List<AnimationModel> sortAnimationList(List<AnimationModel> animations) {
    List<AnimationModel> sortList = [];
    for(int i = 0; i < animations.length; i++) {
      for(int j = 0; j < animations[i].animationTimes!.length; j++) {
        AnimationModel animationTimes = AnimationModel();
        animationTimes.title = animations[i].title;
        animationTimes.place = animations[i].place;
        animationTimes.startTime = animations[i].animationTimes![j].startTime;
        animationTimes.endTime = animations[i].animationTimes![j].endTime;
        sortList.add(animationTimes);
      }
    }
    sortList.sort((a,b) => a.startTime!.compareTo(b.startTime!));
    return sortList;
  }

  animationItem(AnimationModel animation) {
    return Container(
      height: 50,
      child:  Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
        Row(
          children: [
            Text('${animation.startTime} - ', style: Theme.of(context).textTheme.headline1!.copyWith(fontSize: 14),),
            Text(animation.endTime ?? '', style: Theme.of(context).textTheme.headline1!.copyWith(fontSize: 14)),
          ],
        ),
        Text(animation.title ?? '', style: Theme.of(context).textTheme.headline3!.copyWith(fontSize: 14)),
        Text('(${animation.place})', style: Theme.of(context).textTheme.headline3!.copyWith(fontSize: 14))
      ],)
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        shadowColor: Colors.transparent,
        backgroundColor: ConfigColor.bgColor,
      ),
      body:
      Column(
        children: [
          Container(
            height: 60,
            child: TabBar(
              controller: _tabController,
              indicatorColor: ConfigColor.additionalColor,
              tabs: [
                Container(
                  padding: EdgeInsets.all(5),
                  child: Text('Детская', style: Theme.of(context).textTheme.headline1)
                ),
                Container(
                  padding: EdgeInsets.all(5),
                  child: Text('Взрослая', style: Theme.of(context).textTheme.headline1)
                )
              ],
            ),
          ),
          Container(
            height: 80,
            child: FutureBuilder(
              future: ApiRouter.getDayWeekAnimation(),
              builder: (ctx, AsyncSnapshot<List> snapshot) {
                print(snapshot);
                if(snapshot.hasData) { 
                  return ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: snapshot.data?.length,
                    itemBuilder: (ctx, i) {
                      return weekDayButton(snapshot.data?[i], statusDayOfWeek[i], i);
                    }
                  );
                }
                return Center(
                  child: CircularProgressIndicator(backgroundColor: ConfigColor.assentColor,),
                );
              },
            )
          ),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                SingleChildScrollView(
                  child: Column(
                    children: [
                      Container(
                        height: 400,
                        child: loadingList
                        ?
                        Center(
                          child: CircularProgressIndicator(backgroundColor: ConfigColor.assentColor,),
                        )
                        :
                        animationList.length == 0 ?
                        Center(
                          child: Text('Список анимаций не найден'),
                        ) :
                        ListView.builder(
                          itemCount: animationList.length,
                          itemBuilder: (ctx, i) {
                            return animationItem(animationList[i]);
                          }
                        ),
                      )
                    ],
                  ),
                ),
                SingleChildScrollView(
                  child: Column(
                    children: [
                      Container(
                        height: 400,
                        child: loadingList
                        ?
                        Center(
                          child: CircularProgressIndicator(backgroundColor: ConfigColor.assentColor,),
                        )
                        :
                        animationList.length == 0 ?
                        Center(
                          child: Text('Список анимаций не найден'),
                        ) :
                        ListView.builder(
                          itemCount: animationList.length,
                          itemBuilder: (ctx, i) {
                            return animationItem(animationList[i]);
                          }
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}