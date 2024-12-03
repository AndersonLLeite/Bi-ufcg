class Centro {
  String name;
  int id;

  Centro({required this.name, required this.id});

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'id': id,
    };
  }

  factory Centro.fromMap(Map<String, dynamic> map) {
    return Centro(
      name: map['name'] ?? '',
      id: map['id'] ?? 0,
    );
  }
}
