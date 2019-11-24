class Setting {
  final int id;
  final String name;
  final int value;

  Setting({
    this.id,
    this.name,
    this.value,
  });

  factory Setting.fromJson(Map<String, dynamic> json) {
    return Setting(id: json['id'], name: json['name'], value: json['value']);
  }

  Map<String, dynamic> toMap() {
    return {'id': id, 'name': name, 'value': value};
  }
}
