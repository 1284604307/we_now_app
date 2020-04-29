import 'package:flutter_app2/common/pojos/User.dart';
import 'package:json_annotation/json_annotation.dart';

import 'Comment.dart';
import 'TagsBean.dart';
/**
 * @createDate  2020/4/26
 */
part 'Article.g.dart';

@JsonSerializable()
class Article {
  int id;
  String title;
  // desc 内容简述
  String prefix;
  // desc 内容
  String content;
  DateTime createTime;
  List<String> url;
  List<Comment> comments;
  // desc 类型分 本地 和 外链
  String type;
  String link;
  // desc 展示小图 如果有
  String envelopePic;
  // desc 标签 那些跟随的小件
  List<TagsBean> tags;
  // desc 访问量
  int visible;
  // desc 点赞数量
  num likeCount;
  num commentCount;
  // desc 当前用户关联标记
  bool collect;
  bool like;
  // desc 新文章 (权重++ )
  bool fresh;
  // 置顶
  bool top;

  num userId;
  User user;

  Article();

  factory Article.fromJson(Map<String, dynamic> json) => _$ArticleFromJson(json);
  Map<String, dynamic> toJson() => _$ArticleToJson(this);


}