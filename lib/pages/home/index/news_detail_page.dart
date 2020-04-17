import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app2/services/model/news.dart';

class NewsDetailPage extends StatelessWidget{

  final News item;

  NewsDetailPage({Key key,@required this.item}) : super(key:key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(item.name),
      ),
      body: Column(

      ),
    );
  }

}