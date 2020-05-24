import 'dart:io';

import 'package:bot_toast/bot_toast.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app2/common/Api.dart';
import 'package:flutter_app2/common/pojos/User.dart';
import 'package:flutter_app2/pages/home/me/update_avatar_page.dart';
import 'package:flutter_app2/pages/wights/GenderChoosedialog.dart';
import 'package:flutter_app2/pages/wights/LittleWidgets.dart';
import 'package:flutter_app2/pages/wights/Signaturedialog.dart';
import 'package:flutter_app2/pages/wights/avatar.dart';
import 'package:flutter_app2/pages/wights/page_route_anim.dart';
import 'package:flutter_app2/services/model/viewModel/user_model.dart';
import 'package:flutter_app2/services/net/restful_go.dart';
import 'package:image_picker/image_picker.dart';
import 'package:oktoast/oktoast.dart';
import 'package:provider/provider.dart';

/**
 * @createDate  2020/5/3
 */
class MeInfoPage extends StatefulWidget {
  @override
  _State createState() => _State();
}


/**
 * 个人详情页
 */
class _State extends State<MeInfoPage> {
  bool _showSchoolInfo = false;
  User user;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    User base = Provider.of<UserModel>(context,listen: false).user;
    user = new User();
    user.userName = base.userName;
    user.sex = base.sex;
    user.signature  = base.signature;
    user.email  = base.email;
    user.phonenumber  = base.phonenumber;
    user.birthday  = base.birthday;
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<UserModel>(
      builder: (c, uModel, child) {
        return Scaffold(
          appBar: AppBar(
            title: Text("个人信息"),
            centerTitle: true,
            actions: <Widget>[
              InkWell(
                onTap: ()async{
                  BotToast.showLoading();
                  RestfulApi.updateUser(user)
                      .then((ok){
                        Provider.of<UserModel>(context).refreshInfo();
                        Navigator.pop(context);
                  })
                  .catchError((error){showToast("上传错误");}).whenComplete((){BotToast.closeAllLoading();});
                },
                child: Container(
                  margin: EdgeInsets.all(10),
                  alignment: Alignment.center,
                  child: Text("保存"),
                ),
              )
            ],
          ),
          body: GestureDetector(
            behavior: HitTestBehavior.translucent,
            onTap: () {
              // 触摸收起键盘
              FocusScope.of(context).requestFocus(FocusNode());
            },
            child:
            Container(
              child: ListView(
                children: <Widget>[
                  Container(height: 20,color: Colors.transparent,),
                  RowItem(
                    //头像
                    left: "头像",
                    action: [
                      Avatar(CachedNetworkImage(
                        imageUrl: "${uModel.user.avatar}",
                      )),
//                    Icon(Icons.chevron_right)
                    ],
                    onPressed: () {
                      showPub(context);
                    },
                  ),
                  RowItem(
                    //个性签名
                    left: "个性签名",
                    other: Container(width:MediaQuery.of(context).size.width-150 ,
                      child: Text("${user.signature??"空空如也~"}",
                      overflow: TextOverflow.ellipsis,maxLines: 1,
//                    style: TextStyle(color:Colors.grey,),
                    ),),
                    action: <Widget>[Icon(Icons.chevron_right)],
                    onPressed: () {
//                    Navigator.push(context, route);
                    },
                  ),
                  Container(height: 20,color: Colors.transparent,),
                  RowItem(
                    left: "UUID",
                    other: Text("${uModel.user.loginName}"),
                    onPressed: () {showToast("账号不可编辑哦~~");},
                  ),
                  RowItem(
                    left: "昵称",
                    other: TextField(
                      controller: TextEditingController.fromValue(TextEditingValue(
                          text: "${user.userName??uModel.user.userName??""}",
                      )),
                      onChanged: (v){user.userName = v;},
                      decoration: InputDecoration(
                          focusedBorder: InputBorder.none,
                          enabledBorder: InputBorder.none,
                          hintText: "你的昵称"
                      ),
                      style: TextStyle(fontSize: 15),
                    ),
                    action: [
                      Icon(Icons.chevron_right)
                    ],
                    onPressed: () {

                    },
                  ),
                  RowItem(
                    //性别
                    left: "性别",
                    other: Text((user.sex??uModel.user.sex)==1?"男":"女"),
                    onPressed: () {
                      showDialog(
                          context: context,
                          barrierDismissible: false,
                          builder: (BuildContext context) {
                            return GenderChooseDialog(
                                title: '小哥哥小姐姐请选择',
                                onBoyChooseEvent: () {
                                  user.sex = 1;
                                  setState(() {});
                                  Navigator.pop(context);
                                },
                                onGirlChooseEvent: () {
                                  user.sex = 0;
                                  setState(() {});
                                  Navigator.pop(context);
                                });
                          });
                    },
                  ),
                  RowItem(
                    left: "生日",
                    other: Text("${user.birthday??uModel.user.birthday??"未设置"}"),
                    onPressed: () async {
                      var date = await showDatePicker(
                          context: context,
                          initialDate: (user.birthday??uModel.user.birthday)==null?DateTime.now():DateTime.parse(user.birthday??uModel.user.birthday),
                      firstDate: DateTime(1880),
                      lastDate: DateTime.now());
                      if(date!=null){
                        user.birthday = date.toString();
                        showToast("$date");
                        setState(() {

                        });
                      }
                    },
                  ),
                  Container(height: 20,color: Colors.transparent,),
                  RowItem(
                    left: "地址",
                    other: TextField(
                      controller: TextEditingController.fromValue(TextEditingValue(
                          text: "${user.birthday??uModel.user.birthday??""}"
                      )),
                      decoration: InputDecoration(
                          focusedBorder: InputBorder.none,
                          enabledBorder: InputBorder.none,
                          hintText: "你的地址"
                      ),
                    ),
                  ),
                  RowItem(
                    left: "邮箱",
                    other: TextField(
                      controller: TextEditingController.fromValue(TextEditingValue(
                          text: "${user.email??uModel.user.email??""}"
                      )),
                      onChanged: (v){user.email=v;},
                      decoration: InputDecoration(
                          focusedBorder: InputBorder.none,
                          enabledBorder: InputBorder.none,
                          hintText: "你的邮箱"
                      ),
                    ) ,
                  ),
                  RowItem(
                    left: "手机号",
                    other: TextField(
                      controller: TextEditingController.fromValue(TextEditingValue(
                          text: "${user.phonenumber??uModel.user.phonenumber??""}"
                      )),
                      onChanged: (v){user.phonenumber = v;},
                      decoration: InputDecoration(
                          focusedBorder: InputBorder.none,
                          enabledBorder: InputBorder.none,
                          hintText: "你的手机号"
                      ),
                    ) ,
                  ),
                  Container(height: 20,color: Colors.transparent,),
                  SingleChildScrollView(
                    child: ExpansionPanelList(
                      expansionCallback: (index,isExpanded){
                        setState(() {
                          _showSchoolInfo=!_showSchoolInfo;
                        });
                      },
                      children: [
                        ExpansionPanel(
                            isExpanded: _showSchoolInfo,
                            canTapOnHeader: true,
                            headerBuilder: (BuildContext context, bool isExpanded) {
                              print(isExpanded);
                              return InkWell(
                                onTap: (){_showSchoolInfo=!_showSchoolInfo;setState(() {});},
                                child: RowItem(left:"校园 ",other: Text("不可编辑",style: TextStyle(
                                  color: Colors.red,fontSize: 10
                                ),),),
                              );
                            },
                            body: Column(
                              children: <Widget>[
                                // desc 校园相关
                                RowItem(
                                  left: "姓名",
                                  onPressed: () {},
                                ),
                                RowItem(
                                  left: "学校",
                                ),
                                RowItem(
                                  left: "学号",
                                ),
                                RowItem(
                                  left: "院系",
                                ),
                                RowItem(
                                  left: "专业",
                                ),
                                RowItem(
                                  left: "年级",
                                ),
                                RowItem(
                                  left: "班级",
                                ),
                              ],
                            )

                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          )
        );
      },
    );
  }
}


void showPub(context) {
  showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return _shareWidget(context);
      });
}

Widget _shareWidget(context) {
  List<String> nameItems = <String>[
    '拍照',
    '相册',
  ];

  return new Container(
    height: 100.0,
    child: new Column(
      children: <Widget>[
        new Padding(
          padding: EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 0.0),
          child: new Container(
            height: 90,
            child: new GridView.builder(
              gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 5.0,
                  childAspectRatio: 1.0),
              // ignore: missing_return
              itemBuilder: (BuildContext context, int index) {
                if (index == 0) {
                  return new InkWell(
                    child: new Column(
                      children: <Widget>[
                        new Padding(
                          padding: EdgeInsets.fromLTRB(0.0, 6.0, 0.0, 6.0),
                          child: Icon(
                            Icons.ac_unit,
                            size: 50,
                          )),
                        new Text(nameItems[index]),
                      ],
                    ),
                    onTap: () async {
                      await chooseImage(true,context);

                    },
                  );
                }
                if (index == 1) {
                  return new InkWell(
                    child: new Column(
                      children: <Widget>[
                        new Padding(
                            padding: EdgeInsets.fromLTRB(0.0, 6.0, 0.0, 6.0),
                            child: Icon(
                              Icons.ac_unit,
                              size: 50,
                            )),
                        new Text(nameItems[index]),
                      ],
                    ),
                    onTap: () async{
                      await chooseImage(false,context);
                    },
                  );
                }
              },
              itemCount: nameItems.length,
            ),
          ),
        ),
      ],
    ),
  );
}
/**
 * bool isCamer 是否为相机选取照片
 */
Future chooseImage(bool isCamer,context) async {
  File image;
  if (isCamer) {
    image = await ImagePicker.pickImage(source: ImageSource.camera);
  } else {
    image = await ImagePicker.pickImage(source: ImageSource.gallery);
  }
  if(image!=null){
    await Navigator.push(context, SizeRoute(UpdateAvatarPage(image)));
  }
  Navigator.pop(context);
}

