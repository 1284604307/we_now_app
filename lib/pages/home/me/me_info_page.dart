import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
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
  bool _showSchoolInfo = true;
  var gender = "男";
  @override
  Widget build(BuildContext context) {
    return Consumer<UserModel>(
      builder: (c, userModel, child) {
        User user = userModel.user;
        return Scaffold(
          appBar: AppBar(
            title: Text("个人信息"),
            actions: <Widget>[
              Padding(
                padding: EdgeInsets.only(right: 15),
                child: InkWell(
                  onTap: () {
                    showToast("保存！");
                  },
                  child: Center(
                    child: Text("保存"),
                  ),
                ),
              ),
            ],
          ),
          body: Container(
            child: ListView(
              children: <Widget>[
                RowItem(
                  //头像
                  left: "头像",
                  action: [
                    Avatar(CachedNetworkImage(
                      imageUrl: "${user.avatar}",
                    )),
//                    Icon(Icons.chevron_right)
                  ],
                  onPressed: () {
                    showPub(context);
                  },
                ),
                RowItem(
                  //头像
                  left: "账号",
                  other: Text("${user.userName}"),
                  onPressed: () {showToast("账号不可编辑哦~~");},
                ),
                RowItem(
                  //头像
                  left: "昵称",
                  other: Text("${user.userName}"),
                  action: [
                    Icon(Icons.chevron_right)
                  ],
                  onPressed: () {

                  },
                ),
                RowItem(
                  //个性签名
                  left: "个性签名",
                  other: Text("你的个性你来定义~d=====(￣▽￣*)b",
                    overflow: TextOverflow.ellipsis,maxLines: 1,
//                    style: TextStyle(color:Colors.grey,),
                  ),
                  action: <Widget>[Icon(Icons.chevron_right)],
                  onPressed: () {
                    showDialog(
                        context: context,
                        barrierDismissible: false,
                        builder: (BuildContext context) {
                          return Signaturediglog(
                            SignatureText: () {

                            },
                          );
                        });
                  },
                ),
                RowItem(
                  //性别
                  left: "性别",
                  other: Text(gender),
                  action: <Widget>[Icon(Icons.chevron_right)],
                  onPressed: () {
                    showDialog(
                        context: context,
                        barrierDismissible: false,
                        builder: (BuildContext context) {
                          return GenderChooseDialog(
                              title: '小哥哥小姐姐请选择',
                              onBoyChooseEvent: () {
                                gender = "男";
                                setState(() {

                                });
                                Navigator.pop(context);
                              },
                              onGirlChooseEvent: () {
                                gender = "女";
                                setState(() {

                                });
                                Navigator.pop(context);
                              });
                        });
                  },
                ),
                RowItem(
                  left: "生日",
                ),
                RowItem(
                  left: "地址",
                ),
                ExpansionPanelList(
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
                              child: RowItem(left:"校园信息"),
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
              ],
            ),
          ),
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

