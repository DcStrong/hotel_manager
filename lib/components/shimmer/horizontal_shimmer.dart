import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class HorizontalShimmer extends StatelessWidget {
  const HorizontalShimmer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Shimmer.fromColors(
          baseColor: Colors.grey[300]!,
          highlightColor: Colors.grey[100]!,
          child: Padding(
            padding: EdgeInsets.only(left: 15, right: 15, top: 5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
              Container(
                width: 100, height: 20, color: Colors.black
              ),
              Container(
                width: 30, height: 20, color: Colors.black
              )
            ],),
          )
        ),
        Container(
          height: 200,
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
          child: Shimmer.fromColors(
            baseColor: Colors.grey[300]!,
            highlightColor: Colors.grey[100]!,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemBuilder: (_, __) => Padding(
                padding: const EdgeInsets.only(bottom: 8.0),
                child: Container(
                  padding: EdgeInsets.all(8.0),
                  width: 250,
                  child: Column(
                    children: [
                      Container(
                        height: 100,
                        color: Colors.black,
                      ),
                      SizedBox(height: 4,),
                      Container(
                        height: 5,
                        color: Colors.black,
                      ),
                      SizedBox(height: 4,),
                      Container(
                        height: 5,
                        color: Colors.black,
                      ),
                    ],
                  ),
                )
              ),
              itemCount: 3,
            ),
          ),
        ),
      ],
    );
  }
}