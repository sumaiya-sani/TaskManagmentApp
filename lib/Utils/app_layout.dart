
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Applayout {
  static getSize(BuildContext context) {
    return MediaQuery
        .of(context)
        .size;
  }

  static getScreenHeight() {
    return Get.height;
  }

  //from dependices
  static getScreenWidth() {
    return Get.width;
  }

  //get any height

  static getHeight(double pixels) {
    double x = getScreenHeight() / pixels;
    return getScreenHeight() / x;
  }

  static getWidth(double pixels) {
    double x = getScreenWidth() / pixels;
    return getScreenWidth() / x;
  }
}
