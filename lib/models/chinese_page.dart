class ChinesePage {
  final int id;
  final String name;
  final String image;
  final dynamic content;

  ChinesePage({
    this.id,
    this.name,
    this.image,
    this.content,
  });

  factory ChinesePage.fromJson(Map<String, dynamic> json) {
    return ChinesePage(
      id: json['id'],
      image: json['image'],
      content: json['content'],
      name: json['name'],
    );
  }
}
