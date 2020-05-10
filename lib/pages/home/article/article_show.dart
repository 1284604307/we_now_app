import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app2/pages/home/article/HomeItemPage.dart';
import 'package:flutter_app2/pages/home/circle/circle_show.dart';
import 'package:flutter_app2/pages/home/circle/comment_page.dart';
import 'package:flutter_html/flutter_html.dart';

/**
 * @createDate  2020/5/9
 */
class ArticleShowPage extends StatefulWidget {

  @override
  _State createState() => _State();

}

class _State extends State<ArticleShowPage>  with SingleTickerProviderStateMixin {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: HomeItemPage(),
    );

  }


}


class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage>{

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: HomeItemPage(),
    );
  }
}