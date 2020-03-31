class StepModel {
  final int id;
  final String name;
  final dynamic content;

  StepModel({
    this.id,
    this.name,
    this.content,
  });

  Map<String, dynamic> toMap() {
    return {"id": id, "name": name, "content": content};
  }

  factory StepModel.fromJson(Map<String, dynamic> json) {
    return StepModel(
      id: json['id'],
      content: json['content'],
      name: json['name'],
    );
  }
}
