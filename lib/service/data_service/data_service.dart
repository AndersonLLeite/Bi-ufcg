import 'package:bi_ufcg/models/course.dart';

abstract class DataService {
  Map<String, double> getEnrollmentEvolution(
      List<Course> courses, List<String> terms);
  Map<String, Map<String, double>> getGenderDistribution(
      List<Course> courses, List<String> terms);
  Map<String, Map<String, double>> getAgeDistribution(
      List<Course> courses, List<String> terms);
  Map<String, Map<String, double>> getAgeAtEnrollmentDistribution(
      List<Course> courses, List<String> terms);
  Map<String, Map<String, double>> getAffirmativePolicyDistribution(
      List<Course> courses, List<String> terms);
  Map<String, Map<String, double>> getOriginDistribution(
      List<Course> courses, List<String> terms);
  Map<String, Map<String, double>> getColorDistribution(
      List<Course> courses, List<String> terms);
  Map<String, Map<String, double>> getDisabilitiesDistribution(
      List<Course> courses, List<String> terms);

  Map<String, Map<String, double>> getStatusDistribution(
      List<Course> courses, List<String> terms);
  Map<String, Map<String, double>> getInactivityReasonDistribution(
      List<Course> courses, List<String> terms);
  Map<String, Map<String, double>> getAdmissionTypeDistribution(
      List<Course> courses, List<String> terms);
  Map<String, Map<String, double>> getSecondarySchoolTypeDistribution(
      List<Course> courses, List<String> terms);
  Map<String, Map<String, double>> getInactivityPerPeriodoDeEvasaoDistribution(
      List<Course> courses, List<String> terms);
  Map<String, Map<String, double>> getCreditCompletedVsFailedDistribution(
      List<Course> courses, List<String> terms);

  Map<String, Map<String, double>> getEvasionStatisticsByEvasionPeriod(
      List<Course> courses, List<String> terms);
  Map<String, Map<String, double>> getGraduationStatisticsByEvasionPeriod(
      List<Course> courses, List<String> terms);
  Map<String, Map<String, double>> getEvasionByColor(
      List<Course> courses, List<String> terms);
  Map<String, Map<String, double>> getEvasionByAge(
      List<Course> courses, List<String> terms);
  Map<String, Map<String, double>> getEvasionByGender(
      List<Course> courses, List<String> terms);
}
