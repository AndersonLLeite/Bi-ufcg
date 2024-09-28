import 'dart:convert';

import 'package:bi_ufcg/models/student.dart';
import 'package:flutter/foundation.dart';

class Course {
  int codigoDoCurso;
  String descricao;
  String status;
  int codigoDoSetor;
  String nomeDoSetor;
  List<Student>? students;

  String? grauDoCurso;
  int? campus;
  String? nomeDoCampus;
  String? turno;
  String? periodoDeInicio;
  String? dataDeFuncionamento;
  int? codigoInep;
  String? modalidadeAcademica;
  int? curriculoAtual;
  int? areaDeRetencao;
  int? cicloEnade;

  Course({
    required this.codigoDoCurso,
    required this.descricao,
    required this.status,
    required this.codigoDoSetor,
    required this.nomeDoSetor,
    this.students,
    this.grauDoCurso,
    this.campus,
    this.nomeDoCampus,
    this.turno,
    this.periodoDeInicio,
    this.dataDeFuncionamento,
    this.codigoInep,
    this.modalidadeAcademica,
    this.curriculoAtual,
    this.areaDeRetencao,
    this.cicloEnade,
  });

  // Factory para criar um objeto Course a partir de um Map
  factory Course.fromMap(Map<String, dynamic> map) {
    return Course(
      codigoDoCurso: map['codigo_do_curso'],
      descricao: map['descricao'],
      status: map['status'],
      codigoDoSetor: map['codigo_do_setor'],
      nomeDoSetor: map['nome_do_setor'],
      students: map['students'] != null
          ? List<Student>.from(map['students'].map((x) => Student.fromMap(x)))
          : null,
      grauDoCurso: map['grau_do_curso'],
      campus: map['campus'],
      nomeDoCampus: map['nome_do_campus'],
      turno: map['turno'],
      periodoDeInicio: map['periodo_de_inicio'],
      dataDeFuncionamento: map['data_de_funcionamento'],
      codigoInep: map['codigo_inep'],
      modalidadeAcademica: map['modalidade_academica'],
      curriculoAtual: map['curriculo_atual'],
      areaDeRetencao: map['area_de_retencao'],
      cicloEnade: map['ciclo_enade'],
    );
  }

  // Factory para criar um objeto Course a partir de um JSON
  factory Course.fromJson(String source) => Course.fromMap(json.decode(source));

  // Método para converter o objeto Course em um Map
  Map<String, dynamic> toMap() {
    return {
      'codigo_do_curso': codigoDoCurso,
      'descricao': descricao,
      'status': status,
      'codigo_do_setor': codigoDoSetor,
      'nome_do_setor': nomeDoSetor,
      'students': students?.map((x) => x.toMap()).toList(),
      'grau_do_curso': grauDoCurso,
      'campus': campus,
      'nome_do_campus': nomeDoCampus,
      'turno': turno,
      'periodo_de_inicio': periodoDeInicio,
      'data_de_funcionamento': dataDeFuncionamento,
      'codigo_inep': codigoInep,
      'modalidade_academica': modalidadeAcademica,
      'curriculo_atual': curriculoAtual,
      'area_de_retencao': areaDeRetencao,
      'ciclo_enade': cicloEnade,
    };
  }

  // Método para converter o objeto Course em JSON
  String toJson() => json.encode(toMap());

  @override
  String toString() {
    return 'Course(codigoDoCurso: $codigoDoCurso, descricao: $descricao, status: $status, codigoDoSetor: $codigoDoSetor, nomeDoSetor: $nomeDoSetor, students: $students grauDoCurso: $grauDoCurso, campus: $campus, nomeDoCampus: $nomeDoCampus, turno: $turno, periodoDeInicio: $periodoDeInicio, dataDeFuncionamento: $dataDeFuncionamento, codigoInep: $codigoInep, modalidadeAcademica: $modalidadeAcademica, curriculoAtual: $curriculoAtual, areaDeRetencao: $areaDeRetencao, cicloEnade: $cicloEnade)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Course &&
        other.codigoDoCurso == codigoDoCurso &&
        other.descricao == descricao &&
        other.status == status &&
        other.codigoDoSetor == codigoDoSetor &&
        other.nomeDoSetor == nomeDoSetor &&
        listEquals(other.students, students) &&
        other.grauDoCurso == grauDoCurso &&
        other.campus == campus &&
        other.nomeDoCampus == nomeDoCampus &&
        other.turno == turno &&
        other.periodoDeInicio == periodoDeInicio &&
        other.dataDeFuncionamento == dataDeFuncionamento &&
        other.codigoInep == codigoInep &&
        other.modalidadeAcademica == modalidadeAcademica &&
        other.curriculoAtual == curriculoAtual &&
        other.areaDeRetencao == areaDeRetencao &&
        other.cicloEnade == cicloEnade;
  }

  @override
  int get hashCode {
    return codigoDoCurso.hashCode ^
        descricao.hashCode ^
        status.hashCode ^
        codigoDoSetor.hashCode ^
        nomeDoSetor.hashCode ^
        students.hashCode ^
        grauDoCurso.hashCode ^
        campus.hashCode ^
        nomeDoCampus.hashCode ^
        turno.hashCode ^
        periodoDeInicio.hashCode ^
        dataDeFuncionamento.hashCode ^
        codigoInep.hashCode ^
        modalidadeAcademica.hashCode ^
        curriculoAtual.hashCode ^
        areaDeRetencao.hashCode ^
        cicloEnade.hashCode;
  }
}
