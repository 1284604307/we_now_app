import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_app2/pages/home/topic/topic_page.dart';
import 'package:flutter_app2/pages/wights/article/parsed_text.dart';
import 'package:flutter_app2/pages/wights/page_route_anim.dart';
import 'package:oktoast/oktoast.dart';
import 'package:path/path.dart';

import 'match_text.dart';

/**
 * @createDate  2020/5/16
 */

Widget  textContent(String mTextContent, BuildContext context,bool isDetail){
  if(!isDetail){
    //如果字数过长
    if (mTextContent.length > 150) {
      mTextContent = mTextContent.substring(0, 148) + ' ... '+'全文';
    }
  }
  mTextContent= mTextContent.replaceAll("\\n", "\n");
  return Container(
      alignment: FractionalOffset.centerLeft,
      child:

      ParsedText(

        text: mTextContent,
        style: TextStyle(
          height: 1.5,
          fontSize: 15,
          color: Colors.black,
        ),
        parse: <MatchText>[
          MatchText(
              pattern: r"\[(@[^:]+):([^\]]+)\]",
              style: TextStyle(
                color: Color(0xff5B778D),
                fontSize: 15,
              ),
              renderText: ({String str, String pattern}) {
                Map<String, String> map = Map<String, String>();
                RegExp customRegExp = RegExp(pattern);
                Match match = customRegExp.firstMatch(str);
                map['display'] = match.group(1);
                map['value'] = match.group(2);
                print("正则:" + match.group(1) + "---" + match.group(2));
                return map;
              },
              onTap: (content,contentId) {
//                 showDialog(
//                  context: context,
//                  builder: (BuildContext context) {
//                    // return object of type Dialog
//                    return AlertDialog(
//                      title: new Text("Mentions clicked"),
//                      content: new Text("$url clicked."),
//                      actions: <Widget>[
//                        // usually buttons at the bottom of the dialog
//                        new FlatButton(
//                          child: new Text("Close"),
//                          onPressed: () {},
//                        ),
//                      ],
//                    );
//                  },
//                );
                showToast("跳转到相关人详情页");

//                  Routes.navigateTo(context, Routes.personinfoPage,params: {
//                    'userid':   contentId,
//                  } );
              }),
          MatchText(
              pattern: '#.*?#',
              //       pattern: r"\B#+([\w]+)\B#",
              //   pattern: r"\[(#[^:]+):([^#]+)\]",
              style: TextStyle(
                color: Color(0xff5B778D),
                fontSize: 15,
              ),
              renderText: ({String str, String pattern}) {
                Map<String, String> map = Map<String, String>();

                String idStr =
                str.substring(str.indexOf(":") + 1, str.lastIndexOf("#"));
                String showStr = str
                    .substring(str.indexOf("#"), str.lastIndexOf("#") + 1)
                    .replaceAll(":" + idStr, "");
                map['display'] = showStr;
                map['value'] = idStr;
                //   print("正则:"+str+"---"+idStr+"--"+startIndex.toString()+"--"+str.lastIndexOf("#").toString());

                return map;
              },
              onTap: (String content,String contentId) async {
                Navigator.push(context, SizeRoute(TopicPage(topicName: content.replaceAll("#", ""),)));
            }),
          MatchText(
            pattern: '(\\[/).*?(\\])',
            //       pattern: r"\B#+([\w]+)\B#",
            //   pattern: r"\[(#[^:]+):([^#]+)\]",
            style: TextStyle(
              fontSize: 15,
            ),
            renderText: ({String str, String pattern}) {
              Map<String, String> map = Map<String, String>();
              print("表情的正则:" + str);
              String mEmoji2 = "";
              try {
                String mEmoji = str.replaceAll(RegExp('(\\[/)|(\\])'), "");
                int mEmojiNew = int.parse(mEmoji);
                mEmoji2 = String.fromCharCode(mEmojiNew);
              } on Exception catch (_) {
                mEmoji2 = str;
              }
              map['display'] = mEmoji2;

              return map;
            },
          ),
          MatchText(
              pattern: '全文',
              //       pattern: r"\B#+([\w]+)\B#",
              //   pattern: r"\[(#[^:]+):([^#]+)\]",
              style: TextStyle(
                color: Color(0xff5B778D),
                fontSize: 15,
              ),
              renderText: ({String str, String pattern}) {
                Map<String, String> map = Map<String, String>();
                map['display'] =  '全文';
                map['value'] =  '全文';
                return map;
              },
              onTap: (display,value) async {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: new Text("Mentions clicked"),
                      content: new Text("点击全文了" ),
                      actions: <Widget>[
                        // usually buttons at the bottom of the dialog
                        new FlatButton(
                          child: new Text("Close"),
                          onPressed: () {},
                        ),
                      ],
                    );
                  },
                );
              }),


        ],
      ));
}
