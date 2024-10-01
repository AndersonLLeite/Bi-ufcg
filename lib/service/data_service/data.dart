import 'dart:convert';
import 'dart:html';

import 'package:csv/csv.dart';
import 'package:flutter/material.dart';

class Data with ChangeNotifier {
  Map<String, Map<String, double>> _genderDistribution = {};
  Map<String, Map<String, double>> _ageDistribution = {};
  Map<String, Map<String, double>> _affirmativePolicyDistribution = {};
  Map<String, Map<String, double>> _statusDistribution = {};
  Map<String, Map<String, double>> _inactivityReasonsDistribution = {};
  Map<String, Map<String, double>> _admissionTypeDistribution = {};
  Map<String, Map<String, double>> _secondarySchoolTypeDistribution = {};
  Map<String, Map<String, double>> _originDistribution = {};
  Map<String, Map<String, double>> _colorDistribution = {};
  Map<String, Map<String, double>> _disabilitiesDistribution = {};
  Map<String, Map<String, double>> _inactivityPerPeriodoDeEvasaoDistribution =
      {};
  Map<String, Map<String, double>> _ageAtEnrollmentDistribution = {};
  Map<String, Map<String, double>> _creditCompletedVsFailedDistribution = {};
  Map<String, Map<String, double>> _evasionStatisticsByEvasionPeriod = {};
  Map<String, Map<String, double>> _graduationStatisticsByEvasionPeriod = {};
  Map<String, Map<String, double>> _evasionByColor = {};
  Map<String, Map<String, double>> _evasionByAge = {};
  Map<String, Map<String, double>> _evasionByGender = {};
  Map<String, Map<String, double>> _evasionByAdmissionType = {};
  Map<String, Map<String, double>> _evasionBySecondarySchoolType = {};
  Map<String, Map<String, double>> _evasionByDisabilities = {};

  // Getters
  //Map<String, double> get enrollmentEvolution => _enrollmentEvolution;
  Map<String, Map<String, double>> get genderDistribution =>
      _genderDistribution;
  Map<String, Map<String, double>> get ageDistribution => _ageDistribution;
  Map<String, Map<String, double>> get affirmativePolicyDistribution =>
      _affirmativePolicyDistribution;
  Map<String, Map<String, double>> get statusDistribution =>
      _statusDistribution;
  Map<String, Map<String, double>> get inactivityReasonsDistribution =>
      _inactivityReasonsDistribution;
  Map<String, Map<String, double>> get admissionTypeDistribution =>
      _admissionTypeDistribution;
  Map<String, Map<String, double>> get secondarySchoolTypeDistribution =>
      _secondarySchoolTypeDistribution;
  Map<String, Map<String, double>> get originDistribution =>
      _originDistribution;
  Map<String, Map<String, double>> get colorDistribution => _colorDistribution;
  Map<String, Map<String, double>> get disabilitiesDistribution =>
      _disabilitiesDistribution;
  Map<String, Map<String, double>>
      get inactivityPerPeriodoDeEvasaoDistribution =>
          _inactivityPerPeriodoDeEvasaoDistribution;
  Map<String, Map<String, double>> get ageAtEnrollmentDistribution =>
      _ageAtEnrollmentDistribution;
  Map<String, Map<String, double>> get creditCompletedVsFailedDistribution =>
      _creditCompletedVsFailedDistribution;

  Map<String, Map<String, double>> get evasionStatisticsByEvasionPeriod =>
      _evasionStatisticsByEvasionPeriod;
  Map<String, Map<String, double>> get graduationStatisticsByEvasionPeriod =>
      _graduationStatisticsByEvasionPeriod;
  Map<String, Map<String, double>> get evasionByColor => _evasionByColor;
  Map<String, Map<String, double>> get evasionByAge => _evasionByAge;
  Map<String, Map<String, double>> get evasionByGender => _evasionByGender;
  Map<String, Map<String, double>> get evasionByAdmissionType =>
      _evasionByAdmissionType;
  Map<String, Map<String, double>> get evasionBySecondarySchoolType =>
      _evasionBySecondarySchoolType;
  Map<String, Map<String, double>> get evasionByDisabilities =>
      _evasionByDisabilities;

  // Setters com notificações

  // void setEnrollmentEvolution(Map<String, double> enrollmentEvolution) {
  //   _enrollmentEvolution = enrollmentEvolution;
  //   notifyListeners();
  // }

  void setGenderDistribution(
      Map<String, Map<String, double>> genderDistribution) {
    _genderDistribution = genderDistribution;
    notifyListeners();
  }

  void setAgeDistribution(Map<String, Map<String, double>> ageDistribution) {
    _ageDistribution = ageDistribution;
    notifyListeners();
  }

  void setAffirmativePolicyDistribution(
      Map<String, Map<String, double>> affirmativePolicyDistribution) {
    _affirmativePolicyDistribution = affirmativePolicyDistribution;
    notifyListeners();
  }

  void setStatusDistribution(
      Map<String, Map<String, double>> statusDistribution) {
    _statusDistribution = statusDistribution;
    notifyListeners();
  }

  void setInactivityReasonDistribution(
      Map<String, Map<String, double>> inactivityReasonDistribution) {
    _inactivityReasonsDistribution = inactivityReasonDistribution;
    notifyListeners();
  }

  void setAdmissionTypeDistribution(
      Map<String, Map<String, double>> admissionTypeDistribution) {
    _admissionTypeDistribution = admissionTypeDistribution;
    notifyListeners();
  }

  void setSecondarySchoolTypeDistribution(
      Map<String, Map<String, double>> secondarySchoolTypeDistribution) {
    _secondarySchoolTypeDistribution = secondarySchoolTypeDistribution;
    notifyListeners();
  }

