import 'dart:convert';
import 'dart:typed_data';

import 'package:extended_image/extended_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app2/pages/wights/LittleWidgets.dart';
import 'package:flutter_app2/pages/wights/page_route_anim.dart';
import 'package:flutter_app2/pages/wights/show_image.dart';
import 'package:flutter_app2/services/model/Article.dart';
import 'package:flutter_app2/services/model/viewModel/comment_model.dart';
import 'package:flutter_app2/services/provider/provider_widget.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_native_html_view/flutter_native_html_view.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:oktoast/oktoast.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

/**
 * @createDate  2020/5/9
 */
class ArticleShowPage extends StatefulWidget {

//  var articleId;
  Article article;
  ArticleShowPage(this.article);

  @override
  _State createState() => _State(article);

}

class _State extends State<ArticleShowPage>  with SingleTickerProviderStateMixin {

//  var articleId;
  Article article;
  _State(this.article);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("${article.title}"),
        centerTitle: true,
      ),
      body: ProviderWidget<CommentListModel>(
        onModelReady: (m){m.initData();},
        builder: (BuildContext context, CommentListModel commentListModel, Widget child) {
          return SmartRefresher(
            controller: commentListModel.refreshController,
            enablePullDown: false,
            enablePullUp: commentListModel.list.isNotEmpty,
            onLoading: (){ commentListModel.loadMore(); },
            onRefresh: (){ commentListModel.refresh(); },
            child: CustomScrollView(
              slivers: <Widget>[
                SliverToBoxAdapter(
                  child: html(article.content),
                ),
                SliverToBoxAdapter(
                  child: Divider(height: 2,color: Colors.grey,),
                ),
                SliverList(
                  delegate: SliverChildBuilderDelegate(
                        (BuildContext c, int i) {
                      return FirstChildComment(commentListModel.list[i]);
                    },
                    childCount: commentListModel.list.length,
                  ),
                ),
              ],
            ),
          );
        }, model: CommentListModel(article.id),
      ),
    );

  }

  var testHtml = """
       <section data-role="outer" label="Powered by 135editor.com" style="font-size:16px;"><section data-tplid="97680" data-tools="135编辑器"><section class="_135editor"><section style="padding: 1em;"><section style="display: flex;justify-content:center;align-items: center;"><section style="width: 50%;z-index:9;" data-width="50%"><section style=";transform: rotate(-8deg);-webkit-transform: rotate(-8deg);-moz-transform: rotate(-8deg);-ms-transform: rotate(-8deg);-o-transform: rotate(-8deg);"><section style="padding: 15px 6px 20px; background-image: initial; background-position: initial; background-size: initial; background-repeat: initial; background-attachment: initial; background-origin: initial; background-clip: initial; box-shadow: rgb(231, 231, 231) 0px 0px 6px;"><img style="width: 100%;display: block;" src="https://image2.135editor.com/cache/remote/aHR0cHM6Ly9tbWJpei5xbG9nby5jbi9tbWJpel9wbmcvN1FSVHZrSzJxQzdiVWtOT3k5YTRIMUg2Zld5WU16alRndVVHd21RWGliZ05GZE1Gck9vbHFqdkNxcUdacjVySTlTcldmSFhZRElpYW9DWThjcEpkbE1Pdy8w" data-ratio="1.1868852459016392" data-width="100%" data-w="305"></section></section></section><section style="width: 50%;" data-width="50%"><section style="margin-top: 1em;transform: rotate(8deg);-webkit-transform: rotate(8deg);-moz-transform: rotate(8deg);-ms-transform: rotate(8deg);-o-transform: rotate(8deg);"><section style="padding: 0px 6px 20px; background-image: initial; background-position: initial; background-size: initial; background-repeat: initial; background-attachment: initial; background-origin: initial; background-clip: initial; box-shadow: rgb(231, 231, 231) 0px 0px 6px;"><section style="text-align: right;"><section style="width: 12px;display: inline-block;"><img class="assistant" style="width: 100%;display: block;" src="https://image2.135editor.com/cache/remote/aHR0cHM6Ly9tbWJpei5xbG9nby5jbi9tbWJpel9wbmcvN1FSVHZrSzJxQzdiVWtOT3k5YTRIMUg2Zld5WU16alRiaDdaeW5uUFBYWTNGTnY0cFBleGljU0djaGtDV2VFeGMyYlV1MGFzekxwYXc5a1pVRGliQnBDZy8w" data-ratio="0.7941176470588235" data-width="100%" data-w="34"></section></section><img style="width: 100%;display: block;" src="https://image2.135editor.com/cache/remote/aHR0cHM6Ly9tbWJpei5xbG9nby5jbi9tbWJpel9wbmcvN1FSVHZrSzJxQzdiVWtOT3k5YTRIMUg2Zld5WU16alRndVVHd21RWGliZ05GZE1Gck9vbHFqdkNxcUdacjVySTlTcldmSFhZRElpYW9DWThjcEpkbE1Pdy8w" data-ratio="1.1868852459016392" data-width="100%" data-w="305"></section></section></section></section></section></section><section class="_135editor"><p style="text-align:center;" align="center"><span style="color: #666;">疫情之后，那些值得坚持的好习惯。</span></p><p style="text-align:center;" align="center"><br></p></section><section class="_135editor" data-tools="135编辑器" data-id="87573"><section style="text-align:center;margin:10px auto;" class=""><section style="display:inline-block;width:32px;"><img data-id="87573" data-markdown="---" style="max-width:100%;width:32px;" title="动图跳跃分割线" src="https://mpt.135editor.com/mmbiz/cZV2hRpuAPhrxQU1opLkENnCB9ArIxUwbOc4icRtGpx6C1xf01C5xxexzoXnzLeoibpDhJibqHicpLhiaplAnKTXq7A/0?wx_fmt=gif" data-ratio="1" data-w="256" class="_135editor"></section></section></section><section class="_135editor"><section style="margin: 10px auto;text-align: center;" class=""><section style="letter-spacing: 5px; line-height: 1.8; font-size: 18px; color: rgb(205, 246, 252); text-shadow: rgb(153, 82, 207) 1px 1px, rgb(153, 82, 207) 1px -1px, rgb(153, 82, 207) -1px 1px, rgb(153, 82, 207) -1px -1px, rgb(153, 82, 207) 0px 1.4px, rgb(153, 82, 207) 0px -1.4px, rgb(153, 82, 207) -1.4px 0px, rgb(153, 82, 207) 1.4px 0px, rgb(254, 157, 154) 2px 2px, rgb(254, 157, 154) 3px 3px, rgb(254, 157, 154) 3px 1px, rgb(254, 157, 154) 1px 3px, rgb(254, 157, 154) 1px 1px, rgb(254, 157, 154) 2px 3.4px, rgb(254, 157, 154) 2px 0.6px, rgb(254, 157, 154) 0.6px 2px, rgb(254, 157, 154) 3.4px 2px;" class=""><p><strong><em class="135brush" data-brushtype="text" style="padding: 0px 15px; text-align: right;">早睡早起不熬夜</em></strong></p></section><section class="assistant" style="overflow:hidden;height:2px;background:#fe9d9a;width:60%;margin:0px auto;" data-width="60%"></section><section class="assistant" style="overflow:hidden;height:4px;background:#fe9d9a;width:40%;margin:3px auto;" data-width="40%"></section><span style="caret-color: red;"></span></section></section><section class="_135editor"><section style="width: 90%; margin-left: 5%; margin-bottom: 10px; padding: 5px 0px; font-size: 14px; letter-spacing: 1.5px; line-height: 2em; color: rgb(63, 63, 63);" class="135brush" data-width="90%"><p><br></p><p><span style="caret-color: red; color: #666;">熬夜对人的身体的伤害最大。长期睡眠不足，会导致免疫系统的崩溃，随之而来的就是我们的精神状态，工作效率也都会受到很大的影响。</span></p><span style="color: #666;">为了自己的身体健康，一定要按时睡觉，拒绝熬夜。每天早睡早起，才能用最饱满的精神迎接每一天。</span><p><br></p><section style="width: 100%; margin: 10px 0px; border-bottom: 10px solid rgb(178, 220, 241);" data-width="100%"><section style="width: 100%;display:flex;justify-content: center;align-items: flex-end;" data-width="100%"><section style="width: 100%;display:flex;justify-content: center;" data-width="100%"><section style="width: 10px; background: #b2dcf1; margin-top: 1em; color: #19658b;"><section style="margin-top: -4px; height: 4px; width: 0px; border-top: 4px solid transparent; border-left: 10px solid rgb(178, 220, 241); border-bottom: 0px solid transparent; border-right-color: rgb(178, 220, 241); overflow: hidden;"></section></section><section style="width: 100%;line-height:0;" data-width="100%"><img style="width: 100%;display: block;" src="https://image2.135editor.com/cache/remote/aHR0cHM6Ly9tbWJpei5xbG9nby5jbi9tbWJpel9wbmcvN1FSVHZrSzJxQzZZTHdNSExhNEVVc3VHc2dQbWZWd0hTY2ZqUXk5RDdVTmNXSDF6aWFvNldaTmtKeUVZb3RFNER0U0Q1clJHajRWQmZjRGljV1JISzRqUS8wP3d4X2ZtdD1wbmc=" data-width="100%" data-ratio="0.7516025641025641" data-w="624"></section></section><section><section style="height: 4px; width: 0px; border-top: 4px solid transparent; border-left: 10px solid rgb(178, 220, 241); border-bottom: 0px solid transparent; overflow: hidden;"></section><section style="width: 10px; height: 7em; background: #b2dcf1; color: #19658b;" class=""><br></section></section></section></section></section></section><section class="_135editor"><section style="margin: 10px auto;text-align: center;"><section style="letter-spacing: 5px; line-height: 1.8; font-size: 18px; color: rgb(205, 246, 252); text-shadow: rgb(153, 82, 207) 1px 1px, rgb(153, 82, 207) 1px -1px, rgb(153, 82, 207) -1px 1px, rgb(153, 82, 207) -1px -1px, rgb(153, 82, 207) 0px 1.4px, rgb(153, 82, 207) 0px -1.4px, rgb(153, 82, 207) -1.4px 0px, rgb(153, 82, 207) 1.4px 0px, rgb(254, 157, 154) 2px 2px, rgb(254, 157, 154) 3px 3px, rgb(254, 157, 154) 3px 1px, rgb(254, 157, 154) 1px 3px, rgb(254, 157, 154) 1px 1px, rgb(254, 157, 154) 2px 3.4px, rgb(254, 157, 154) 2px 0.6px, rgb(254, 157, 154) 0.6px 2px, rgb(254, 157, 154) 3.4px 2px;"><p><br></p><p><strong><em class="135brush" data-brushtype="text" style="padding: 0px 15px; text-align: right;">按时吃饭饮食规律</em></strong></p></section><section class="assistant" style="overflow:hidden;height:2px;background:#fe9d9a;width:60%;margin:0px auto;" data-width="60%"></section><section class="assistant" style="overflow:hidden;height:4px;background:#fe9d9a;width:40%;margin:3px auto;" data-width="40%"></section></section></section><section class="_135editor" style="border: 0px none;"><section style="width: 90%; margin-left: 5%; margin-bottom: 10px; padding: 5px 0px; font-size: 14px; letter-spacing: 1.5px; line-height: 2em; color: rgb(63, 63, 63);" class="135brush" data-width="90%"><p><br></p><p><span style="color: #666;">平时吃饭要注意清淡饮食，荤素合理搭配。千万不要大鱼大肉胡吃海喝，或是饥一顿饱一顿。</span></p><p><span style="color: #666;">饮食不规律会直接导致胃部出现各种问题，到时候受罪的可是自己。</span></p><p><span style="color: #666;">无论此时心情多么糟糕，都一定要按时吃饭，特殊时期也要注意身体，吃得好身体才会更健康。</span></p><p><br></p><section style="width: 100%; margin: 10px 0px; border-bottom: 10px solid rgb(178, 220, 241);" data-width="100%"><section style="width: 100%;display:flex;justify-content: center;align-items: flex-end;" data-width="100%" class=""><section style="width: 100%;display:flex;justify-content: center;" data-width="100%"><section style="width: 10px; background: #b2dcf1; margin-top: 1em; color: #19658b;"><section style="margin-top: -4px; height: 4px; width: 0px; border-top: 4px solid transparent; border-left: 10px solid rgb(178, 220, 241); border-bottom: 0px solid transparent; border-right-color: rgb(178, 220, 241); overflow: hidden;"></section></section><section style="width: 100%;line-height:0;" data-width="100%" class=""><img style="width: 100%;display: block;" src="https://image2.135editor.com/cache/remote/aHR0cHM6Ly9tbWJpei5xbG9nby5jbi9tbWJpel9wbmcvN1FSVHZrSzJxQzZZTHdNSExhNEVVc3VHc2dQbWZWd0hTY2ZqUXk5RDdVTmNXSDF6aWFvNldaTmtKeUVZb3RFNER0U0Q1clJHajRWQmZjRGljV1JISzRqUS8wP3d4X2ZtdD1wbmc=" data-width="100%" data-ratio="0.7512562814070352" data-w="624" data-op="change"></section></section><section><section style="height: 4px; width: 0px; border-top: 4px solid transparent; border-left: 10px solid rgb(178, 220, 241); border-bottom: 0px solid transparent; overflow: hidden;"><img data-id="87571" data-markdown="---" title="彩色晃动小球分割线" src="https://mpt.135editor.com/mmbiz/cZV2hRpuAPhrxQU1opLkENnCB9ArIxUw7iao06fuyovMh68Cib2KVC1y83TVHSibSPx5hF4uLcMEIUseTSeibIRW0A/0?wx_fmt=gif" style="text-align: center; color: #cdf6fc; font-size: 18px; letter-spacing: 5px; caret-color: red; width: 32px;" data-w="256" data-ratio="1" class="_135editor"><br></section></section></section></section></section></section><section class="_135editor"><section style="margin: 10px auto;text-align: center;"><section style="letter-spacing: 5px; line-height: 1.8; font-size: 18px; color: rgb(205, 246, 252); text-shadow: rgb(153, 82, 207) 1px 1px, rgb(153, 82, 207) 1px -1px, rgb(153, 82, 207) -1px 1px, rgb(153, 82, 207) -1px -1px, rgb(153, 82, 207) 0px 1.4px, rgb(153, 82, 207) 0px -1.4px, rgb(153, 82, 207) -1.4px 0px, rgb(153, 82, 207) 1.4px 0px, rgb(254, 157, 154) 2px 2px, rgb(254, 157, 154) 3px 3px, rgb(254, 157, 154) 3px 1px, rgb(254, 157, 154) 1px 3px, rgb(254, 157, 154) 1px 1px, rgb(254, 157, 154) 2px 3.4px, rgb(254, 157, 154) 2px 0.6px, rgb(254, 157, 154) 0.6px 2px, rgb(254, 157, 154) 3.4px 2px;"><p><br></p><p><strong><em class="135brush" data-brushtype="text" style="padding: 0px 15px; text-align: right;">多开窗通风勤洗手</em></strong></p></section><section class="assistant" style="overflow:hidden;height:2px;background:#fe9d9a;width:60%;margin:0px auto;" data-width="60%"></section><section class="assistant" style="overflow:hidden;height:4px;background:#fe9d9a;width:40%;margin:3px auto;" data-width="40%"></section><span style="caret-color: red;"></span></section></section><section class="_135editor" style="border: 0px none;"><section style="width: 90%; margin-left: 5%; margin-bottom: 10px; padding: 5px 0px; font-size: 14px; letter-spacing: 1.5px; line-height: 2em; color: rgb(63, 63, 63);" class="135brush" data-width="90%"><p><br></p><p><span style="color: #666;">每天在家开窗15分钟，呼吸新鲜空气，天气好的时候可以在阳台多晒晒太阳。</span></p><p><span style="color: #666;">为了自己和家人，要特别注意个人卫生，勤洗手，特别是外出回家后，一定要用肥皂多清洗几遍。</span></p><p><br></p><section style="width: 100%; margin: 10px 0px; border-bottom: 10px solid rgb(178, 220, 241);" data-width="100%"><section style="width: 100%;display:flex;justify-content: center;align-items: flex-end;" data-width="100%" class=""><section style="width: 100%;display:flex;justify-content: center;" data-width="100%"><section style="width: 10px; background: #b2dcf1; margin-top: 1em; color: #19658b;"><section style="margin-top: -4px; height: 4px; width: 0px; border-top: 4px solid transparent; border-left: 10px solid rgb(178, 220, 241); border-bottom: 0px solid transparent; border-right-color: rgb(178, 220, 241); overflow: hidden;"></section></section><section style="width: 100%;line-height:0;" data-width="100%" class=""><img style="width: 100%;display: block;" src="https://image2.135editor.com/cache/remote/aHR0cHM6Ly9tbWJpei5xbG9nby5jbi9tbWJpel9wbmcvN1FSVHZrSzJxQzZZTHdNSExhNEVVc3VHc2dQbWZWd0hTY2ZqUXk5RDdVTmNXSDF6aWFvNldaTmtKeUVZb3RFNER0U0Q1clJHajRWQmZjRGljV1JISzRqUS8wP3d4X2ZtdD1wbmc=" data-width="100%" data-ratio="0.7516025641025641" data-w="624"></section></section><section><section style="height: 4px; width: 0px; border-top: 4px solid transparent; border-left: 10px solid rgb(178, 220, 241); border-bottom: 0px solid transparent; overflow: hidden;"></section><section style="width: 10px; height: 7em; background: #b2dcf1; color: #19658b; overflow: hidden;"></section></section></section></section></section></section><section class="_135editor"><section style="margin: 10px auto;text-align: center;" class=""><section style="letter-spacing: 5px; line-height: 1.8; font-size: 18px; color: rgb(205, 246, 252); text-shadow: rgb(153, 82, 207) 1px 1px, rgb(153, 82, 207) 1px -1px, rgb(153, 82, 207) -1px 1px, rgb(153, 82, 207) -1px -1px, rgb(153, 82, 207) 0px 1.4px, rgb(153, 82, 207) 0px -1.4px, rgb(153, 82, 207) -1.4px 0px, rgb(153, 82, 207) 1.4px 0px, rgb(254, 157, 154) 2px 2px, rgb(254, 157, 154) 3px 3px, rgb(254, 157, 154) 3px 1px, rgb(254, 157, 154) 1px 3px, rgb(254, 157, 154) 1px 1px, rgb(254, 157, 154) 2px 3.4px, rgb(254, 157, 154) 2px 0.6px, rgb(254, 157, 154) 0.6px 2px, rgb(254, 157, 154) 3.4px 2px;" class=""><section style="margin: 10px auto;" class=""><section style="display: inline-block; width: 32px; height: 0px; overflow: hidden;"></section></section><p><strong><em>积极乐观不生闷气</em></strong></p></section><section class="assistant" style="overflow:hidden;height:2px;background:#fe9d9a;width:60%;margin:0px auto;" data-width="60%"></section><section class="assistant" style="overflow:hidden;height:4px;background:#fe9d9a;width:40%;margin:3px auto;" data-width="40%"></section><span style="caret-color: red;"></span></section></section><section class="_135editor" style="border: 0px none;"><section style="width: 90%; margin-left: 5%; margin-bottom: 10px; padding: 5px 0px; font-size: 14px; letter-spacing: 1.5px; line-height: 2em; color: rgb(63, 63, 63);" class="135brush" data-width="90%"><p><br></p><p><span style="color: #666;">心态决定一切。心态好，身体才能好。</span></p><p><span style="color: #666;">生活中不要再因为一些鸡毛蒜皮的小事争吵谩骂，一个人经常生闷气，会对身体带来很大的危害。</span></p><p><span style="color: #666;">把心放大一点，学会放下，学会看开，积极乐观面对现实，要相信一切都会过去。</span></p><p><br></p><section style="width: 100%; padding-bottom: 15px;" data-width="100%"><section style="width: 100%;display:flex;justify-content: center;align-items: flex-end;" data-width="100%" class=""><section style="width: 100%;display:flex;justify-content: center;align-items: center;" data-width="100%"><section style="width: 10px; height: 7em; background: #d3f9fa; margin-top: 1em; overflow: hidden;"></section><section style="width: 100%;" data-width="100%" class=""><img style="display: block; margin: 0px; width: 100%;" src="https://image2.135editor.com/cache/remote/aHR0cHM6Ly9tbWJpei5xbG9nby5jbi9tbWJpel9wbmcvN1FSVHZrSzJxQzZZTHdNSExhNEVVc3VHc2dQbWZWd0hTY2ZqUXk5RDdVTmNXSDF6aWFvNldaTmtKeUVZb3RFNER0U0Q1clJHajRWQmZjRGljV1JISzRqUS8wP3d4X2ZtdD1wbmc=" data-width="100%" data-ratio="0.7516025641025641" data-op="change" width="100%" height="" border="0" mapurl="" title="" alt="" data-w="624"></section></section><section><section style="width: 10px; height: 8em; border-top: 1px solid rgb(211, 211, 211); border-right: 1px solid rgb(211, 211, 211); border-left: 1px solid rgb(211, 211, 211); border-image: initial; border-bottom: none; overflow: hidden;"></section></section></section><section style="width: 70%; height: 10px; border-right: 1px solid rgb(211, 211, 211); border-bottom: 1px solid rgb(211, 211, 211); border-left: 1px solid rgb(211, 211, 211); border-image: initial; border-top: none; float: right; overflow: hidden;" data-width="70%"></section></section></section><p><br></p></section><section class="_135editor"><section style="border: 0px none; margin: 0px auto; width: 100%; flex: 0 0 100%;" data-width="100%"><section style="width: 90%; margin-left: 5%; margin-bottom: 10px; padding: 5px 0px; font-size: 14px; letter-spacing: 1.5px; line-height: 2em; color: rgb(63, 63, 63);" class="135brush" data-width="90%"><section><section style="text-align:center;margin:10px auto;" class=""><p style="display:inline-block;width:32px;"><img data-id="87573" data-markdown="---" style="max-width:100%;width:32px;" src="https://mpt.135editor.com/mmbiz/cZV2hRpuAPhrxQU1opLkENnCB9ArIxUwbOc4icRtGpx6C1xf01C5xxexzoXnzLeoibpDhJibqHicpLhiaplAnKTXq7A/0?wx_fmt=gif" data-ratio="1" data-w="256" class="_135editor"></p></section><section style="text-align:center;margin:10px auto;"><p style="display:inline-block;width:32px;"><br></p></section></section><p><span style="color: #666;">这几个好习惯，你能坚持做到几个呢？</span></p><p><span style="color: #666;">记住，你现在要做的是：把身体照顾好。饮食清淡、按时睡觉、放松心情、多做运动、读书听音乐看电影。</span></p></section></section></section><section class="_135editor"><section style="text-align:center;margin:10px auto;"><p style="display:inline-block;width:32px;"><br></p></section><section style="text-align:center;margin:10px auto;"><p style="display:inline-block;width:32px;"><br></p></section><section style="text-align:center;margin:10px auto;"><p style="display:inline-block;width:32px;"><img data-id="87573" data-markdown="---" style="max-width:100%;width:32px;" title="动图跳跃分割线" src="https://mpt.135editor.com/mmbiz/cZV2hRpuAPhrxQU1opLkENnCB9ArIxUwbOc4icRtGpx6C1xf01C5xxexzoXnzLeoibpDhJibqHicpLhiaplAnKTXq7A/0?wx_fmt=gif" data-ratio="1" data-w="256" class="_135editor"></p></section></section><section class="_135editor"><p style="text-align:center;" align="center">
						END</p></section><section class="_135editor"><p><br></p><p style="text-align:center;" align="center"><span style="font-size: 14px; text-decoration-style: solid; text-decoration-color: rgb(63, 63, 63); color: rgb(102, 102, 102); font-family: 微软雅黑, &quot;Microsoft YaHei&quot;, Arial, sans-serif;">排版：135编辑器</span></p><p style="text-align:center;" align="center"><span style="font-size: 14px; text-decoration-style: solid; text-decoration-color: rgb(63, 63, 63); color: rgb(102, 102, 102); font-family: 微软雅黑, &quot;Microsoft YaHei&quot;, Arial, sans-serif;">文案：网络（侵删）</span></p><p style="text-align:center;" align="center"><span style="font-size: 14px; text-decoration-style: solid; text-decoration-color: rgb(63, 63, 63); color: rgb(102, 102, 102); font-family: 微软雅黑, &quot;Microsoft YaHei&quot;, Arial, sans-serif;">图片：不可商用</span></p></section><p><br></p><section class="_135editor"><section style="margin: 0px auto; width: 90%; flex: 0 0 90%;"><section style="width:100%;margin:10px auto 15px;" data-width="100%"><section style="text-align:right;margin-right:6px;" class=""><section style="display: inline-block; width: 10px; height: 10px; background: #cdf6fc; overflow: hidden;transform: rotate(0deg);-webkit-transform: rotate(0deg);-moz-transform: rotate(0deg);-ms-transform: rotate(0deg);-o-transform: rotate(0deg);"></section></section><section style="width:100%;margin-top:-10px;" data-width="100%"><section data-bgless="spin" data-bglessp="60" style="margin-left:10px;border: 1px solid #7794bf;padding-bottom:10px;background:url(https://image2.135editor.com/cache/remote/aHR0cHM6Ly9tbWJpei5xbG9nby5jbi9tbWJpel9wbmcvN1FSVHZrSzJxQzU3ZGlhek14SkdldjBXQmNZMG1YMXV0YTM4Y0hGbldLOUNIYlJySEpCNVYzT1JkdWxqSE91Ukd3d3ZUenRkVVFseFQzaktMTjZualJnLzA/d3hfZm10PXBuZw==);background-repeat:repeat ;background-position:center ;background-size:100% ;"><section style="border: 1px solid rgb(119, 148, 191); background-color: rgb(254, 254, 254); margin-left: -10px; margin-top: -10px; margin-right: 10px; overflow: hidden; padding: 0.7em 0.5em;" class=""><section style="display:flex;justify-content: center;align-items: center;" class=""><section style="width: 50%;" data-width="50%" class=""><section class="135brush" data-brushtype="text" style="border-radius:20px ;background:#cdf6fc;color:#fff;font-size:14px;padding:2px 0.2em;text-align:center;display:inline-block;"><span style="color: #01181c;">www.135editor.com</span></section><section class="135brush" data-brushtype="text" style="color: rgb(205, 246, 252); font-weight: bold; margin-top: 4px;"><span style="color: #01181c;">关注135编辑器</span></section><section class="135brush" data-brushtype="text" style="color: rgb(205, 246, 252); font-weight: bold; margin-top: 4px;"><span style="color: #01181c;">掌握最新样式更新</span></section><section class="135brush" data-brushtype="text" style="color: rgb(205, 246, 252); font-size: 12px; margin-top: 4px;"><span style="color: #01181c;">长按二维码扫码关注&gt;&gt;&gt;</span></section></section><section><section style="width: 100px; margin-left: 10px; border: 1px solid rgb(205, 246, 252);"><section style="border: 5px solid rgb(253, 242, 242);" class=""><img style="width:100%;display:block;" src="https://image2.135editor.com/cache/remote/aHR0cHM6Ly9tbWJpei5xbG9nby5jbi9tbWJpel9wbmcvN1FSVHZrSzJxQzYwUzlpYzVFaWJWVmVhQWg0dTZxS2NVZ2liYzZhQ25XTkppY2VDR045RDk2dExhaWJyV3lZeWljeXR4c0pMNmZPOElIcFZkZmpySVloNUk5YVEvMD93eF9mbXQ9cG5n" data-ratio="1" data-width="100%" data-w="142"></section></section></section></section></section></section></section><section style="width: 10px; height: 10px; background: #cdf6fc; margin-left: 6px; margin-top: -16px; overflow: hidden;transform: rotate(0deg);-webkit-transform: rotate(0deg);-moz-transform: rotate(0deg);-ms-transform: rotate(0deg);-o-transform: rotate(0deg);"></section></section></section></section><p><br></p><p><br></p></section><section class="_135editor" data-role="paragraph"><p><br></p></section></section>         
        """;

  Widget html2(String str){
    return Container(
      height: 400,
      child: FlutterNativeHtmlView(
        htmlData: str??testHtml,
        onLinkTap: (String url) {
          print(url);
        },
        onError: (String message) {
          print(message);
        },
      ),
    );
  }

  Widget html3(String str){
    return  HtmlWidget(
      str??testHtml,
      webView: true,
    );
  }

  Widget html(String str){
    return Html(
      data: str??testHtml,
      //Optional parameters:
      padding: EdgeInsets.all(8.0),
      defaultTextStyle: TextStyle(fontFamily: 'serif'),
      linkStyle: const TextStyle(
        color: Colors.redAccent,
      ),
      onLinkTap: (url) {
        // open url in a webview
      },
      customRender: (node, children) {

      },
      onImageTap: (img){
        List imgList = img.split(',');
        if(imgList.length==2){
          Navigator.push(context, NoAnimRouteBuilder(ShowImagePage(extendedImage: ExtendedImage.memory(
            base64.decode(img.split(',')[1]), //设置宽度
            mode: ExtendedImageMode.gesture ,
          )
          ),));
        }else{
         showToast(img);
         print(img);
          Navigator.push(context, NoAnimRouteBuilder(ShowImagePage(extendedImage: ExtendedImage.network(
            img, //设置宽度
            mode: ExtendedImageMode.gesture ,
          )),));
        }
      },
    );
  }

}
