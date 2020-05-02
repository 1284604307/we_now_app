import 'package:json_annotation/json_annotation.dart';

/**
 * @createDate  2020/4/26
 */

part 'Banner.g.dart';

@JsonSerializable()
class Banner  {

  var id;
  String title;
  String content;
  String description;
  String type;
  String url;
  String path;
  var articleId;
  String author;

  Banner();

  factory Banner.fromJson(Map<String, dynamic> json) => _$BannerFromJson(json);
  Map<String, dynamic> toJson() => _$BannerToJson(this);
}