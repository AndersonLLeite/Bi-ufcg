import '../../models/course.dart';

abstract class CourseDataService {
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
}
