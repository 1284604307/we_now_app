import 'package:bot_toast/bot_toast.dart';
import 'package:flutter_app2/common/pojos/User.dart';
import 'package:flutter_app2/services/model/Article.dart';
import 'package:flutter_app2/services/model/Banner.dart';
import 'package:flutter_app2/services/net/api.dart';

import 'real_api.dart';

/**
 * @createDate  2020/4/25
 */

final Http http = Http();

class RestfulApi {

  static Future login(String username, String password) async {
    await http.post<Map>('/login', queryParameters: {
      'username': username,
      'password': password,
      'rememberMe': true
    });
    BotToast.showText(text: "登陆成功");
    var response = await getInfo();
    return User.fromJson(response.data);
  }

  static Future getInfo() async{
    return http.get("/user");
  }

  static Future logout() async{
    return http.get("/logout");
  }

  static Future fetchBanners() async{
    var response = await http.get('/public/banner');
    return response.data
        .map<Banner>((item) => Banner.fromJson(item))
        .toList();
  }

  /// desc 获取分页文章
  static Future fetchArticles(int pageNum, {int cid}) async {
    await Future.delayed(Duration(seconds: 1)); //增加动效
    var response = await http.get('/public/article/list/$pageNum',
        queryParameters: (cid != null ? {'cid': cid} : null));

    return response.data
        .map<Article>((item) => Article.fromJson(item))
        .toList();
  }

  ///  desc 获取置顶文章
  static Future fetchTopArticles() async{
    var response = await http.get('/public/article/top');
    return response.data.map<Article>((item) => Article.fromJson(item)).toList();
  }
}