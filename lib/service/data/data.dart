import 'package:flutter/material.dart';

class Data with ChangeNotifier {
  // Dados armazenados
  // Map<String, int> _enrollmentEvolution = {};
  Map<String, Map<String, int>> _genderDistribution = {};
  Map<String, Map<String, int>> _ageDistribution = {};
  Map<String, Map<String, int>> _affirmativePolicyDistribution = {};
  Map<String, Map<String, int>> _statusDistribution = {};
  Map<String, Map<String, int>> _inactivityReasonsDistribution = {};
  Map<String, Map<String, int>> _admissionTypeDistribution = {};
  Map<String, Map<String, int>> _secondarySchoolTypeDistribution = {};
  Map<String, Map<String, int>> _originDistribution = {};
  Map<String, Map<String, int>> _colorDistribution = {};
  Map<String, Map<String, int>> _disabilitiesDistribution = {};
  Map<String, Map<String, int>> _inactivityPerPeriodoDeEvasaoDistribution = {};
  Map<String, Map<String, int>> _ageAtEnrollmentDistribution = {};

  // Getters
  //Map<String, int> get enrollmentEvolution => _enrollmentEvolution;
  Map<String, Map<String, int>> get genderDistribution => _genderDistribution;
  Map<String, Map<String, int>> get ageDistribution => _ageDistribution;
  Map<String, Map<String, int>> get affirmativePolicyDistribution =>
      _affirmativePolicyDistribution;
  Map<String, Map<String, int>> get statusDistribution => _statusDistribution;
  Map<String, Map<String, int>> get inactivityReasonsDistribution =>
      _inactivityReasonsDistribution;
  Map<String, Map<String, int>> get admissionTypeDistribution =>
      _admissionTypeDistribution;
  Map<String, Map<String, int>> get secondarySchoolTypeDistribution =>
      _secondarySchoolTypeDistribution;
  Map<String, Map<String, int>> get originDistribution => _originDistribution;
  Map<String, Map<String, int>> get colorDistribution => _colorDistribution;
  Map<String, Map<String, int>> get disabilitiesDistribution =>
      _disabilitiesDistribution;
  Map<String, Map<String, int>> get inactivityPerPeriodoDeEvasaoDistribution =>
      _inactivityPerPeriodoDeEvasaoDistribution;
  Map<String, Map<String, int>> get ageAtEnrollmentDistribution =>
      _ageAtEnrollmentDistribution;

  // Setters com notificações

  // void setEnrollmentEvolution(Map<String, int> enrollmentEvolution) {
  //   _enrollmentEvolution = enrollmentEvolution;
  //   notifyListeners();
  // }

  void setGenderDistribution(Map<String, Map<String, int>> genderDistribution) {
    _genderDistribution = genderDistribution;
    notifyListeners();
  }

  void setAgeDistribution(Map<String, Map<String, int>> ageDistribution) {
    _ageDistribution = ageDistribution;
    notifyListeners();
  }

  void setAffirmativePolicyDistribution(
      Map<String, Map<String, int>> affirmativePolicyDistribution) {
    _affirmativePolicyDistribution = affirmativePolicyDistribution;
    notifyListeners();
  }

  void setStatusDistribution(Map<String, Map<String, int>> statusDistribution) {
    _statusDistribution = statusDistribution;
    notifyListeners();
  }

  void setInactivityReasonDistribution(
      Map<String, Map<String, int>> inactivityReasonDistribution) {
    _inactivityReasonsDistribution = inactivityReasonDistribution;
    notifyListeners();
  }

  void setAdmissionTypeDistribution(
      Map<String, Map<String, int>> admissionTypeDistribution) {
    _admissionTypeDistribution = admissionTypeDistribution;
    notifyListeners();
  }

  void setSecondarySchoolTypeDistribution(
      Map<String, Map<String, int>> secondarySchoolTypeDistribution) {
    _secondarySchoolTypeDistribution = secondarySchoolTypeDistribution;
    notifyListeners();
  }

  void setOriginDistribution(Map<String, Map<String, int>> originDistribution) {
    _originDistribution = originDistribution;
    notifyListeners();
  }

  void setColorDistribution(Map<String, Map<String, int>> colorDistribution) {
    _colorDistribution = colorDistribution;
    notifyListeners();
  }

  void setDisabilitiesDistribution(
      Map<String, Map<String, int>> disabilitiesDistribution) {
    _disabilitiesDistribution = disabilitiesDistribution;
    notifyListeners();
  }

  void setInactivityPerPeriodoDeEvasaoDistribution(
      Map<String, Map<String, int>> inactivityPerPeriodoDeEvasaoDistribution) {
    _inactivityPerPeriodoDeEvasaoDistribution =
        inactivityPerPeriodoDeEvasaoDistribution;
    notifyListeners();
  }

  void setAgeAtEnrollmentDistribution(
      Map<String, Map<String, int>> ageAtEnrollmentDistribution) {
    _ageAtEnrollmentDistribution = ageAtEnrollmentDistribution;
    notifyListeners();
  }
}
