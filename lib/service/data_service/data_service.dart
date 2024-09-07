import '../../models/course.dart';

abstract class DataService {
  Map<String, int> getEnrollmentEvolution(
      List<Course> courses, List<String> terms);
  Map<String, Map<String, int>> getGenderDistribution(
      List<Course> courses, List<String> terms);
  Map<String, Map<String, int>> getAgeDistribution(
      List<Course> courses, List<String> terms);
  Map<String, Map<String, int>> getAffirmativePolicyDistribution(
      List<Course> courses, List<String> terms);
  Map<String, Map<String, int>> getActiveInactiveDistribution(
      List<Course> courses, List<String> terms);
  Map<String, Map<String, int>> getStatusDistribution(
      List<Course> courses, List<String> terms);
  Map<String, Map<String, int>> getInactivityReasonDistribution(
      List<Course> courses, List<String> terms);
  Map<String, Map<String, int>> getAdmissionTypeDistribution(
      List<Course> courses, List<String> terms);
  Map<String, Map<String, int>> getSecondarySchoolTypeDistribution(
      List<Course> courses, List<String> terms);
}
