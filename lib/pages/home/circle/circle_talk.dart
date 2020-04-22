import 'package:dotted_border/dotted_border.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app2/common/Api.dart';
import 'package:flutter_app2/common/entity/CircleEntity.dart';
import 'package:flutter_app2/pages/global/global_config.dart';
import 'package:flutter_app2/wights/show_image.dart';
import 'package:image_picker/image_picker.dart';
import 'package:photo_view/photo_view.dart';

/**
 * @author Ming
 * @date 2020/4/19
 * @email 1284604307@qq.com
 */
Widget talkWidget(count,CircleEntity circle){



  return Container(
    color: Colors.white,
    padding: EdgeInsets.all(15),
    margin: EdgeInsets.only(bottom: 10),
    child: Column(
      children: <Widget>[
        Container(
          padding: EdgeInsets.only(bottom: 5),
          child: Row(
            children: <Widget>[
              ClipRRect(
                borderRadius: BorderRadius.circular(40),
                child:  Container(width: 40,height: 40,color: Colors.black12,),
              ),
              Container(
                margin: EdgeInsets.only(left: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,//垂直方向 向左靠齐
                  children: <Widget>[
                    Text(
                      circle.name,
                      textAlign: TextAlign.left,
                      style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),
                    ),
                    Text(
                      circle.createDate,
                      maxLines: 5,
                      overflow: TextOverflow.clip,
                      textAlign: TextAlign.left,
                    )
                  ],
                ),
              )
            ],
          ),
        ),
        Column(
          children: <Widget>[
            new Container(
                child: new Text(
                    "${circle.content}",
                ),
                margin: new EdgeInsets.only(top: 6.0, bottom: 2.0),
                alignment: Alignment.topLeft
            ),
            // desc 九图组件
            circle.url!=null?gridViewNithWight(circle.url):Container(),
          ],
        )
      ],
    ),
  );
}
// desc 九图展示
gridViewNithWight(List<String> urls){
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
    itemBuilder: (i,c){
      return Container(
        color: Colors.lightBlueAccent,
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

  @override
  Widget build(BuildContext context) {


    TextEditingController contentController = TextEditingController();

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
                print(contentController.toString());
                print(images.toList().toString());
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
              child: TextField(
                controller: contentController,
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
                  return Stack(
                    children: <Widget>[
                      images[index],
                      Stack(
                        children: <Widget>[
                          Positioned(
                            right: 0,
                            top: 0,
                            child: IconButton(
                              icon: Icon(Icons.close),
                              onPressed: (){
                                print(index);
                                images.removeAt(index);
                                setState(() {
                                });
                              },
                            ),
                          )
                        ],
                      ),
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

  Widget selectNewImage(){
//    var _width = (this.context.size.width -40)/3;
    return Listener(
        onPointerDown: (event) async {
          print(event);
          print((this.context.size.width - 40)/3);
          ImagePicker.pickImage(source: ImageSource.gallery).then(
              (image){
                print("image good--------------------- $image ");
                setState(() {

                  images.add(
//                      PhotoView(
//                        imageProvider: FileImage(image),
//                      )
                      GestureDetector(
                        child: ExtendedImage.file(
                          image,width: double.infinity,
                          height: double.infinity,
                          fit: BoxFit.cover,
                        ),
                        onTap: (){
                          print("双击");
                          Navigator.push(context, MaterialPageRoute(builder: (BuildContext context){
                            print(image);
                            return ShowImagePage(image);
                          })
                          );
                        },
                      )
                  );
//                  images.add(ZoomableImage(FileImage(image)));
//                  images.add(Image.file(image,fit: BoxFit.cover,width: double.infinity,height: double.infinity,));
                });
              }
          );
//          images.add(
//              Container(
//                color: Colors.black12,
//              )
//          );
        },
        child:LayoutBuilder(
          builder: (context,con){
            return DottedBorder(
              strokeWidth: 2,
              color: Color.fromRGBO(0, 0, 0, 0.1),
              child: Container(
                child: Icon(Icons.add,size:con.maxWidth,color: Color.fromRGBO(0, 0, 0, 0.12),),
//                decoration: new BoxDecoration(
//                    border: new Border.all(
//                      color: Colors.black38, width: 0.5,
//                    )
//                ),
              ),
            );
        },
        )
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;

}