import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_app2/common/Api.dart';
import 'package:flutter_swiper/flutter_swiper.dart';

class Home extends StatefulWidget {
  Home({Key key}) : super(key: key);
  State createState() => _State();
}

class _State extends State<Home> {
  //轮播图
  Widget _swiperWidget() {
    List<Map> imgList = [
      {"url": "https://www.itying.com/images/flutter/1.png"},
      {"url": "https://www.itying.com/images/flutter/2.png"},
      {"url": "https://www.itying.com/images/flutter/3.png"},
      {"url": "https://www.itying.com/images/flutter/4.png"}
    ];
    return Container(
      child: AspectRatio(
        aspectRatio: 16 / 9,
        child: Swiper(
          itemBuilder: (BuildContext context, int index) {
            return new Image.network(
              imgList[index]["url"],
              fit: BoxFit.fill,
            );
          },
          itemCount: imgList.length,
          pagination: new SwiperPagination(),
        ),
      ),
    );
  }

  //首页热门商品
  Widget _hotProductWidget() {}

  //首页热门商品


  List<Widget> _getListData() {
    List listData=[
      {
        "title": 'Candy Shop',
        "author": 'Mohamed Chahin',
        "imageUrl": 'https://www.itying.com/images/flutter/1.png',
      },
      {
        "title": 'Childhood in a picture',
        "author": 'Google',
        "imageUrl": 'https://www.itying.com/images/flutter/2.png',
      },
      {
        "title": 'Alibaba Shop',
        "author": 'Alibaba',
        "imageUrl": 'https://www.itying.com/images/flutter/3.png',
      },
      {
        "title": 'Candy Shop',
        "author": 'Mohamed Chahin',
        "imageUrl": 'https://www.itying.com/images/flutter/4.png',
      },
      {
        "title": 'Tornado',
        "author": 'Mohamed Chahin',
        "imageUrl": 'https://www.itying.com/images/flutter/5.png',
      },
      {
        "title": 'Undo',
        "author": 'Mohamed Chahin',
        "imageUrl": 'https://www.itying.com/images/flutter/6.png',
      },
      {
        "title": 'white-dragon',
        "author": 'Mohamed Chahin',
        "imageUrl": 'https://www.itying.com/images/flutter/7.png',
      }

    ];

    var tempList=listData.map((value){
      return Container(
        child:Column(
          children: <Widget>[
            Image.network(value['imageUrl']),
            SizedBox(height: 12),
            Text(
              value['title'],
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 20
              ),
            )
          ],

        ),
        decoration: BoxDecoration(

            border: Border.all(
                color:Color.fromRGBO(233, 233,233, 0.9),
                width: 1
            )
        ),

        // height: 400,  //设置高度没有反应
      );

    });
    // ('xxx','xxx')
    return tempList.toList();
  }

  Widget _recProductWidget() {
    return GridView.count(
      crossAxisSpacing:10.0 ,   //水平子 Widget 之间间距
      mainAxisSpacing: 10.0,    //垂直子 Widget 之间间距
      padding: EdgeInsets.all(10),
      crossAxisCount: 2,  //一行的 Widget 数量
      // childAspectRatio:0.7,  //宽度和高度的比例
      children: this._getListData(),
      physics: new NeverScrollableScrollPhysics(),//增加
      shrinkWrap: true,//增加

    );
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: <Widget>[
        _swiperWidget(),
        SizedBox(height: 10),
        Container(
          //不给高度的话显示不了哈，就跟android里，scrollview里嵌套listview一样，要计算高度的意思，这里我就先随便给个，其实我觉得应该是要根据item的高度来算的，但我现在不会算啊
          height: 100.0,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, position) {
              return Container(
                color: Colors.red,
                alignment: Alignment.center,
                child: Text(
                  "${position}",
                  style: TextStyle(color: Colors.yellow, fontSize: 50.0),
                ),
                padding: EdgeInsets.all(10.0),
              );
            },
            itemCount: 88,
          ),
        ),

        _recProductWidget()

      ],
    );
  }
}