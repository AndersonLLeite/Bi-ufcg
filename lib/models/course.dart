import 'dart:convert';

import 'package:bi_ufcg/models/studentv1.dart';
import 'package:flutter/foundation.dart';

class Course {
  String code;
  String name;
  String status;
  List<Studentv1>? students;

  Course({
    required this.code,
    required this.name,
    required this.status,
    this.students,
  });

  factory Course.fromMap(Map<String, dynamic> map) {
    return Course(
      code: map['code'],
      name: map['name'],
      status: map['status'],
      students: map['students'] != null
          ? List<Studentv1>.from(
              map['students'].map((x) => Studentv1.fromJson(x)))
          : null,
    );
  }

  factory Course.fromJson(String source) => Course.fromMap(json.decode(source));

  @override
  String toString() =>
      'Course(code: $code, name: $name, status: $status, students: $students)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Course &&
        other.code == code &&
        other.name == name &&
        other.status == status &&
        listEquals(other.students, students);
  }

  @override
  int get hashCode =>
      code.hashCode ^ name.hashCode ^ status.hashCode ^ students.hashCode;
}
