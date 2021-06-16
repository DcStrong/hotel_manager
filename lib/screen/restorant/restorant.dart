import 'package:flutter/material.dart';
import 'package:hotel_manager/components/widget/card/vertical_card.dart';
import 'package:hotel_manager/model/card_model.dart';

class RestorantScreen extends StatefulWidget {
  RestorantScreen({Key? key}) : super(key: key);

  @override
  _RestorantScreenState createState() => _RestorantScreenState();
}

class _RestorantScreenState extends State<RestorantScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Рестораны'),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(top: 10.0, left: 15, right: 15),
          child: ListView.builder(
            itemCount: 2,
            itemBuilder: (ctx, i) {
              return GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, 'products');
                },
                child: VerticalCard(
                  card: CardModel(image: 'https://picsum.photos/id/1048/1920/1080', subtitle: 'Ресторан восточной кухни', title: 'Шляпа')
                  )
                );
            }
          ),
        )
      ),
    );
  }
}