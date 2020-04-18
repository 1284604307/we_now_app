import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:flutter_app2/conf/configure.dart';

/**
 * @author Ming
 * @date 2020/4/18
 * @email 1284604307@qq.com
 */
getNewsResult([int page=0]) async{
  String url = 'http://'+Config.IP+':'+Config.PORT+'/getNewsResult.json?action=getNewsResult&page=$page';

  var res = await http.get(url);
//  String body = res.body;
  var body = Utf8Codec().decode(res.bodyBytes); // jsonDecode(body);
  var json = jsonDecode(body); // jsonDecode(body);
//  print(json);
//  print(json['items']);

  return json['items'] as List;
}