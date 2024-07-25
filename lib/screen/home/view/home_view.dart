import 'package:bi_ufcg/models/course.dart';

import '../../../models/student.dart';

abstract class HomeView {
  void onCoursesReceived(List<Course> courses);

  void onError(String string);

  void onStudentsReceived(List<Student> student, String code);

  void removeCode(String code);

  void updateEnrollmentEvolution(Map<String, int> enrollmentEvolution);

  void updateGenderDistribution(
      Map<String, Map<String, int>> genderDistribution);

  void updateAgeDistribution(Map<String, Map<String, int>> ageDistribution);

  void updateAffirmativePolicyDistribution(
      Map<String, Map<String, int>> affirmativePolicyDistribution);

  void updateActiveInactiveDistribution(
      Map<String, Map<String, int>> activeInactiveDistribution);

  void setTerms(List<String> terms);

  void changeIndexMenu(int index);

  void addTermToData(String term);

  void removeTermToData(String term);

  void message(String message);

  void showLoading();

  void hideLoading();
}
