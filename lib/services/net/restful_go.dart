import 'dart:convert';
import 'dart:io';
import 'package:bot_toast/bot_toast.dart';
import 'package:flutter_app2/common/pojos/User.dart';
import 'package:flutter_app2/services/config/router_manger.dart';
import 'package:flutter_app2/services/helper/dialog_helper.dart';
import 'package:flutter_app2/services/model/Article.dart';
import 'package:flutter_app2/services/model/Banner.dart';
import 'package:flutter_app2/services/model/Comment.dart';
import 'package:flutter_app2/services/model/Topic.dart';
import 'package:flutter_app2/services/net/api.dart';
import 'package:http_parser/http_parser.dart';
import 'package:flutter/cupertino.dart' show Navigator;

import 'real_api.dart';

/**
 * @createDate  2020/4/25
 */


class RestfulApi {

  //desc 登录
  static Future login(String username, String password) async {
    var ticket = await http.post('/login', queryParameters: {
      'username': username,
      'password': password,
      'rememberMe': true
    });
    print("登陆成功");
    print(ticket.toString());
    http.options.headers['ticket'] = ticket.toString();
    http.options.headers['username'] = username;
    User user = await getInfo();
    user.ticket = ticket.toString();
    return user;
  }

  static Future loginByQQ(String openid, String access_token) async {
    var ticket = await http.post('/login/qq', queryParameters: {
      'openid': openid,
      'access_token': access_token,
    });
    print("登陆成功");
    print(ticket.toString());
    User user = await getInfo();
    http.options.headers['ticket'] = ticket.toString();
    http.options.headers['username'] = user.loginName;
    user.ticket = ticket.toString();
    return user;
  }

  putHeader(String name,String value){
    http.options.headers[name] = value;
  }

  delHeader(String name){http.options.headers.remove(name);}

  static Future getInfo() async{
    var response = await http.get("/user");
    return User.fromJson(response.data);
  }

  static Future logout() async{
    http.options.headers.remove("ticket");
    http.options.headers.remove("username");
    return http.get("/logout");
  }

  static Future uploadImages(FormData data) async{
    await Future.delayed(Duration(seconds: 1)); //增加动效
    var response =  await http.post("/user/upload/files", data: data);
    return List<String>.from(response.data);
  }

  static Future postNewCircle(data)async{
    var res = await http.post("/public/circle/", data: json.encode(data));

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

  // desc 推荐文章
  static Future fetchRecommendCircles(pageNum) async{
    var response = await http.get('/public/circle/hots/$pageNum');
    return response.data.map<Article>((item) => Article.fromJson(item)).toList();
  }

  // desc 学校文章
  static Future fetchSchoolCircles(pageNum) async{
    var response = await http.get('/public/circle/school/$pageNum');
    return response.data.map<Article>((item) => Article.fromJson(item)).toList();
  }

  // desc 话题下文章
  static Future fetchTopicCircles(topicId,{pageNum=0}) async{
    var response = await http.get('/public/circle/topic/$topicId/$pageNum');
    return response.data.map<Article>((item) => Article.fromJson(item)).toList();
  }

  // desc 动态的评论
  static Future fetchArticleComment(articleId,{pageNum=0}) async{
    var response = await http.get('/public/circle/comments/$articleId/$pageNum');
    return response.data.map<Comment>((item) => Comment.fromJson(item)).toList();
  }

  // desc 评论的子评论
  static Future fetchChildrenComment(commentId,{pageNum=0}) async{
    var response = await http.get('/public/circle/commentChildren/$commentId/$pageNum');
    return response.data.map<Comment>((item) => Comment.fromJson(item)).toList();
  }

  // desc 指定文章
  static Future fetchArticle(articleId) async{
    var response = await http.get('/public/circle/info/$articleId');
    return Article.fromJson(response.data);
  }

  // desc 话题下置顶文章
  static Future fetchTopicTopCircles(topicId) async {
    var response = await http.get('/public/circle/topic/top/$topicId');
    return response.data.map<Article>((item) => Article.fromJson(item)).toList();
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

  // desc 话题详情
  static Future fetchTopic(topicId) async{
    var response = await http.get('/public/topic/info/$topicId');
    return Topic.fromJson(response.data);
  }


  static register(loginName, password) async {
    await http.post('/user/register', queryParameters: {
      'username': loginName,
      'password': password,
    });
    BotToast.showText(text: "注册成功");
  }

  static updateAvatar(File f) async {
    print(f);
    FormData data = new FormData();
    MultipartFile multipartFile = await MultipartFile.fromBytes(
      await f.readAsBytesSync(),
      filename: "avatar.png",
      contentType: MediaType("image", "png"),
    );
    data.files.add(MapEntry("avatarfile", multipartFile));
    var response =  await http.post("/user/updateAvatar", data: data);
    print(response);
  }

  // desc 获取话题标签
  static fetchTopics(topic) async {
    if(topic!=""){
      return [
        Topic.fromJson({"url":"","topic":"搜索神器","visible":22}),
        Topic.fromJson({"url":"https://www.duifene.com/theme/img/module.icon.PNG?ljw=201702","topic":"厉害了","visible":67}),
      ];
    }else
      return [
        Topic.fromJson({"url":"https://www.duifene.com/theme/img/module.icon.PNG?ljw=201702","topic":"嘻嘻嘻","visible":22}),
        Topic.fromJson({"url":"https://www.duifene.com/theme/img/module.icon.PNG?ljw=201702","topic":"厉害了","visible":67}),
        Topic.fromJson({"url":"https://www.duifene.com/theme/img/module.icon.PNG?ljw=201702","topic":"痒局长","visible":45}),
        Topic.fromJson({"url":"https://www.duifene.com/theme/img/module.icon.PNG?ljw=201702","topic":"我的天哪","visible":24}),
      ];
  }

}