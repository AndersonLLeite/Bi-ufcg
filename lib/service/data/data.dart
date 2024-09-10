import 'package:bi_ufcg/models/student.dart';
import 'package:flutter/material.dart';

class Data with ChangeNotifier {
  // Dados armazenados
  Map<String, int> _enrollmentEvolution = {};
  Map<String, Map<String, int>> _genderDistribution = {};
  Map<String, Map<String, int>> _ageDistribution = {};
  Map<String, Map<String, int>> _affirmativePolicyDistribution = {};
  Map<String, Map<String, int>> _statusDistribution = {};
  Map<String, Map<String, int>> _inactivityReasonsDistribution = {};
  Map<String, Map<String, int>> _admissionTypeDistribution = {};
  Map<String, Map<String, int>> _secondarySchoolTypeDistribution = {};

  // Getters
  Map<String, int> get enrollmentEvolution => _enrollmentEvolution;
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

  // Setters com notificações

  void setEnrollmentEvolution(Map<String, int> enrollmentEvolution) {
    _enrollmentEvolution = enrollmentEvolution;
    notifyListeners();
  }

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
}
