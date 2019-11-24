class Service {
  final int id;
  final String name;
  final List<dynamic> requirements;

  Service({
    this.id,
    this.name,
    this.requirements,
  });

  factory Service.fromJson(Map<String, dynamic> json) {
    return Service(
        id: json['id'],
        name: json['NameEnglish'],
        requirements: json['Requirements']);
  }
}
