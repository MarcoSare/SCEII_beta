import 'package:flutter/material.dart';
import 'dart:math' as math;

class Responsive {
  double _width=0, _height=0, _diagonal=0, _fontSizeTitle=0, _fontSizeSubT=0, _fontSizeNormal = 0;
  bool _isTablet=false;

  double get width => _width;
  double get height => _height;
  double get diagonal => _diagonal;
  bool get isTablet =>_isTablet;
  double get fontSizeTilte => _fontSizeTitle;
  double get fontSizeSubT => _fontSizeSubT;
  double get fontSizeNormal => _fontSizeNormal;
  static Responsive of(BuildContext context) => Responsive(context);
  Responsive(BuildContext context){
    final Size size = MediaQuery.of(context).size;

    this._width = size.width;
    this._height = size.height;
    this._diagonal= math.sqrt(math.pow(_width, 2) + math.pow(_height, 2));
    this._isTablet= size.shortestSide>=600;
    if(_isTablet){
      this._fontSizeTitle=dp(3);
      this._fontSizeSubT=dp(2);
      this._fontSizeNormal=dp(1);
    }
    else{
      this._fontSizeTitle=dp(3.5);
      this._fontSizeSubT=dp(2);
      this._fontSizeNormal=dp(1.5);
    }
    
  }

  double wp(double percent) => _width*percent/100;
  double hp(double percent) => _height*percent/100;
  double dp(double percent) => _diagonal*percent/100;
}