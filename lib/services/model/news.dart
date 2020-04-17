class News{
  String id;
  String name;
  String content;


  News(this.id, this.name, this.content);
//  String id;

  factory News.fromJson(dynamic json){
    return News(
      json['id'],
      json['name'],
      json['content']
    );
  }
}

class NewsListModal{

  List<News> data;
  NewsListModal(this.data);

  factory NewsListModal.fromJson(List json){
    return NewsListModal(
      json.map(
              (i) => News.fromJson(
                  (i))).toList()
    );
  }
}