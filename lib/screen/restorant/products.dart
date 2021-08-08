import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:hotel_manager/components/buttons/button_elevated.dart';
import 'package:hotel_manager/components/buttons/button_neumorphic.dart';
import 'package:hotel_manager/components/buttons/leading_button_back.dart';
import 'package:hotel_manager/components/widget/basketNavBar.dart';
import 'package:hotel_manager/helper/config_color.dart';
import 'package:hotel_manager/model/detail_food.dart';
import 'package:hotel_manager/model/food.dart';
import 'package:hotel_manager/provider/basket_product.dart';
import 'package:hotel_manager/provider/user.dart';
import 'package:hotel_manager/repository/api_router.dart';
import 'package:hotel_manager/screen/auth/auth_screen.dart';
import 'package:provider/provider.dart';

class ProductsScreen extends StatefulWidget {
  final int id;
  ProductsScreen({Key? key, required this.id}) : super(key: key);

  @override
  _ProductsScreenState createState() => _ProductsScreenState();
}

class _ProductsScreenState extends State<ProductsScreen> {
  List<Food> foods = [];
  double? _widthCard;
  bool multiple = false;
  double? _width;
  double? _heightImage = 150;

  ScrollController _scrollController = ScrollController();
  int page = 2;
  bool _isLoad = false;
  bool _loadMore = true;


