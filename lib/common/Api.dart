import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter_app2/services/model/Article.dart';
import 'package:jmessage_flutter/jmessage_flutter.dart';
import 'package:jpush_flutter/jpush_flutter.dart';


/**
 * @author Ming
 * @date 2020/4/18
 * @email 1284604307@qq.com
 */
class Api{
  static ScrollController globalScrollController = ScrollController(initialScrollOffset: 0,keepScrollOffset: true);
  static Article newCircleEntity = Article();
  static JPush jpush ;
  static JmessageFlutter jMessage;
}