import 'package:flutter/material.dart';
import 'package:hotel_manager/helper/config_color.dart';
import 'package:hotel_manager/provider/widget_factory_provider.dart';
import 'package:hotel_manager/repository/api_router.dart';


class DetailCard extends StatefulWidget {
  final int id;
  final String path;
  DetailCard({Key ?key, required this.id, required this.path}) : super(key: key);

  @override
  _DetailCardState createState() => _DetailCardState();
}

class _DetailCardState extends State<DetailCard> {
  var cardModel;
  var widgeth;
  @override
  void initState() { 
    super.initState();
    getData();
  }

  getData() async {
    cardModel = await ApiRouter.getDetailCard(widget.id, widget.path);
    WidgetFactoryProvider widgetFactoryProvider = WidgetFactoryProvider.of(context);
    setState(() {
      widgeth = widgetFactoryProvider.widgetFactory.createWidget(cardModel);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(cardModel?.title ?? '', style: Theme.of(context).textTheme.headline1,),
        shadowColor: Colors.transparent,
        backgroundColor: ConfigColor.bgColor,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back_ios, color: ConfigColor.assentColor),
        )
      ),
      backgroundColor: ConfigColor.bgColor,
      body: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return [ 
            SliverAppBar(
              leading: Container(),
              bottom: PreferredSize(
                child: Container(),
                preferredSize: Size(0, 20),
              ),
              pinned: false,
              expandedHeight: MediaQuery.of(context).size.height * 0.4,
              flexibleSpace: Stack(
                children: [
                  Positioned(
                    child: 
                    cardModel?.image == null ?
                    Container(
                      child: Center(
                        child: Icon(Icons.people_alt_rounded, color: ConfigColor.assentColor),
                      ),
                    ) 
                    :
                    Image(
                      fit: BoxFit.cover,
                      image: NetworkImage(
                        cardModel.image,
                      ),
                    ),
                    top: 0,
                    left: 0,
                    right: 0,
                    bottom: 0
                  ),
                  Positioned(
                    child: Container(
                      height: 30,
                      decoration: BoxDecoration(
                        color: ConfigColor.bgColor,
                        borderRadius: BorderRadius.vertical(
                          top: Radius.circular(50),
                        ),
                      ),
                    ),
                    bottom: -1,
                    left: 0,
                    right: 0,
                  ),
                ],
              ),
            ),
          ];
        },
        body: SingleChildScrollView(
          physics: NeverScrollableScrollPhysics(),
          child: widgeth 
          ?? Container(
            child: Center(
              child: CircularProgressIndicator(),
            ),
          )
        ),
      ),
    );
  }
}