import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_app2/pages/wights/show_image.dart';

/**
 * @createDate  2020/4/30
 */
class GridViewNithWight extends StatefulWidget {

  List<String> urls;


  GridViewNithWight(this.urls);

  @override
  _State createState() => _State(urls);

}

class _State extends State<GridViewNithWight> {
  List<String> urls;

  _State(this.urls);

  @override
  Widget build(BuildContext context) {
    return gridViewNithWight(urls,context);
  }


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
}