import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app2/pages/home/home_banner.dart';
import 'package:flutter_app2/pages/home/home_news_page.dart';
import 'package:flutter_app2/pages/home/index/news_list.dart';
import 'package:flutter_app2/services/indexNews.dart';
import 'package:flutter_app2/services/model/news.dart';
import 'package:flutter_swiper/flutter_swiper.dart';

class HomePage extends StatefulWidget{
  @override
  HomePageState createState()=>HomePageState();
}

class HomePageState extends State<HomePage>{

  NewsListModal newsData = NewsListModal([]);

  void getNewsList() async{
    var data = await getNewsResult();
    NewsListModal list = NewsListModal.fromJson(data);
    setState(() {
      newsData.data.addAll(list.data);
      print(newsData.data);
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    getNewsList();
    super.initState();
  }

  @override
  Scaffold build(BuildContext context) {
//    double width = MediaQuery.of(context).size.width;
//    double height = width * 540.0/1080.0;
    return Scaffold(
      appBar: AppBar(
        title: Text("Show Now",style: TextStyle(
          color: Colors.white
        ),),
//        leading: Icon(Icons.home),
        actions: <Widget>[
          //右侧内边距
          Padding(
            padding: EdgeInsets.only(right: 20.0),
            child: GestureDetector(
              onTap: (){
                BotToast.showText(text: "功能未做,应跳转到搜索页");
              },
              child: Icon(
                Icons.search,
                color: Colors.white,
              ),
            ),
          )
        ],
      ),
      backgroundColor: Colors.black12,
      body: Container(
        color: Colors.white,
        child: Flex(
          children: <Widget>[
            BannerWiget(),
            HomeNewsPage(list: newsData),
            Expanded(
              child: ListView.builder(itemBuilder: (BuildContext context, int index) {
                return BannerWiget();
              }),
            )
          ], direction: Axis.vertical,
        ),
      ),
    );
  }

}