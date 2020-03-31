class Opportunity {
  final int id;
  final String name;
  final dynamic content;

  Opportunity({
    this.id,
    this.name,
    this.content,
  });

  Map<String, dynamic> toMap() {
    return {"id": id, "name": name, "content": content};
  }

  factory Opportunity.fromJson(Map<String, dynamic> json) {
    return Opportunity(
      id: json['id'],
      content: json['content'],
      name: json['name'],
    );
  }
}
