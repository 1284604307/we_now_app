import 'package:flutter/material.dart';

/**
 * @author Ming
 * @date 2020/4/18
 * @email 1284604307@qq.com
 */
class GlobalConfig {
  static bool dark = false;
  static ThemeData themeData =  new ThemeData(
    primaryColor: Colors.white,
    scaffoldBackgroundColor: new Color(0xFFEBEBEB),
  );
  static Color searchBackgroundColor = Colors.white;//new Color(0xFFEBEBEB);
  static Color cardBackgroundColor = Colors.white;
  static Color globalBackgroundColor = Color.fromRGBO(0, 0, 0, 0.02);
  static Color fontColor = Colors.black54;
  static Color titleColor = Colors.black;
  static Color themeColor = Colors.black54;
}