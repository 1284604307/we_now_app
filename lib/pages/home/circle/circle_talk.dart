import 'dart:typed_data';

import 'package:bot_toast/bot_toast.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:dio/dio.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:extended_text_field/extended_text_field.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_app2/common/Api.dart';
import 'package:flutter_app2/common/constant.dart';
import 'package:flutter_app2/pages/home/circle/publish/publish_topic_page.dart';
import 'package:flutter_app2/pages/home/message/emoji_widget.dart';
import 'package:flutter_app2/pages/wights/GridViewNithWight.dart';
import 'package:flutter_app2/pages/wights/LittleWidgets.dart';
import 'package:flutter_app2/pages/wights/article/content.dart';
import 'package:flutter_app2/pages/wights/extend_textfield/my_special_text_span_builder.dart';
import 'package:flutter_app2/pages/wights/page_route_anim.dart';
import 'package:flutter_app2/services/model/Article.dart';
import 'package:flutter_app2/pages/wights/ClickableImage.dart';
import 'package:flutter_app2/pages/wights/avatar.dart';
import 'package:flutter_app2/services/model/Topic.dart';
import 'package:flutter_app2/services/net/restful_go.dart';
import 'package:flutter_app2/services/utils/sp_util.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:http_parser/http_parser.dart';
import 'package:multi_image_picker/multi_image_picker.dart';
import 'package:oktoast/oktoast.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

import 'circle_show.dart';

/**
 * @author Ming
 * @date 2020/4/19
 * @email 1284604307@qq.com
 */
