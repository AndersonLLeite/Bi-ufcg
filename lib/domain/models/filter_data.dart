import 'campus.dart';
import 'centro.dart';
import 'curso.dart';

class FilterData {
  String? startTerm;
  String? endTerm;
  List<Centro>? centro;
  List<Campus>? campus;
  List<Curso>? cursos;
  List<String>? terms;

  FilterData({
    this.startTerm,
    this.endTerm,
    this.centro,
    this.campus,
    this.cursos,
    this.terms,
  });

  Map<String, dynamic> toMap() {
    return {
      'startTerm': startTerm,
      'endTerm': endTerm,
      'centros': centro?.map((centro) => centro.toMap()).toList(),
      'campus': campus?.map((campusItem) => campusItem.toMap()).toList(),
      'cursos': cursos?.map((curso) => curso.toMap()).toList(),
      'terms': terms,
    };
  }

  factory FilterData.fromMap(Map<String, dynamic> map) {
    return FilterData(
      startTerm: map['startTerm'] ?? '',
      endTerm: map['endTerm'] ?? '',
      centro: (map['centros'] as List<dynamic>?)
          ?.map((e) => Centro.fromMap(e))
          .toList(),
      campus: (map['campus'] as List<dynamic>?)
          ?.map((e) => Campus.fromMap(e))
          .toList(),
      cursos: (map['cursos'] as List<dynamic>?)
          ?.map((e) => Curso.fromMap(e))
          .toList(),
      terms: List<String>.from(map['terms'] ?? []),
    );
  }

  @override
  String toString() {
    return 'Filter(startTerm: $startTerm, endTerm: $endTerm, centros: $centro, campus: $campus, cursos: $cursos, terms: $terms)';
  }
}
