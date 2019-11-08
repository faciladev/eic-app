class Sector {
  final int id;
  final String image;
  final String name;
  final String url;
  final dynamic content;

  Sector({
    this.id,
    this.image,
    this.name,
    this.url,
    this.content,
  });

  factory Sector.fromJson(Map<String, dynamic> json) {
    return Sector(
      id: json['id'],
      content: json['content'],
      image: json['image'] != null
          ? 'http://www.investethiopia.gov.et' + json['image']
          : '',
      name: json['name'],
      url: json['url'],
    );
  }
}
