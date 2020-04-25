import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_app2/common/Api.dart';
import 'package:flutter_app2/pages/global/global_config.dart';
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
          autoplay: true,
          autoplayDelay:1500,
          autoplayDisableOnInteraction: true,
          viewportFraction: 1,
          scale: 0.8,
          itemBuilder: (BuildContext context, int index) {
            return Container(
              margin: EdgeInsets.all(5),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child:  new Image.network(
                    imgList[index]["url"],
                    fit: BoxFit.fill,
                  )
              ),
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

  List<String> imgList = [
    "https://www.itying.com/images/flutter/1.png",
    "https://www.itying.com/images/flutter/2.png",
    "https://www.itying.com/images/flutter/3.png",
    "https://www.itying.com/images/flutter/4.png"
  ];

  List<Widget> _getListData() {
    List listData=[
      {
        "title": 'Candy Shop',
        "author": 'Mohamed Chahin',
        "imageUrl": 'https://www.itying.com/images/flutter/1.png',
      },
      {
        "title": 'Childhood in',
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

  Widget HorListView(){
    return Column(
      children: <Widget>[
        Container(
          margin: EdgeInsets.only(left: 15,right: 15),
          child: Row(
            children: <Widget>[
              Text("优秀文章榜",style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20
              ),),
              Text("   原创",style: TextStyle(
                color: Colors.black26
              ),)
            ],
          ),
        ),
        Container(
          height: 180,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
              return Container(
                margin: EdgeInsets.all(10),
                child: Stack(
                  children: <Widget>[
                    ClipRRect(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      child: Container(
                        width: 200,
                        decoration: BoxDecoration(
                          border: new Border.all(color: Color.fromRGBO(0, 0, 0, 0.08), width: 0.5), // 边色与边宽度
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                        ),
                        child: Column(
                          children: <Widget>[
                            Container(
                              width: 200,
                              height: 100,
                              color: Colors.redAccent[100*index%200+100],
                              child: Image.network(imgList[index%4],fit: BoxFit.fill,),
                            ),
                            Container(
                              margin: EdgeInsets.all(5),
                              child: Center(
                                child: Text("穷尽一生，寻找一个梦的终点. 来吧，一起去寻找！",maxLines: 2,textAlign: TextAlign.center,),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
            itemCount: imgList.length,
          ),
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("首页"),
      ),
      body: Container(
        color: GlobalConfig.globalBackgroundColor,
        child: ListView(
          children: <Widget>[
            ClipRRect(
              child: Container(
                margin: EdgeInsets.all(5),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(50)),
                ),
                child: _swiperWidget(),
              ),
            ),
            SizedBox(height: 10),
            HorListView(),
            _recProductWidget()
          ],
        ),
      ),
    );
  }
}