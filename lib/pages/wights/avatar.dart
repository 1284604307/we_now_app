import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app2/common/pojos/User.dart';
import 'package:flutter_app2/pages/home/me/me_page.dart';
import 'package:flutter_app2/pages/wights/page_route_anim.dart';
import 'package:flutter_app2/services/config/provider_manager.dart';
import 'package:flutter_app2/services/model/viewModel/UsersModel.dart';
import 'package:flutter_app2/services/net/restful_go.dart';
import 'package:provider/provider.dart';

/**
 * @createDate  2020/4/28
 */
class Avatar extends StatelessWidget {

  Widget header;
  double width;
  double height;
  double borderWidth;
  Color borderColor;
  List<BoxShadow> boxShadow;


  Avatar(this.header,{this.width,this.height,this.borderColor,this.boxShadow});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      width: (width??41),
      height: (height??41),
      decoration: BoxDecoration(
        border: Border.all(color: borderColor??Colors.black12),
        borderRadius: BorderRadius.circular(width??40/2),
        boxShadow: this.boxShadow??null,
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(width??40/2),
        child: header,
      ) ,
    );
  }

}

class AvatarImage extends StatefulWidget{

  String username;

  AvatarImage(this.username);

  @override
  State<StatefulWidget> createState() {
    return _AvatarState(this.username);
  }

}

class _AvatarState extends State<AvatarImage>{

  String username ;
  String avatarPath;
  _AvatarState(this.username);

  @override
  void initState(){
    super.initState();
    print("----获取$username的属性");
    Provider.of<UsersModel>(context,listen: false).get(username).then((user){
      this.avatarPath = user.avatar;
      setState(() {

      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      fit: BoxFit.cover,
      imageUrl: "$avatarPath",);
  }

}

class RectAvatar extends StatelessWidget{

  Widget header;
  double width;
  double height;
  double borderWidth;
  Color borderColor;
  String username;
  List<BoxShadow> boxShadow;

  RectAvatar(this.header,{this.width,this.height,this.borderColor,this.boxShadow,this.username});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
        if(username!=null)
          Navigator.of(context).push(SizeRoute(MePage(username: username,)));
      },
      child: Container(
        width: (width??41),
        height: (height??41),
        decoration: BoxDecoration(
          border: Border.all(color: borderColor??Colors.black12),
          borderRadius: BorderRadius.circular(10),
          boxShadow: this.boxShadow??null,
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: header,
        ) ,
      ),
    );
  }

}