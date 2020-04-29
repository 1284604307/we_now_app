import 'dart:io';
import 'dart:typed_data';

import 'package:bot_toast/bot_toast.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:dio/dio.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_app2/common/Api.dart';
import 'package:flutter_app2/pages/wights/LittleWidgets.dart';
import 'package:flutter_app2/services/model/Article.dart';
import 'package:flutter_app2/common/pojos/AjaxResult.dart';
import 'package:flutter_app2/pages/global/global_config.dart';
import 'package:flutter_app2/pages/wights/ClickableImage.dart';
import 'package:flutter_app2/pages/wights/avatar.dart';
import 'package:flutter_app2/pages/wights/show_image.dart';
import 'package:flutter_app2/services/model/viewModel/favourite_model.dart';
import 'package:http_parser/http_parser.dart';
import 'package:image_picker/image_picker.dart';
import 'package:multi_image_picker/multi_image_picker.dart';
import 'package:oktoast/oktoast.dart';
import 'package:photo_view/photo_view.dart';
import 'package:provider/provider.dart';

import 'circle_show.dart';

/**
 * @author Ming
 * @date 2020/4/19
 * @email 1284604307@qq.com
 */
Widget talkWidget(context,count,Article circle){

  /// 用于Hero动画的标记
  UniqueKey uniqueKey = UniqueKey();
  return InkWell(
    onTap: (){
      Navigator.push(context,
        MaterialPageRoute(
          builder: (BuildContext context) {
            return ShowCircle();
          }
        )
      );
    },
    child: Container(
      color: Theme.of(context).cardColor,
      padding: EdgeInsets.all(15),
      margin: EdgeInsets.only(bottom: 10),
      child: Column(
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(bottom: 5),
            child: Row(
              children: <Widget>[
                // desc 头像
                Avatar(CachedNetworkImage(imageUrl: "${circle.user.avatar}")),
                Container(
                  margin: EdgeInsets.only(left: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,//垂直方向 向左靠齐
                    children: <Widget>[
                      Text(
                        " ${circle.user.userName} ",
                        textAlign: TextAlign.left,
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Text(
                        " ${circle.createTime} ",
                        maxLines: 5,
                        overflow: TextOverflow.clip,
                        textAlign: TextAlign.left,
                        style: TextStyle(color: Theme.of(context).hintColor),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
          // desc 动态内容及底部组件
          Column(
            children: <Widget>[
              new Container(
                  child: new Text(
                    "${circle.content}",
                  ),
                  margin: new EdgeInsets.only(top: 6.0, bottom: 6.0),
                  alignment: Alignment.topLeft
              ),
              // desc 九图组件
              circle.url!=null?gridViewNithWight(circle.url,context):Container(),
              Container(
                margin: EdgeInsets.only(top: 20),
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: Container(
                        padding: EdgeInsets.all(5.0),
                        child: InkWell(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              // desc 收藏按钮
                              Icon(Icons.share,color: Theme.of(context).primaryColorDark,),
                              Text(" 转发",style: TextStyle(color: Theme.of(context).hintColor,),)
                            ],
                          ),
                        ),
                      ),
                      flex: 1,
                    ),
                    Expanded(
                      child: Container(
                        padding: EdgeInsets.all(5.0),
                        child: InkWell(
                          child: InkWell(
                            onTap: (){
                              Navigator.push(context,
                                  MaterialPageRoute(
                                      builder: (BuildContext context) {
                                        return ShowCircle();
                                      }
                                  )
                              );
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                // desc 评论
                                Icon(Icons.image_aspect_ratio,color: Theme.of(context).primaryColorDark,),
                                Text("  999",style: TextStyle(color: Theme.of(context).hintColor,),)
                              ],
                            ),
                          ),
                        ),
                      ),
                      flex: 2,
                    ),
                    Expanded(
                      child: Container(
                        padding: EdgeInsets.all(5.0),
                        child: InkWell(
                          onTap: (){
                            showToast("展示就对咯");
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Consumer<GlobalFavouriteStateModel>(
                                builder: (context, model, child) {
                                  //利用child局部刷新
                                  if (model[circle.id] == null) {
                                    return child;
                                  }
                                  return ArticleFavouriteWidget(
                                      circle..collect = model[circle.id],
                                      uniqueKey);
                                },
                                child: ArticleFavouriteWidget(circle, uniqueKey),
                              ),
                              Text("  999",style: TextStyle(color: Theme.of(context).hintColor,),)
                            ],
                          ),
                        ),
                      ),
                      flex: 1,
                    ),

                  ],
                ),
              )
            ],
          )
        ],
      ),
    ),
  );
}

// desc 九图展示
gridViewNithWight(List<String> urls,BuildContext context){
  if(urls.length==0) return Container();
  return GridView.builder(
    primary: false,
    shrinkWrap: true,
    itemCount: urls.length,
    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3, //横轴三个子widget
        crossAxisSpacing: 5,
        mainAxisSpacing: 5 //分别是 x y 的间隔
    ),
    itemBuilder: (c,i){
      ExtendedImage extendedImage = ExtendedImage.network(
        urls[i],fit: BoxFit.cover,
      );
      return Container(
        color: Colors.lightBlueAccent,
        child: GestureDetector(
          child: extendedImage,
          onTap: (){
            Navigator.push(context, MaterialPageRoute(builder: (BuildContext context){
              return ShowImagePage(extendedImage: ExtendedImage.network(
                urls[i],fit: BoxFit.contain,width: double.infinity,height: double.infinity,
                mode: ExtendedImageMode.gesture ,
              ));
            })
            );
          }
        ),
      );
    },
  );
}

