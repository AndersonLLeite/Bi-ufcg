class Campus {
  String name;
  int id;

  Campus({required this.name, required this.id});

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'id': id,
    };
  }

  factory Campus.fromMap(Map<String, dynamic> map) {
    return Campus(
      name: map['name'] ?? '',
      id: map['id'] ?? 0,
    );
  }
}
