import 'dart:convert';
import 'dart:typed_data';

import 'package:bot_toast/bot_toast.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app2/pages/wights/LittleWidgets.dart';
import 'package:flutter_app2/pages/wights/page_route_anim.dart';
import 'package:flutter_app2/pages/wights/show_image.dart';
import 'package:flutter_app2/services/model/Article.dart';
import 'package:flutter_app2/services/model/viewModel/comment_model.dart';
import 'package:flutter_app2/services/net/restful_go.dart';
import 'package:flutter_app2/services/provider/provider_widget.dart';
import 'package:flutter_app2/services/provider/view_state_widget.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_native_html_view/flutter_native_html_view.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:oktoast/oktoast.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

/**
 * @createDate  2020/5/9
 */
class ArticleShowPage extends StatefulWidget {

  var articleId;
  Article article;
  ArticleShowPage(this.articleId);

  @override
  _State createState() => _State(articleId: articleId);

}

class _State extends State<ArticleShowPage>  with SingleTickerProviderStateMixin {

  var articleId;
  Article article;
  _State({this.articleId});

  @override
  void initState() {
    super.initState();
    loadArticle();
  }

  loadArticle(){
    if(article==null){
      BotToast.showLoading();
      RestfulApi.fetchArticle(articleId).then((article){
        this.article = article;
        BotToast.closeAllLoading();
        setState((){});
      }).catchError((onError){
        BotToast.closeAllLoading();
        showToast("网络错误");
        setState(() {});
      });
    }
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return
    WillPopScope(
      onWillPop: (){BotToast.closeAllLoading(); Navigator.pop(context); return;},
      child: Scaffold(
        appBar: AppBar(
          title: Text("${article?.title??"文章详情"}"),
          centerTitle: true,
        ),
        body: article==null?
        ViewStateEmptyWidget(onPressed: () {loadArticle();},):
        ProviderWidget<CommentListModel>(
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
                    child:
                    html(article.content),
                  ),
                  SliverToBoxAdapter(
                    child: Divider(height: 2,color: Colors.grey,),
                  ),
                  if(commentListModel.list.isEmpty)
                    SliverToBoxAdapter(
                      child: Container()
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
      ),
    );

  }

  var testHtml = """
       <p>视频测试<video controls="" src="http://poss.videocloud.cns.com.cn/oss/2020/05/13/chinanews/MEIZI_YUNSHI/onair/FAC5D02EBF564D76AAF968013612016C.mp4"  width="400" class="note-video-clip"></video></p>
       """;

  Widget html2(String str){
    if(str!=null){
      str = str.replaceAll("<video ", "<video width='400' ");
      str = str.replaceAll("<img ", "<img width='400' ");
    }
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
