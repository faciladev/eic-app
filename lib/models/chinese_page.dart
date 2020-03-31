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

  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "name": name,
      "image": image,
      "content": content,
    };
  }

  factory ChinesePage.fromJson(Map<String, dynamic> json) {
    return ChinesePage(
      id: json['id'],
      image: json['image'],
      content: json['content'],
      name: json['name'],
    );
  }
}
