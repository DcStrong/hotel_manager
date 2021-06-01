import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class VerticalShimmer extends StatelessWidget {
  VerticalShimmer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          Expanded(
            child: Shimmer.fromColors(
              baseColor: Colors.grey[300]!,
              highlightColor: Colors.grey[100]!,
              child: ListView.builder(
                shrinkWrap: true,
                itemBuilder: (_, __) => Padding(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: Column(
                    children: [
                      Container(
                        color: Colors.black, 
                        height: 150,
                      ),
                      SizedBox(height: 4,),
                      Container(
                        color: Colors.black,
                        height: 10,
                      ),
                      SizedBox(height: 4,),
                      Container(
                        color: Colors.black,
                        height: 10,
                      )
                    ],
                  )
                ),
                itemCount: 5,
              ),
            ),
          ),
        ],
      ),
    );
  }
}