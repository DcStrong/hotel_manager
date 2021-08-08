import 'package:flutter/material.dart';
import 'package:hotel_manager/components/buttons/leading_button_back.dart';
import 'package:hotel_manager/components/shimmer/vertical_shimmer.dart';
import 'package:hotel_manager/components/widget/card/vertical_card.dart';
import 'package:hotel_manager/helper/config_color.dart';
import 'package:hotel_manager/repository/api_router.dart';
import 'package:hotel_manager/screen/detail_card.dart';

class ScreenProduct extends StatefulWidget {
  final String title;
  final String path;
  final int? categoryId;
  ScreenProduct({Key ?key, required this.title, required this.path, this.categoryId}) : super(key: key);

  @override
  _ScreenProductState createState() => _ScreenProductState();
}

class _ScreenProductState extends State<ScreenProduct> {

  ScrollController _scrollController = ScrollController();
  int page = 2;
  List _listProduct = [];
  bool _isLoad = false;
  bool _loadMore = true;

  @override
  void initState() { 
    super.initState();
    _scrollController.addListener(_scrollListener);
  }

  @override
  void dispose() {
    _scrollController.removeListener(_scrollListener);
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollListener() async {
    if (_scrollController.offset >= _scrollController.position.maxScrollExtent &&
      !_scrollController.position.outOfRange && _loadMore) {
      setState(() {
       _isLoad = true;
      });
      String key = 'products';
      List result = await ApiRouter.getSectionCard(this.widget.path, categoryId: widget.categoryId, page: page);

      if(result.length > 0) {
        setState(() {
          _listProduct.addAll(result);
          page++;
          _isLoad = false;
        });
      } else {
        setState(() {
          _isLoad = false;
          _loadMore = false;
        });
      }
    }
  }

  Future<void> _refresh() async {
    setState(() {
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(this.widget.title, style: Theme.of(context).textTheme.headline1,),
        backgroundColor: ConfigColor.bgColor,
        shadowColor: Colors.transparent,
        leading: iconButtonBack(context),
      ),
      backgroundColor: ConfigColor.bgColor,
      body: Container(
        child: FutureBuilder(
            initialData: [],
            future: ApiRouter.getSectionCard(this.widget.path, categoryId: widget.categoryId),
            builder: (ctx, AsyncSnapshot<List> snapshot) {
              print(snapshot);
              if(snapshot.hasData) {
                if(_listProduct.length == 0) {
                  _listProduct = snapshot.data!;
                }
                return RefreshIndicator(
                  onRefresh: _refresh,
                  child: Column(
                    children: [
                      Expanded(
                        child: ListView.separated(
                          controller: _scrollController,
                          shrinkWrap: true,
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
                                    return DetailCard(id: snapshot.data?[i].id, path: this.widget.path,);
                                  }));
                                },
                                child: VerticalCard(card: snapshot.data?[i])
                              ),
                            );
                          }
                        ),
                      ),
                      _isLoad ?
                      Center(
                        child: CircularProgressIndicator(backgroundColor: ConfigColor.assentColor,),
                      ) : Container()
                    ],
                  ),
                );
              }
              return VerticalShimmer();
            }
          ),
      ),
    );
  }
}