  void setOriginDistribution(
      Map<String, Map<String, double>> originDistribution) {
    _originDistribution = originDistribution;
    notifyListeners();
  }

  void setColorDistribution(
      Map<String, Map<String, double>> colorDistribution) {
    _colorDistribution = colorDistribution;
    notifyListeners();
  }

  void setDisabilitiesDistribution(
      Map<String, Map<String, double>> disabilitiesDistribution) {
    _disabilitiesDistribution = disabilitiesDistribution;
    notifyListeners();
  }

  void setInactivityPerPeriodoDeEvasaoDistribution(
      Map<String, Map<String, double>>
          inactivityPerPeriodoDeEvasaoDistribution) {
    _inactivityPerPeriodoDeEvasaoDistribution =
        inactivityPerPeriodoDeEvasaoDistribution;
    notifyListeners();
  }

  void setAgeAtEnrollmentDistribution(
      Map<String, Map<String, double>> ageAtEnrollmentDistribution) {
    _ageAtEnrollmentDistribution = ageAtEnrollmentDistribution;
    notifyListeners();
  }

  void setCreditCompletedVsFailedDistribution(
      Map<String, Map<String, double>> creditCompletedVsFailedDistribution) {
    _creditCompletedVsFailedDistribution = creditCompletedVsFailedDistribution;
    notifyListeners();
  }

  void setEvasionStatisticsByEvasionPeriod(
      Map<String, Map<String, double>> evasionStatisticsByPeriod) {
    _evasionStatisticsByEvasionPeriod = evasionStatisticsByPeriod;
    notifyListeners();
  }

  void setGraduationStatisticsByEvasionPeriod(
      Map<String, Map<String, double>> graduationStatisticsByPeriod) {
    _graduationStatisticsByEvasionPeriod = graduationStatisticsByPeriod;
    notifyListeners();
  }

  void setEvasionByColor(Map<String, Map<String, double>> evasionByColor) {
    _evasionByColor = evasionByColor;
    notifyListeners();
  }

  void setEvasionByAge(Map<String, Map<String, double>> evasionByAge) {
    _evasionByAge = evasionByAge;
    notifyListeners();
  }

  void setEvasionByGender(Map<String, Map<String, double>> evasionByGender) {
    _evasionByGender = evasionByGender;
    notifyListeners();
  }

  void setEvasionByAdmissionType(
      Map<String, Map<String, double>> evasionByAdmissionType) {
    _evasionByAdmissionType = evasionByAdmissionType;
    notifyListeners();
  }

  void setEvasionBySecondarySchoolType(
      Map<String, Map<String, double>> evasionBySecondarySchoolType) {
    _evasionBySecondarySchoolType = evasionBySecondarySchoolType;
    notifyListeners();
  }

  void setEvasionByDisabilities(
      Map<String, Map<String, double>> evasionByDisabilities) {
    _evasionByDisabilities = evasionByDisabilities;
    notifyListeners();
  }

  //TODO essa função só serve para a versão web
  void exportToCsv() {
    List<List<dynamic>> rows = [];

    rows.add(["Período", "Categoria", "Subcategoria", "Valor"]);

    // Função para ordenar os períodos e adicionar os dados na sequência correta
    void addDataToRows(String category, Map<String, Map<String, double>> data) {
      var sortedPeriods = data.keys.toList()
        ..sort((a, b) => a.compareTo(b)); // Ordena os períodos
      for (var period in sortedPeriods) {
        var values = data[period];
        values?.forEach((subCategory, value) {
          rows.add([period, category, subCategory, value]);
        });
      }
    }

    addDataToRows("Gênero", _genderDistribution);
    addDataToRows("Idade", _ageDistribution);
    addDataToRows("Política Afirmativa", _affirmativePolicyDistribution);
    addDataToRows("Status", _statusDistribution);
    addDataToRows("Razões de Inatividade", _inactivityReasonsDistribution);
    addDataToRows("Tipo de Admissão", _admissionTypeDistribution);
    addDataToRows(
        "Tipo de Escola Secundária", _secondarySchoolTypeDistribution);
    addDataToRows("Origem", _originDistribution);
    addDataToRows("Cor", _colorDistribution);
    addDataToRows("Deficiências", _disabilitiesDistribution);
    addDataToRows("Inatividade por Período de Evasão",
        _inactivityPerPeriodoDeEvasaoDistribution);
    addDataToRows("Idade na Matrícula", _ageAtEnrollmentDistribution);
    addDataToRows(
        "Créditos Completos vs Falhados", _creditCompletedVsFailedDistribution);
    addDataToRows("Estatísticas de Evasão por Período",
        _evasionStatisticsByEvasionPeriod);
    addDataToRows("Estatísticas de Graduação por Período",
        _graduationStatisticsByEvasionPeriod);
    addDataToRows("Evasão por Cor", _evasionByColor);
    addDataToRows("Evasão por Idade", _evasionByAge);
    addDataToRows("Evasão por Gênero", _evasionByGender);
    addDataToRows("Evasão por Tipo de Admissão", _evasionByAdmissionType);
    addDataToRows(
        "Evasão por Tipo de Escola Secundária", _evasionBySecondarySchoolType);
    addDataToRows("Evasão por Deficiências", _evasionByDisabilities);

    // Converte para CSV
    String csv = const ListToCsvConverter().convert(rows);

    // Exportação para Web (Browser)
    final bytes = utf8.encode(csv);
    final blob = Blob([bytes]);
    final url = Url.createObjectUrlFromBlob(blob);
    AnchorElement(href: url)
      ..setAttribute("download", "dados.csv")
      ..click();
    Url.revokeObjectUrl(url);
  }
}
