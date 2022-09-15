import 'package:convida/app/shared/global/size_config.dart';
import 'package:flutter/material.dart';

class SectionTitle extends StatelessWidget {
  const SectionTitle({
    Key key,
    @required this.title,
    @required this.onTapText,
    @required this.onTap,
  }) : super(key: key);

  final String title;
  final String onTapText;
  final Function onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
          top: getSmallPadding(),
          left: getMediumPadding(),
          bottom: getSmallPadding(),
          right: getMediumPadding()),
      child: Row(
        children: [
          Text(
            title,
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          Spacer(),
          GestureDetector(
            onTap: onTap,
            child: Text(
              onTapText,
              style: TextStyle(color: Colors.white),
            ),
          )
        ],
      ),
    );
  }
}
