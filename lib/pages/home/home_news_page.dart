import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app2/services/model/news.dart';

import 'index/news_detail_page.dart';

/**
 * @author Ming
 * @date 2020/4/18
 * @email 1284604307@qq.com
 */
class HomeNewsPage extends StatelessWidget{

  final NewsListModal list;

  const HomeNewsPage({Key key, this.list}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    double deviceWidth = MediaQuery.of(context).size.width;

    // TODO: implement build
    return Container(
      margin: EdgeInsets.all(5),
      color: Colors.white,
      child: _build(context,deviceWidth),
    );
  }

  Widget _build(BuildContext context, double deviceWidth) {
    double itemWidth = deviceWidth;
    List<Widget> listWidgets = list.data.map((i){
      return
        GestureDetector(
          onTap: (){
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context)=>NewsDetailPage(item: i))
            );
          },
          child : Container(
            constraints: BoxConstraints(
              minHeight: 100,
            ),
            width: itemWidth,
            margin: EdgeInsets.all(5),
            padding: EdgeInsets.all(10),
            color: Colors.black12,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  i.name,
                  maxLines: 1,
                ),
                Text(
                  i.content,
                  maxLines: 1,
                ),
              ],
            ),
          )
      );
    }).toList();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Center(
//          padding: EdgeInsets.all(5),
          child: Text("最新提问",style: TextStyle(
            fontSize: 16.0,
            color: Color.fromRGBO(51, 51, 51, 1),
          ),),),
        Wrap(
          spacing: 2,
          children: listWidgets,
        )
      ],
    );
  }

}