class CreateCirclePage extends StatefulWidget{

  @override
  State<StatefulWidget> createState() {
    return _State();
  }

}

class _State extends State<CreateCirclePage> with AutomaticKeepAliveClientMixin   {



  List<Widget> images = [];
  List<Asset> asserts = [];
  List<Uint8List> imageData = [];

  @override
  Widget build(BuildContext context) {
    TextEditingController circleTextController = TextEditingController();
    circleTextController.text = Api.newCircleEntity.content ;
    print(Api.newCircleEntity.content);
    circleTextController.addListener((){
      Api.newCircleEntity.content = circleTextController.text;
    });
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: Text("创作",style: TextStyle(fontWeight: FontWeight.normal,fontSize: 18,fontStyle: FontStyle.normal ),),
        actions: <Widget>[
          Container(
            margin: EdgeInsets.only(right: 20),
            alignment: Alignment.centerRight,
            child: InkWell(
              child: Container(
                  padding: EdgeInsets.all(10),
                  child:Text("发布")
              ),
              onTap: (){
                print(circleTextController.toString());
                print(images.toList().toString());
                publish();
              },
            ),
          )
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.only(bottom: 10,left: 15,right: 15),
        child: Column(
          children: <Widget>[
            Container(
              padding: EdgeInsets.only(bottom: 30),
              // desc 动态内容文本框
              child: TextField(
                controller:circleTextController,
                autofocus: true,
                minLines: 6,
                maxLines: 1000,
                focusNode: FocusNode(),
                decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: "发布新动态！就是现在~",
                    labelStyle: null,
                ),
              ),
            ),
            Container(
              child: GridView.builder(
                shrinkWrap: true,
                primary: false,
                itemCount: images.length+1,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3, //横轴三个子widget
                    crossAxisSpacing: 5,
                    mainAxisSpacing: 5 //分别是 x y 的间隔
                ),
                itemBuilder: (context,index){
                  if(index == images.length){
                    if(index >= 9) return null;
                    return selectNewImage();
                  }
                  // desc 返回一个包装了删除键的栈
                  return Stack(
                    children: <Widget>[
                      images[index],
                      Positioned(
                        right: 0,
                        top: 0,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(40),
                          child: Container(
                            width: 30, height: 30,
                            color: Color.fromRGBO(0, 0, 0, 0.25),
                            child: IconButton(
                              icon: Icon(Icons.close,size: 15,color: Colors.white,),
                              onPressed: (){
                                print(index);
                                setState(() {
                                  images.removeAt(index);
                                  asserts.removeAt(index);
                                });
                              },
                            ),
                          ),
                        ),
                      )
                    ],
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  void publish() async{
    List<String> url = [];
    // desc 有图片先上传
    if(asserts.length>0){
      BotToast.showText(text: "上传图片");

      FormData data = new FormData();
      for(var i =0 ;i<asserts.length;i++){

        MultipartFile multipartFile =await MultipartFile.fromBytes(
          imageData[i],
          // 文件名
          filename: '${asserts[i].name}.jpg',
          // 文件类型
          contentType: MediaType("image", "jpg"),
        );
        print("第 $i 次 发送");
        data.files.add(MapEntry("files",multipartFile));
      }
      var res = await Api.getDio().post("/user/upload/files",data:data);
      print(res);
      AjaxResult ajaxResult = AjaxResult.fromJson(res.data);
      if (ajaxResult.code==0) {
        url =  List<String>.from(ajaxResult.data);
      };
    }
    var n = Article();
    n.content = Api.newCircleEntity.content;
    n.url = url;
    BotToast.showText(text: "上传动态");
    var res = await Api.getDio().post("/public/user/circle/",data: n);
    print(res);
  }

  Widget selectNewImage(){
//    var _width = (this.context.size.width -40)/3;
    return Listener(
        onPointerDown: (event) async {
          //desc 每行单张图片大小 (this.context.size.width - 40)/3
//          print((this.context.size.width - 40)/3);
          List<Asset> package ;
          try{
            package = await MultiImagePicker.pickImages(
                enableCamera: true,
                maxImages: 9,
                selectedAssets: asserts,
                cupertinoOptions: CupertinoOptions(takePhotoIcon: "chat"),
                materialOptions: MaterialOptions(
//                actionBarColor: GlobalConfig.titleColor,
                  actionBarTitle: "选择图片",
                  allViewTitle: "所有图片",
                  selectCircleStrokeColor: "#000000",
                )
            );
          } catch(e){
            return;
          }
          print("------------${asserts.length}------------------");
          List<Widget> newImages = [];
          List<Uint8List> datas = [];
          for(var i =0; i<package.length;i++){

            ByteData memoryData = await package[i].getByteData(quality: 100);
            Uint8List data =  memoryData.buffer.asUint8List();
            datas.add(data);
            print("  加载 -------------- ${package[i].name} ----------------------");
            newImages.add(
                ClickableImage(list:data)
            );
          }
          await asserts.addAll(package);
          setState(() {
              asserts = package;
              images = newImages;
              imageData = datas;
          });

        },
        child:LayoutBuilder(
          builder: (context,con){
            return DottedBorder(
              strokeWidth: 2,
              color: Color.fromRGBO(0, 0, 0, 0.1),
              child: Container(
                child: Icon(Icons.add,size:con.maxWidth,color: Color.fromRGBO(0, 0, 0, 0.12),),
              ),
            );
        },
        )
    );
  }

  @override
  bool get wantKeepAlive => true;

}