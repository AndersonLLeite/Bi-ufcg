import 'package:flutter/material.dart';

class Data with ChangeNotifier {
  // Dados armazenados
  // Map<String, double> _enrollmentEvolution = {};
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
}
