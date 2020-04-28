import 'package:flutter/cupertino.dart';
import 'package:flutter_swiper/flutter_swiper.dart';

/**
 * @author Ming
 * @date 2020/4/18
 * @email 1284604307@qq.com
 */
class BannerWiget extends StatelessWidget{

  List<String> banners = <String>[
    'assets/images/banners/banner1.jpg',
    'assets/images/banners/banner2.jpg',
    'assets/images/banners/banner3.jpg',
    'assets/images/banners/banner4.jpg',
  ];

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = width * 540.0/1080.0;



    return Container(
        width: width,
        height: height,
        //轮播组件
        child:Container(
          child:Swiper(
            itemBuilder: (BuildContext c,index){
              return
                ClipRRect(
                    borderRadius: BorderRadius.circular(20.0),
                    child:Container(
                      margin: EdgeInsets.all(5),
                      child: Image.asset(
                        banners[index],
                        width: width,
                        height: height,
                        fit: BoxFit.cover,),
                    )
                );
            },
            itemCount: banners.length,
            scrollDirection: Axis.horizontal,
            autoplay: true,
          ),
        )
    );
  }

}