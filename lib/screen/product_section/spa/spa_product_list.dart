import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:hotel_manager/components/buttons/leading_button_back.dart';
import 'package:hotel_manager/components/shimmer/vertical_shimmer.dart';
import 'package:hotel_manager/components/widget/card/vertical_card.dart';
import 'package:hotel_manager/helper/config_color.dart';
import 'package:hotel_manager/repository/api_router.dart';
import 'package:hotel_manager/screen/detail_card.dart';

class SpaProductList extends StatefulWidget {
  final int ?categoryId;
  SpaProductList(this.categoryId);

  @override
  _SpaProductListState createState() => _SpaProductListState();
}

class _SpaProductListState extends State<SpaProductList> {
  List _listProduct = [];
  bool _isLoad = false;
  bool _loadMore = true;
  var _typeActive;
  ScrollController _scrollController = ScrollController();
  int page = 2;

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

  Widget buttonText(String text, int id, BuildContext context) {
    final ButtonStyle textButtonStyle = TextButton.styleFrom(
      primary: ConfigColor.assentColor,
      minimumSize: Size(88, 36),
      padding: EdgeInsets.symmetric(horizontal: 16),
    );

    return Container(
      decoration: BoxDecoration(
        color: _typeActive == id ? ConfigColor.assentColor : Colors.white,
        borderRadius: BorderRadius.circular(8),
      ),
      child: TextButton(
        style: textButtonStyle,
        onPressed: () async {
          _listProduct.clear();
          if(_typeActive == id) {
            setState(() {
              _loadMore = true;
              page = 2;
              _typeActive = null;
            });
            Map<String, dynamic> result = await ApiRouter.getSectionSpaCard(categoryId: widget.categoryId!, typeId: _typeActive!);
            _listProduct = result['products'];
          } else {
            setState(() {
              _loadMore = true;
              page = 2;
              _typeActive = id;
            });
            Map<String, dynamic> result = await ApiRouter.getSectionSpaCard(categoryId: widget.categoryId!, typeId: _typeActive!);
            _listProduct = result['products'];
          }
        },
        child: Text(text, style: TextStyle(fontFamily: 'MontseratMedium', fontSize: 16, fontWeight: FontWeight.w600, color: _typeActive == id ? Colors.white : ConfigColor.assentColor),),
      ),
    );
  }

  
  void _scrollListener() async {
    if (_scrollController.offset >= _scrollController.position.maxScrollExtent &&
      !_scrollController.position.outOfRange && _loadMore) {
      setState(() {
       _isLoad = true;
      });
      String key = 'products';
      Map<String, dynamic> result = await ApiRouter.getSectionSpaCard(categoryId: widget.categoryId!, page: page, typeId: _typeActive!);
      if(result.containsKey(key)) {
        if(result[key].length > 0) {
          setState(() {
            _listProduct.addAll(result[key]);
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
  }

  Future<void> _refresh() async {
    setState(() {
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('SPA-Процедуры', style: Theme.of(context).textTheme.headline1,),
        backgroundColor: ConfigColor.bgColor,
        shadowColor: Colors.transparent,
        leading: iconButtonBack(context),
      ),
      backgroundColor: ConfigColor.bgColor,
      body: Container(
        child: FutureBuilder<Map<String, dynamic>>(
            future: ApiRouter.getSectionSpaCard(categoryId: widget.categoryId!),
            builder: (ctx, AsyncSnapshot<Map<String, dynamic>> snapshot) {
              if(snapshot.hasData) {
                if(_listProduct.length == 0) {
                  _listProduct = snapshot.data!['products'];
                }
                return RefreshIndicator(
                  color: ConfigColor.assentColor,
                  onRefresh: _refresh,
                  child: Column(
                    children: [
                      Container(
                        margin: EdgeInsets.only(bottom: 10, left: 10),
                        height: 30,
                        child: ListView.builder(
                          shrinkWrap: true,
                          itemCount: snapshot.data?['types']?.length,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (ctx, i) {
                            return buttonText(snapshot.data?['types'][i]['value'], snapshot.data?['types'][i]['id'], context);
                            // return Text(snapshot.data['types'][i]['value']);
                          }
                        ),
                      ),
                      Expanded(
                        child: ListView.separated(
                          controller: _scrollController,
                          shrinkWrap: true,
                          separatorBuilder: (ctx, i) {
                            return SizedBox(height: 10,);
                          },
                          itemCount: _listProduct.length,
                          itemBuilder: (ctx, i) {
                            return
                            Padding(
                              padding: const EdgeInsets.only(left: 15.0, right: 15.0),
                              child: GestureDetector(
                                onTap: () {
                                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                                    return DetailCard(id: _listProduct[i].id, path: 'spa-procedures',);
                                  }));
                                },
                                child: VerticalCard(card: _listProduct[i])
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