  void _scrollListener() async {
    if (_scrollController.offset >= _scrollController.position.maxScrollExtent &&
      !_scrollController.position.outOfRange && _loadMore) {
      setState(() {
       _isLoad = true;
      });

      List<Food> result = await ApiRouter.getRestourantFoods(widget.id, page: page);

      if(result.length > 0) {
        setState(() {
          foods.addAll(result);
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
  void initState() {
    super.initState();
    _scrollController.addListener(_scrollListener);
    getResoutantFoods();
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      setState(() {
        _width = MediaQuery.of(context).size.width;
        if(_widthCard == null) {
          _widthCard = _width! / 2;
        }
      });
    });
  }

  @override
  void dispose() {
    _scrollController.removeListener(_scrollListener);
    _scrollController.dispose();
    super.dispose();
  }

  allertDialog(BuildContext context) {
    showDialog<String>(
      context: context,
      builder: (BuildContext _context) => AlertDialog(
        content: const Text('Для того что бы продолжить, вам необходимо авторизироваться'),
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.pop(_context, 'Cancel'),
            child: Text('Закрыть'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(_context);
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return AuthScreen(pathRoute: true);
                }));
            },
            child: Text('ОК'),
          ),
        ],
      ),
    );
  }

  getResoutantFoods() async {
    List<Food> result = await ApiRouter.getRestourantFoods(widget.id);
    setState(() {
      foods = result;
    });
  }

  Widget appBar() {
    return SizedBox(
      height: AppBar().preferredSize.height,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(top: 8, left: 8),
            child: Container(
              width: AppBar().preferredSize.height - 8,
              height: AppBar().preferredSize.height - 8,
              child: iconButtonBack(context),
            ),
          ),
          Expanded(
            child: Center(
              child: Padding(
                padding: const EdgeInsets.only(top: 4),
                child: Text('Меню', style: Theme.of(context).textTheme.headline1,),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 8, right: 8),
            child: Container(
              width: AppBar().preferredSize.height - 8,
              height: AppBar().preferredSize.height - 8,
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  borderRadius:
                      BorderRadius.circular(AppBar().preferredSize.height),
                  child: Icon(
                    multiple ? Icons.dashboard : Icons.view_agenda,
                    color: ConfigColor.assentColor,
                  ),
                  onTap: () {
                    if(multiple) {
                      setState(() {
                        _widthCard = _width! / 2;
                        _heightImage = _widthCard! - 40;
                        multiple = !multiple;
                      });
                    } else {
                      setState(() {
                        _widthCard = _width;
                        _heightImage = 200;
                        multiple = !multiple;
                      });
                    }
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  
void showBottomSheet(DetailFood detail) {
  double padding = 8.0;
  showModalBottomSheet(
    shape: RoundedRectangleBorder(
     borderRadius: BorderRadius.only(
       topLeft: Radius.circular(10.0),
       topRight: Radius.circular(10.0),
      ),
    ),
    context: context,
    builder: (context) {
      return 
      Consumer<User>(
      builder: (context, user, _) {
        return 
        Consumer<Basket>(
          builder: (BuildContext context, store, Widget? child) {
            List<Food> basket = store.basketInFood;
            var element = basket.where((e) => e.id == detail.id);
            return Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10)
              ),
              padding: EdgeInsets.all(12.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                    Text(detail.title, style: Theme.of(context).textTheme.headline1),
                    if(detail.description != null)
                      Padding(
                        padding: EdgeInsets.only(top: padding),
                        child: Text(detail.description!, style: Theme.of(context).textTheme.bodyText1),
                      ),
                    if(detail.ingredients != null)
                      Padding(
                        padding: EdgeInsets.only(top: padding),
                        child: Text(detail.ingredients!, style: Theme.of(context).textTheme.bodyText1),
                      ),
                    if(detail.weight != null)
                      Padding(
                        padding: EdgeInsets.only(top: padding),
                        child: Text('Вес: ${detail.weight!.toString()} г', style: Theme.of(context).textTheme.bodyText1),
                      ),
                    if(detail.fats != null)
                      Padding(
                        padding: EdgeInsets.only(top: padding),
                        child: Text('Жиры: ${detail.fats!.toString()}', style: Theme.of(context).textTheme.bodyText1),
                      ),
                    if(detail.proteins != null)
                      Padding(
                        padding: EdgeInsets.only(top: padding),
                        child: Text('Белки: ${detail.proteins!.toString()}', style: Theme.of(context).textTheme.bodyText1),
                      ),
                    if(detail.carbohydrates != null)
                      Padding(
                        padding: EdgeInsets.only(top: padding),
                        child: Text('Углеводы: ${detail.carbohydrates!.toString()}', style: Theme.of(context).textTheme.bodyText1),
                      ),
                    if(element.isEmpty)
                      buttonElevatedFullForPrice(
                        detail.price,
                        context,
                        () async {
                          Food product = new Food(
                            id: detail.id, 
                            title: detail.title, 
                            preview: null, 
                            restaurantId: detail.restourantId!,
                            price: detail.price,
                            discountPrice: detail.discountPrice,
                            weight: detail.weight,
                          );
                          if (user.userProfile.token != null) {
                            store.addBasketProduct(product);
                          } else {
                            allertDialog(context);
                          }
                        },
                        priceSale: detail.discountPrice
                      ),
                ],
              ),
            );
          });
      });
    });
}

  Widget cardProduct(Food product) {
    return 
    Consumer<User>(
      builder: (context, user, _) {
        return Container(
          padding: EdgeInsets.all(8),
          width: _widthCard,
          child: Neumorphic(
            style: NeumorphicStyle(
              lightSource: LightSource.top,
              color: ConfigColor.bgColor,
              boxShape: NeumorphicBoxShape.roundRect(BorderRadius.circular(15)),
              shadowLightColor: ConfigColor.shadowLightColor,
              shadowDarkColor: ConfigColor.shadowDarkColor.withOpacity(0.6),
            ),
            child: InkWell(
              onTap: () async {
                DetailFood detail = await ApiRouter.getDetailFood(product.id);
                showBottomSheet(detail);
              },
              child: Container(
                margin: EdgeInsets.all(8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10)
                      ),
                      width: _widthCard,
                      height: _heightImage,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Image.network(
                          product.preview ?? '', fit: BoxFit.cover,
                          errorBuilder: (BuildContext context, Object exception, StackTrace? stackTrace) {
                            return Center(
                              child: Image.asset(
                                'assets/img/image_not_found.jpg',
                                fit: BoxFit.fitWidth,
                              )
                            );
                          },
                        )
                      ),
                    ),
                    SizedBox(height: 10,),
                    Container(
                      width: _widthCard,
                      child: Text(
                        product.title, 
                        style: Theme.of(context).textTheme.headline1!.copyWith(fontSize: 14),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                      )
                    ),
                    SizedBox(height: 10,),
                    Text('${product.weight.toString()} г', style: Theme.of(context).textTheme.bodyText1),
                    Consumer<Basket>(
                      builder: (BuildContext context, store, Widget? child) {
                        List<Food> basket = store.basketInFood;
                        var element = basket.where((e) => e.id == product.id);
                        if(element.isNotEmpty) {
                          return Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              flatButtonNeumorphic(Icons.remove, () {store.decreaseCountProductInBasket(product);}),
                              Container(
                                child: Center(
                                  child: Text(
                                    element.last.quantity.toString(), 
                                    style: Theme.of(context).textTheme
                                      .headline2?.copyWith(
                                        color: ConfigColor.assentColor, 
                                        fontWeight: FontWeight.w600,
                                        fontSize: 12
                                    )
                                  ),
                                )
                              ),
                              flatButtonNeumorphic(Icons.add, () {store.increaseCountProductInBasket(product);}),
                          ],);
                        } else {
                          return
                            buttonElevatedFullForPrice(
                              product.price!,
                              context,
                              () async {
                                if (user.userProfile.token != null) {
                                  store.addBasketProduct(product);
                                } else {
                                  allertDialog(context);
                                }
                              },
                              priceSale: product.discountPrice
                            );
                        }
                      }
                    ),
                ],),
              ),
            ),
          ),
        );
      });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            appBar(),
            // FutureBuilder(
            //   future: ApiRouter.getProductCategories(1),
            //   builder: (ctx, AsyncSnapshot snapshot) {
            //     return Container();
            //   }
            // ),
            // buttonElevated('te', context, () {ApiRouter.getProductCategories(1);}),
            Expanded(
              child: RefreshIndicator(
                onRefresh: _refresh,
                child: GridView.builder(
                  controller: _scrollController,
                  itemCount: foods.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 0.5,
                    crossAxisSpacing: 4.0,
                    mainAxisSpacing: 4.0
                  ),
                  itemBuilder: (ctx, i) {
                    return cardProduct(foods[i]);
                  }
                ),
                // child: SingleChildScrollView(
                //   controller: _scrollController,
                //   child: Wrap(
                //     children: foods.map((product) => cardProduct(product)).toList(),
                //   ),
                // ),
              ),
            ),
            _isLoad ?
            Center(
              child: CircularProgressIndicator(backgroundColor: ConfigColor.assentColor,),
            ) : Container()
          ],
        )
      ),
      bottomNavigationBar: basketNavBar()
    );
  }
}