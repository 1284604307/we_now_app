import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class ImageHelper {
  static const String baseUrl = 'http://www.meetingplus.cn';
  static const String imagePrefix = '$baseUrl/uimg/';

  static String wrapUrl(String url) {
    if (url.startsWith('http')) {
      return url;
    } else {}
    return imagePrefix + url;
  }

  static String wrapAssets(String url) {
    return "assets/images/" + url;
  }

  static Widget placeHolder({double width, double height}) {
    return SizedBox(
        width: width,
        height: height,
        child: CupertinoActivityIndicator(radius: min(10.0, width / 3)));
  }

  static Widget error({double width, double height, double size}) {
    return SizedBox(
        width: width,
        height: height,
        child: Icon(
          Icons.error_outline,
          size: size,
        ));
  }

  static String randomUrl(
      {int width = 100, int height = 100, Object key = ''}) {
    return 'http://placeimg.com/$width/$height/${key.hashCode.toString() + key.toString()}';
  }
}

class IconFonts {
  IconFonts._();

  /// iconfont:flutter base
  static const String fontFamily = 'alibaba';

  static const IconData message = IconData(0xe67a, fontFamily: fontFamily);
  static const IconData message2 = IconData(0xe73c, fontFamily: fontFamily);
  static const IconData runState = IconData(0xe653, fontFamily: fontFamily);
  static const IconData connect = IconData(0xe60d, fontFamily: fontFamily);
  static const IconData draw = IconData(0xe664, fontFamily: fontFamily);
  static const IconData pointer = IconData(0xe653, fontFamily: fontFamily);

  static const IconData friend = IconData(0xe6a1, fontFamily: fontFamily);
  static const IconData buddy = IconData(0xe610, fontFamily: fontFamily);

  static const IconData messageDouble = IconData(0xe64e, fontFamily: fontFamily);

  static const IconData pageEmpty = IconData(0xe6b3, fontFamily: fontFamily);
  static const IconData pageError = IconData(0xe602, fontFamily: fontFamily);
  static const IconData pageNetworkError = IconData(0xe7f6, fontFamily: fontFamily);

  static const IconData theme = IconData(0xe664, fontFamily: fontFamily);
  static const IconData theme2 = IconData(0xe61c, fontFamily: fontFamily);

  static const IconData moon = IconData(0xefa7, fontFamily: fontFamily);
  static const IconData moonCloud = IconData(0xec70, fontFamily: fontFamily);


  static const IconData thumbUp = IconData(0xe9a7, fontFamily: fontFamily);
  static const IconData share = IconData(0xe60c, fontFamily: fontFamily);
}
