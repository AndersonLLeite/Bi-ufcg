class Curso {
  String name;
  int id;

  Curso({required this.name, required this.id});

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'id': id,
    };
  }

  factory Curso.fromMap(Map<String, dynamic> map) {
    return Curso(
      name: map['name'] ?? '',
      id: map['id'] ?? 0,
    );
  }
}
