import 'package:flutter/material.dart';

//My Class is based on this:
//Source: https://medium.com/flutter-community/flutter-effectively-scale-ui-according-to-different-screen-sizes-2cb7c115ea0a

class SizeConfig {
  static MediaQueryData _mediaQueryData;
  static double screenWidth;
  static double screenHeight;
  static double blockSizeHorizontal;
  static double blockSizeVertical;
  static double _safeAreaHorizontal;
  static double _safeAreaVertical;
  static double safeBlockHorizontal;
  static double safeBlockVertical;

  static double defaultSize;
  static Orientation orientation;

  void init(BuildContext context) {
    _mediaQueryData = MediaQuery.of(context);

    orientation = _mediaQueryData.orientation;
    screenWidth = _mediaQueryData.size.width;
    screenHeight = _mediaQueryData.size.height;

    blockSizeHorizontal = screenWidth / 100;
    blockSizeVertical = screenHeight / 100;

    _safeAreaHorizontal =
        _mediaQueryData.padding.left + _mediaQueryData.padding.right;
    _safeAreaVertical =
        _mediaQueryData.padding.top + _mediaQueryData.padding.bottom;

    //How use: width = safeBlockHorizontal * yourSize
    safeBlockHorizontal = (screenWidth - _safeAreaHorizontal) / 100;
    safeBlockVertical = (screenHeight - _safeAreaVertical) / 100;

    //print("screenHeight==> $screenHeight");
    //print("screenWidth==> $screenWidth");
    //print("screenHeight==> $screenHeight");
    //print("blockSizeHorizontal==> $blockSizeHorizontal");
    //print("blockSizeVertical==> $blockSizeVertical");
    //print("safeBlockHorizontal==> $safeBlockHorizontal");
    //print("safeBlockVertical==> $safeBlockVertical");
    //print("textScaleFactor==> ${_mediaQueryData.textScaleFactor}");
  }
}

double getWidth(double size) {
  if (SizeConfig.orientation == Orientation.portrait)
    return SizeConfig.safeBlockHorizontal * size;
  else
    return SizeConfig.safeBlockVertical * size;
}

double getHeight(double size) {
  if (SizeConfig.orientation == Orientation.portrait)
    return SizeConfig.safeBlockVertical * size;
  else
    return SizeConfig.safeBlockHorizontal * size;
}

double getFontSize(double size) {
  if (SizeConfig.orientation == Orientation.portrait)
    return SizeConfig.safeBlockHorizontal * size;
  else
    return SizeConfig.safeBlockVertical * size;
}

double getSmallPadding() {
  ////print("Small: ${SizeConfig.safeBlockVertical * 0.6}");
  return SizeConfig.safeBlockVertical * 0.6;
}

double getMediumPadding() {
  ////print("Medium: ${SizeConfig.safeBlockVertical * 1.2}");
  return SizeConfig.safeBlockVertical * 1.2;
}

double getLargePadding() {
  //print("Large: ${SizeConfig.safeBlockVertical * 2.4}");
  return SizeConfig.safeBlockVertical * 0.8;
}
