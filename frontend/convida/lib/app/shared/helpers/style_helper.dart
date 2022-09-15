import 'package:convida/app/shared/global/constants.dart';
import 'package:flutter/material.dart';

class TextStyleTitle extends TextStyle {
  final Color color;
  final FontWeight fontWeight;
  final double size;

  const TextStyleTitle({
    this.color = kPrimaryColor,
    this.fontWeight = FontWeight.bold,
    this.size = 16,
  })  : assert(color != null && fontWeight != null),
        super(
          color: color,
          fontWeight: fontWeight,
          fontSize: size,
        );
}

class TextStyleDescription extends TextStyle {
  final Color color;
  final FontWeight fontWeight;
  final double size;

  const TextStyleDescription({
    this.color = Colors.red,
    this.fontWeight = FontWeight.normal,
    this.size = 8,
  })  : assert(color != null && fontWeight != null),
        super(
          color: color,
          fontWeight: fontWeight,
          fontSize: size,
        );
}

class TextTitle extends Text {
  final String text;
  final TextStyle style;
  final TextOverflow textOverflow;
  final int maxLines;
  final bool softWrap;

  const TextTitle(
      {@required this.text,
      this.textOverflow = TextOverflow.ellipsis,
      this.maxLines = 1,
      this.softWrap = false,
      this.style = const TextStyle(
        color: kPrimaryColor,
        fontSize: 16,
      )})
      : super(text);
}

class TextDescription extends Text {
  final String text;
  final TextStyle style;
  final TextOverflow textOverflow;
  final int maxLines;
  final bool softWrap;

  const TextDescription(
      {@required this.text,
      this.textOverflow = TextOverflow.ellipsis,
      this.maxLines = 1,
      this.softWrap = false,
      this.style = const TextStyle(
        color: Colors.grey,
        fontSize: 12,
      )})
      : super(text);
}
