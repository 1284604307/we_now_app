import 'package:bot_toast/bot_toast.dart';
import 'package:flutter_app2/common/pojos/User.dart';
import 'package:flutter_app2/services/config/router_manger.dart';
import 'package:flutter_app2/services/helper/dialog_helper.dart';
import 'package:flutter_app2/services/model/Article.dart';
import 'package:flutter_app2/services/model/Banner.dart';
import 'package:flutter_app2/services/model/Comment.dart';
import 'package:flutter_app2/services/model/Topic.dart';
import 'package:flutter_app2/services/net/api.dart';
import 'package:flutter_app2/services/provider/view_state.dart';
import 'package:oktoast/oktoast.dart';
import 'package:flutter/cupertino.dart' show Navigator;

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

  static Future uploadImages(FormData data) async{
    await Future.delayed(Duration(seconds: 1)); //增加动效
    var response =  await http.post("/user/upload/files", data: data);
    return List<String>.from(response.data);
  }

  static Future postNewCircle(FormData data)async{
    var res = await http.post("/public/circle/", data: data);
    return res;
  }

  // desc 获取首页轮播图
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

  static Future fetchRecommendCircles(pageNum) async{
    var response = await http.get('/public/circle/hots/$pageNum');
    return response.data.map<Article>((item) => Article.fromJson(item)).toList();
  }

  static Future fetchSchoolCircles(pageNum) async{
    var response = await http.get('/public/circle/school/$pageNum');
    return response.data.map<Article>((item) => Article.fromJson(item)).toList();
  }


  static Future fetchArticleComment(articleId,{pageNum=0}) async{
    var response = await http.get('/public/circle/comments/$articleId/$pageNum');
    return response.data.map<Comment>((item) => Comment.fromJson(item)).toList();
  }


  static Future fetchChildrenComment(commentId,{pageNum=0}) async{
    var response = await http.get('/public/circle/commentChildren/$commentId/$pageNum');
    return response.data.map<Comment>((item) => Comment.fromJson(item)).toList();
  }


  static fetchCollectList(int pageNum) {

  }

  static unCollectCircle(articleId) async {
    var response = await http.put('/article/unCollect/$articleId');

  }

  static collectCircle(articleId) async {
    var response = await http.put('/article/collect/$articleId');
  }

  static unLikeCircle(articleId) async {
    var response = await http.put('/article/unlike/$articleId');
    return response.data;
  }

  static likeCircle(articleId) async {
    var response = await http.put('/article/like/$articleId');
    return response.data;
  }

  static comment(context,articleId,content,{pid=0,toId=0}) async{
      var res = await http.post(
          '/comment/${articleId}/${pid}/${toId}',
          queryParameters:{
            "content":content
          }
      ).catchError((e) async {
        if(e is DioError && e.error is UnAuthorizedException){
          if(await DialogHelper.showLoginDialog(context)){
            Navigator.pushNamed(context, RouteName.login);
          };
        }else
          throw e;
      });
      return res;
  }

  // desc 首页 每日话题
  static Future fetchNiceTopics() async{
    var response = await http.get('/public/topic/nice');
    return response.data.map<Topic>((item) => Topic.fromJson(item)).toList();
  }

  // desc 首页 每日热门动态
  static Future fetchPopularCircle() async{
    var response = await http.get('/public/circle/popular');
    return response.data.map<Article>((item) => Article.fromJson(item)).toList();
  }

}