import 'package:json_annotation/json_annotation.dart';

import 'TagsBean.dart';
/**
 * @createDate  2020/4/26
 */
part 'Article.g.dart';

@JsonSerializable()
class Article {
  int id;
  String link;
  // desc 类型分 本地 和 外链
  int type;
  String author;
  int publishTime;
  String title;
  String description;
  // desc 展示小图 如果有
  String envelopePic;
  // desc 标签 那些跟随的小件
  List<TagsBean> tags;
  // desc 当前文章所属人
  int userId;
  // desc 是否可见
  int visible;
  // desc 点赞数量
  int likeCount;
  // desc 当前用户收藏标记
  bool collect;
  // desc 新文章 (权重++ )
  bool fresh;
  // desc 文章简述
  String prefix;
  // desc 内容
  String content;


  // desc 有该组值 表明 内容为转载内容
  /// desc 分享人
  String shareUser;
  String origin;
  int originId;


  // desc 书 id 如果分章节
  int courseId;
  // desc 章节id  如果分章节
  int chapterId;
  // desc 章节名
  String chapterName;
  // desc 如果章节还细分了，则.....
  int superChapterId;
  String superChapterName;

  Article();

  factory Article.fromJson(Map<String, dynamic> json) => _$ArticleFromJson(json);
  Map<String, dynamic> toJson() => _$ArticleToJson(this);


}