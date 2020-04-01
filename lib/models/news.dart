import 'package:intl/intl.dart';

class News {
  final int id;
  final String image;
  final String title;
  final String url;
  final dynamic content;
  final String published;

  News(
      {this.id,
      this.image,
      this.title,
      this.url,
      this.content,
      this.published});

  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "title": title,
      "image": image,
      "url": url,
      "content": content,
      "published": published,
    };
  }

  factory News.fromJson(Map<String, dynamic> json) {
    return News(
      id: json['id'],
      content: json['content'],
      image: json['image'],
      published: DateFormat.yMMMd().format(DateTime.parse(json['published'])),
      title: json['title'],
      url: json['url'],
    );
  }
}
