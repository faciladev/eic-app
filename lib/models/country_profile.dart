class CountryProfile {
  final int id;
  final String name;
  final dynamic content;

  CountryProfile({
    this.id,
    this.name,
    this.content,
  });

  factory CountryProfile.fromJson(Map<String, dynamic> json) {
    return CountryProfile(
      id: json['id'],
      content: json['content'],
      name: json['name'],
    );
  }
}
