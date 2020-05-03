import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app2/common/pojos/User.dart';
import 'package:flutter_app2/pages/wights/LittleWidgets.dart';
import 'package:flutter_app2/pages/wights/avatar.dart';
import 'package:flutter_app2/services/model/viewModel/user_model.dart';
import 'package:oktoast/oktoast.dart';
import 'package:provider/provider.dart';

/**
 * @createDate  2020/5/3
 */
class MeInfoPage extends StatefulWidget {

  @override
  _State createState() => _State();

}

class _State extends State<MeInfoPage> {

  @override
  Widget build(BuildContext context) {
    return Consumer<UserModel>(
      builder: (c,userModel,child){
        User user = userModel.user;
        return Scaffold(
          appBar: AppBar(
            title: Text("个人信息"),
            actions: <Widget>[
              Padding(
                padding: EdgeInsets.only(right: 15),
                child: InkWell(
                  onTap: (){
                    showToast("保存！");
                  },
                  child:  Center(
                    child: Text("保存"),
                  ),
                ),
              ),

            ],
          ),
          body: Container(
            child: Column(
              children: <Widget>[
                RowItem(left: "头像",action: [
                  Avatar(CachedNetworkImage(imageUrl: "${user.avatar}",)),
                  Icon(Icons.chevron_right)
                ],),
                RowItem(left: "个性签名",other: Text("滑稽滑稽滑稽稽"),
                  action: <Widget>[Icon(Icons.chevron_right)],),
                RowItem(left: "性别",other: Text("男🚹难顶哦"),
                  action: <Widget>[Icon(Icons.chevron_right)],),
                RowItem(left: "生日",),

                // desc 校园相关
                RowItem(left: "姓名",),
                RowItem(left: "学校",),
                RowItem(left: "学号",),
                RowItem(left: "院系",),
                RowItem(left: "专业",),
                RowItem(left: "年级",),
                RowItem(left: "班级",),
              ],
            ),
          ),
        );
      },
    );
  }
}