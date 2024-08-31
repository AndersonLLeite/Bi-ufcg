import 'package:flutter/material.dart';

class Data with ChangeNotifier {
  // Dados armazenados
  Map<String, int> _enrollmentEvolution = {};
  Map<String, Map<String, int>> _genderDistribution = {};
  Map<String, Map<String, int>> _ageDistribution = {};
  Map<String, Map<String, int>> _affirmativePolicyDistribution = {};
  Map<String, Map<String, int>> _activeInactiveDistribution = {};

  // Getters
  Map<String, int> get enrollmentEvolution => _enrollmentEvolution;
  Map<String, Map<String, int>> get genderDistribution => _genderDistribution;
  Map<String, Map<String, int>> get ageDistribution => _ageDistribution;
  Map<String, Map<String, int>> get affirmativePolicyDistribution =>
      _affirmativePolicyDistribution;
  Map<String, Map<String, int>> get activeInactiveDistribution =>
      _activeInactiveDistribution;

  // Setters com notificações
  void setEnrollmentEvolution(Map<String, int> data) {
    _enrollmentEvolution = data;
    notifyListeners();
  }

  void setGenderDistribution(Map<String, Map<String, int>> data) {
    _genderDistribution = data;
    notifyListeners();
  }

  void setAgeDistribution(Map<String, Map<String, int>> data) {
    _ageDistribution = data;
    notifyListeners();
  }

  void setAffirmativePolicyDistribution(Map<String, Map<String, int>> data) {
    _affirmativePolicyDistribution = data;
    notifyListeners();
  }

  void setActiveInactiveDistribution(Map<String, Map<String, int>> data) {
    _activeInactiveDistribution = data;
    notifyListeners();
  }

  // Métodos para atualizar dados individuais se necessário
  void updateEnrollmentEvolution(Map<String, int> enrollmentEvolution) {
    _enrollmentEvolution = enrollmentEvolution;
    notifyListeners();
  }

  void updateGenderDistribution(
      Map<String, Map<String, int>> genderDistribution) {
    _genderDistribution = genderDistribution;

    notifyListeners();
  }

  void updateAgeDistribution(Map<String, Map<String, int>> ageDistribution) {
    _ageDistribution = ageDistribution;
    notifyListeners();
  }

  void updateAffirmativePolicyDistribution(
      Map<String, Map<String, int>> affirmativePolicyDistribution) {
    _affirmativePolicyDistribution = affirmativePolicyDistribution;
    notifyListeners();
  }

  void updateActiveInactiveDistribution(
      Map<String, Map<String, int>> activeInactiveDistribution) {
    _activeInactiveDistribution = activeInactiveDistribution;
    notifyListeners();
  }
}
