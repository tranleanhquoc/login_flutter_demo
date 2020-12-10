import 'package:flutter/cupertino.dart';

class AppDimension {
  static AppDimension shared;
  double width;
  double height;
  final BuildContext context;
  AppDimension(this.context) {
    shared = this;
  }
}
