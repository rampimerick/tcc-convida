import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

double containerWidth = 220.0;
double containerHeight = 10.0;

class ShimmerComponent extends StatelessWidget {
  ShimmerComponent({Key key, @required this.screen,this.icon, this.iconOperation}) : super(key: key);
  final int screen;
  final icon;
  final iconOperation;

  @override

  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: 6,
        itemBuilder: (index, context) {
          if (screen != 4 && screen != 5) {
            return Shimmer.fromColors(
                baseColor: Colors.grey[300],
                highlightColor: Colors.white,
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      ClipRRect(
                        borderRadius: BorderRadius.circular(10.0),
                        child: Container(
                          height: 85.0,
                          width: 75.0,
                          color: Colors.grey,
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Container(
                            height: containerHeight,
                            width: containerWidth * 0.70,
                            color: Colors.grey,
                          ),
                          SizedBox(height: 5.0),
                          Container(
                            height: containerHeight,
                            width: containerWidth,
                            color: Colors.grey,
                          ),
                          SizedBox(height: 25.0),
                          Container(
                            height: containerHeight,
                            width: containerWidth * 0.15,
                            color: Colors.grey,
                          ),
                          SizedBox(height: 5.0),
                          Container(
                            height: containerHeight,
                            width: containerWidth * 0.75,
                            color: Colors.grey,
                          ),
                        ],
                      ),
                    ],
                  ),
                ));
          } else {
            return Card(
              child: Shimmer.fromColors(
                  baseColor: Colors.grey[300],
                  highlightColor: Colors.white,
                  child: Container(
                    padding: EdgeInsets.symmetric(
                        vertical: 10, horizontal: 10),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[
                        ClipRRect(
                          borderRadius: BorderRadius.circular(10.0),
                          child: Icon(icon,
                              color: Colors.grey[300], size: 60),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Container(
                              height: containerHeight,
                              width: containerWidth * 0.80,
                              color: Colors.grey,
                            ),
                            SizedBox(height: 5.0),
                            Container(
                              height: containerHeight,
                              width: containerWidth * 0.15,
                              color: Colors.grey,
                            ),
                            SizedBox(height: 5.0),
                            Container(
                              height: containerHeight,
                              width: containerWidth * 0.45,
                              color: Colors.grey,
                            ),
                          ],
                        ),
                        Icon(iconOperation, color: Colors.grey[300],
                            size: 40),
                      ],
                    ),
                  )),
            );
          }
        }
    );
  }
}