Widget talkWidget(context, Article circle) {
  /// 用于Hero动画的标记
  UniqueKey uniqueKey = UniqueKey();
  return InkWell(
    onTap: () {
      Navigator.push(context,
          MaterialPageRoute(builder: (BuildContext context) {
        return ShowCircle(circle);
      }));
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
                Avatar(CachedNetworkImage(imageUrl: "${circle.user?.avatar}")),
                Container(
                  margin: EdgeInsets.only(left: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start, //垂直方向 向左靠齐
                    children: <Widget>[
                      Text(
                        " ${circle.user?.userName} ",
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
                  child: textContent("${circle.content}",context,false),
                  margin: new EdgeInsets.only(top: 6.0, bottom: 6.0),
                  alignment: Alignment.topLeft),
              // desc 九图组件
              circle.url != null ? GridViewNithWight(circle.url) : Container(),
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
                              Icon(
                                Icons.share,
                                color: Theme.of(context).primaryColorDark,
                              ),
                              Text(
                                " 转发",
                                style: TextStyle(
                                  color: Theme.of(context).hintColor,
                                ),
                              )
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
                            onTap: () {
                              Navigator.push(context, MaterialPageRoute(
                                  builder: (BuildContext context) {
                                return ShowCircle(circle);
                              }));
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                // desc 评论
                                Icon(
                                  Icons.image_aspect_ratio,
                                  color: Theme.of(context).primaryColorDark,
                                ),
                                Text(
                                  " ${circle.commentCount}",//likeCount
                                  style: TextStyle(
                                    color: Theme.of(context).hintColor,
                                  ),
                                )
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
                        child:  ArticleLikeWidget(
                            circle,
                            uniqueKey),
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

class CreateCirclePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _State();
  }
}

// desc 发布新动态页
class _State extends State<CreateCirclePage>
    with AutomaticKeepAliveClientMixin {

  List<Widget> images = [];
  List<Asset> asserts = [];
  List<Uint8List> imageData = [];
  PanelController panelController = PanelController();

  double _softKeyHeight = SpUtil.getDouble(Constant.SP_KEYBOARD_HEGIHT, 235);

  String showPanel = "";
  var textLength = 0;
  FocusNode focusNode = FocusNode();

  List<String> topicIds = [];

  _initTextEdit(){
    _mEtController.text = Api.newCircleEntity.content;
    textLength = _mEtController.text.length;
    _mEtController.addListener(() {
      Api.newCircleEntity.content = _mEtController.text;
      setState(() {
        textLength = _mEtController.text.length;
      });
    });
  }

  @override
  initState(){
    super.initState();
    _initTextEdit();
    KeyboardVisibility.onChange.listen((bool visible) {
      setState(() {
        if(visible){
          setState(() {
            showPanel = "";
          });
        }
      });
    });
  }

  MySpecialTextSpanBuilder _mySpecialTextSpanBuilder = MySpecialTextSpanBuilder();
  TextEditingController _mEtController = new TextEditingController();

  @override
  Widget build(BuildContext context) {

    super.build(context);
    return WillPopScope(
      child: SlidingUpPanel(
        boxShadow: null,
        snapPoint: 0.5,
        minHeight: 0,
        maxHeight: _softKeyHeight*2,
        controller: panelController,
        header: Container(
          width: MediaQuery.of(context).size.width,
          height: 50,
          color: Colors.grey,
          child:Material(
            child:
            Container(
                color: Color(0xffF9F9F9),
                padding: EdgeInsets.only(left: 15, right: 5, top: 10, bottom: 10),
                child: Row(
                  /* mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.center,*/
                  children: <Widget>[
                    // desc 图片选择 已完成 √
                    new Expanded(
                      child: InkWell(
                        child: Image.asset(
                          Constant.ASSETS_IMG + 'icon_image.webp',
                          width: 25.0,
                          height: 25.0,
                        ),
                        onTap: () {
                          toSelectImage();
                        },
                      ),
                      flex: 1,
                    ),
                    // desc At他人 @用户
                    new Expanded(
                      child: InkWell(
                        child: Image.asset(
                          Constant.ASSETS_IMG + 'icon_mention.png',
                          width: 25.0,
                          height: 25.0,
                        ),
                        onTap: () {
                          // desc @人
//                      Routes
//                          .navigateTo(
//                              context, '${Routes.weiboPublishAtUsrPage}')
//                          .then((result) {
//                        WeiboAtUser mAtUser = result as WeiboAtUser;
//                        if (mAtUser != null) {
//                          mWeiBoSubmitText = mWeiBoSubmitText +
//                              "[@" +
//                              mAtUser.nick +
//                              ":" +
//                              mAtUser.id +
//                              "]";
//                          //   _mEtController.text = _mEtController.text + "@" + mAtUser.nick+" ";
//                          //   print("_mEtControllerfield的值:" + mWeiBoSubmitText);
//
//                          _mEtController.text = _mEtController.text +
//                              "[@" +
//                              mAtUser.nick +
//                              ":" +
//                              mAtUser.id +
//                              "]";
//                          //   _mEtController.buildTextSpan()
//                          // _mEtController.text=_mEtController.text+"#aaaa#" ;
//                        }
//                      });
                        },
                      ),
                      flex: 1,
                    ),
                    // desc 话题 #话题#
                    new Expanded(
                      child: InkWell(
                        child: Image.asset(
                          Constant.ASSETS_IMG + 'icon_topic.png',
                          width: 25.0,
                          height: 25.0,
                        ),
                        onTap: () {
                          focusNode.unfocus();
                          setState(() {
                            showPanel = "话题";
                          });
                        },
                      ),
                      flex: 1,
                    ),
                    // desc 表情选择
                    new Expanded(
                      child: InkWell(
                        child: Image.asset(
                          Constant.ASSETS_IMG + 'icon_emotion.png',
                          width: 25.0,
                          height: 25.0,
                        ),
                        onTap: () async {
                          focusNode.unfocus();
                          setState(() {
                            showPanel = "表情";
                          });
                        },
                      ),
                      flex: 1,
                    ),
                    new Expanded(
                      child: InkWell(onTap: (){},child: Container(color: Colors.red,),),
                      flex: 3,
                    ),
                  ],
                )
            ),
            ),
        ),
        panel: Material(
            child: Container(
              color: Colors.grey ,
              padding: EdgeInsets.only(top: 46),
              alignment: Alignment.topCenter,
//          color: Colors.white,
              child: Column(
                children: <Widget>[
                  // desc #表情选择#
                  Visibility(
                    visible: true,
                    child: EmojiWidget(onEmojiClockBack: (value) {
                      if (value == 0) {
                        _mEtController.clear();
                      } else {
                        _mEtController.text =
                            _mEtController.text + "[/" + value.toString() + "]";
                      }
                    }),
                  )
                ],
              ),
            ),
          ),
        body: Scaffold(
          resizeToAvoidBottomInset: true,
          appBar: AppBar(
            centerTitle: true,
            title: Text(
              "新动态",
              style: TextStyle(
                  fontWeight: FontWeight.normal,
                  fontSize: 18,
                  fontStyle: FontStyle.normal),
            ),
            actions: <Widget>[
              Container(
                margin: EdgeInsets.only(right: 20),
                alignment: Alignment.centerRight,
                child: InkWell(
                  child: Container(padding: EdgeInsets.all(10), child: Text("发布")),
                  onTap: () async {
                      BotToast.showLoading();
                      print(_mEtController.toString());
                      print(images.toList().toString());
                      publish().then((onValue){
                        BotToast.closeAllLoading();
                        showToast("发布成功");
                        Navigator.pop(context);
                      }).catchError((onError){
                        BotToast.closeAllLoading();
                        showToast("发布错误");
                      });
                  },
                ),
              )
            ],
          ),
          body: Column(
            children: <Widget>[
              Expanded(
                child: SingleChildScrollView(
                  padding: EdgeInsets.only(bottom: 10, left: 15, right: 15),
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    children: <Widget>[
                      Container(
                        padding:
                        EdgeInsets.only(top: 10.0, left: 10.0, right: 10, bottom: 20),
                        constraints: new BoxConstraints(minHeight: 50.0),
                        child:
                        ExtendedTextField(
                          //    textSelectionControls: _myExtendedMaterialTextSelectionControls,
                          specialTextSpanBuilder: _mySpecialTextSpanBuilder,
                          controller: _mEtController,
                          focusNode: focusNode,
                          minLines: 6,
                          maxLines: 1000,
//                          focusNode: focusNode,
                          style: TextStyle(color: Colors.black, fontSize: 15),
                          decoration: InputDecoration.collapsed(
                              hintText: "发布新动态！就是现在~",
                              hintStyle: TextStyle(color: Color(0xff919191), fontSize: 15)),
                        ),
                      ),
                      Container(
                        child: GridView.builder(
                          shrinkWrap: true,
                          primary: false,
                          itemCount: images.length + 1,
                          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 3, //横轴三个子widget
                              crossAxisSpacing: 5,
                              mainAxisSpacing: 5 //分别是 x y 的间隔
                          ),
                          itemBuilder: (context, index) {
                            if (index == images.length) {
                              if (index >= 9) return null;
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
                                      width: 30,
                                      height: 30,
                                      color: Color.fromRGBO(0, 0, 0, 0.25),
                                      child: IconButton(
                                        icon: Icon(
                                          Icons.close,
                                          size: 15,
                                          color: Colors.white,
                                        ),
                                        onPressed: () {
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
              ),
              Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(""),
                    Padding(
                      padding: EdgeInsets.only(right: 30),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(15),
                        child: Container(
                          color: Colors.grey[200],
                          padding: EdgeInsets.all(3),
                          child: Text(" $textLength ",maxLines: 1,style: TextStyle(color: Colors.grey),),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              // desc 底部操作栏
              buildBottom(),
            ],
          ),
        ),
      ),
      onWillPop: () {
        if(panelController.isPanelOpen){
          panelController.close();
        }else
          Navigator.pop(context);
        return;
      },
    );
  }


  //输入框底部布局
  Widget buildBottom() {
    return Column(
      children: <Widget>[
        Container(
            color: Color(0xffF9F9F9),
            padding: EdgeInsets.only(left: 15, right: 5, top: 10, bottom: 10),
            child: Row(
              /* mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.center,*/
              children: <Widget>[
                // desc 图片选择 已完成 √
                new Expanded(
                  child: InkWell(
                    child: Image.asset(
                      Constant.ASSETS_IMG + 'icon_image.webp',
                      width: 25.0,
                      height: 25.0,
                    ),
                    onTap: () {
                      toSelectImage();
                    },
                  ),
                  flex: 1,
                ),
                // desc At他人 @用户
                new Expanded(
                  child: InkWell(
                    child: Image.asset(
                      Constant.ASSETS_IMG + 'icon_mention.png',
                      width: 25.0,
                      height: 25.0,
                    ),
                    onTap: () {
                      // desc @人
//                      Routes
//                          .navigateTo(
//                              context, '${Routes.weiboPublishAtUsrPage}')
//                          .then((result) {
//                        WeiboAtUser mAtUser = result as WeiboAtUser;
//                        if (mAtUser != null) {
//                          mWeiBoSubmitText = mWeiBoSubmitText +
//                              "[@" +
//                              mAtUser.nick +
//                              ":" +
//                              mAtUser.id +
//                              "]";
//                          //   _mEtController.text = _mEtController.text + "@" + mAtUser.nick+" ";
//                          //   print("_mEtControllerfield的值:" + mWeiBoSubmitText);
//
//                          _mEtController.text = _mEtController.text +
//                              "[@" +
//                              mAtUser.nick +
//                              ":" +
//                              mAtUser.id +
//                              "]";
//                          //   _mEtController.buildTextSpan()
//                          // _mEtController.text=_mEtController.text+"#aaaa#" ;
//                        }
//                      });
                    },
                  ),
                  flex: 1,
                ),
                // desc 话题 #话题#
                new Expanded(
                  child: InkWell(
                    child: Image.asset(
                      Constant.ASSETS_IMG + 'icon_topic.png',
                      width: 25.0,
                      height: 25.0,
                    ),
                    onTap: () {
                      goSelectTopic();
                    },
                  ),
                  flex: 1,
                ),
                // desc 表情选择
                new Expanded(
                  child: InkWell(
                    child: Image.asset(
                      Constant.ASSETS_IMG + 'icon_emotion.png',
                      width: 25.0,
                      height: 25.0,
                    ),
                    onTap: () async {
                        focusNode.unfocus();
                        setState(() {
                          showPanel = "表情";
                        });
                    },
                  ),
                  flex: 1,
                ),
                new Expanded(
                  child: InkWell(onTap: (){},child: Container(color: Colors.red,),),
                  flex: 3,
                ),
              ],
            )
        ),
        Visibility(
          visible: showPanel!="",
          child: Container(
            height: 235,
            child: Stack(
              children: <Widget>[
                // desc #表情选择#
                Visibility(
                  visible: showPanel == "表情",
                  child: EmojiWidget(onEmojiClockBack: (value) {
                    if (value == 0) {
                      _mEtController.clear();
                    } else {
                      _mEtController.text =
                          _mEtController.text + "[/" + value.toString() + "]";
                    }
                  }),
                ),
                // desc #话题选择#
                Visibility(
                  visible: showPanel == "话题",
                  child: Column(
                    children: <Widget>[
                      Text("当前只能选择一个话题！",textAlign: TextAlign.center,),
                      Expanded(
                        child: ListView.builder(itemBuilder: (c,i){
                          return Text("$i");
                        },itemCount: 12,
                          primary: false,
                          shrinkWrap: true,)
                      )
                    ],
                  ),
                ),
                // desc #At功能#
                Visibility(
                  visible: showPanel == "At",
                  child: Container(
                    child: Text("这个还没有做好哦~"),
                  ),
                )
              ],
            ),
          ),
        )
      ],
    );
  }

  Future<void> publish() async {
    List<String> urls = [];
    // desc 有图片先上传
    if (asserts.length > 0) {
      BotToast.showText(text: "上传图片");

      FormData data = new FormData();
      for (var i = 0; i < asserts.length; i++) {
        MultipartFile multipartFile = await MultipartFile.fromBytes(
          imageData[i],
          // 文件名
          filename: '${asserts[i].name}.jpg',
          // 文件类型
          contentType: MediaType("image", "jpg"),
        );
        print("第 $i 次 发送");
        data.files.add(MapEntry("files", multipartFile));
      }
      urls = await RestfulApi.uploadImages(data);
    }
    BotToast.showLoading();
    BotToast.closeAllLoading();
    var res = await RestfulApi.postNewCircle({
      "content": Api.newCircleEntity.content,
      "urls":urls
    });
    print(res);
  }

  Widget selectNewImage() {
//    var _width = (this.context.size.width -40)/3;
    return Listener(onPointerDown: (event) async {
      await toSelectImage();
      }, child: LayoutBuilder(
      builder: (context, con) {
        return DottedBorder(
          strokeWidth: 2,
          color: Color.fromRGBO(0, 0, 0, 0.1),
          child: Container(
            child: Icon(
              Icons.add,
              size: con.maxWidth,
              color: Color.fromRGBO(0, 0, 0, 0.12),
            ),
          ),
        );
      },
    ));
  }

  toSelectImage() async{

    //desc 每行单张图片大小 (this.context.size.width - 40)/3
//          print((this.context.size.width - 40)/3);
    List<Asset> package;
    try {
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
          ));
    } catch (e) {
      return;
    }
    print("------------${asserts.length}------------------");
    List<Widget> newImages = [];
    List<Uint8List> datas = [];
    for (var i = 0; i < package.length; i++) {
      ByteData memoryData = await package[i].getByteData(quality: 100);
      Uint8List data = memoryData.buffer.asUint8List();
      datas.add(data);
      print("  加载 -------------- ${package[i].name} ----------------------");
      newImages.add(ClickableImage(list: data));
    }
    await asserts.addAll(package);
    setState(() {
      asserts = package;
      images = newImages;
      imageData = datas;
    });
  }

  @override
  bool get wantKeepAlive => true;

  void goSelectTopic() {
    Navigator.of(context).push(SizeRoute(PublishTopicPage())).then((data){
      print(data);
      if(data!=null){
        Topic topic = data as Topic;
        _mEtController.text = _mEtController.text +
            "#${topic.topic}#";
        topicIds.add(topic.topic);
      }
    });
  }
}
