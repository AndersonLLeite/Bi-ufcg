import 'package:bi_ufcg/models/course.dart';
import 'package:bi_ufcg/models/student.dart';

abstract class HomeView {
  void setCourse(List<Course> courses);

  void onError(String string);

  void onStudentsReceived(List<Student> student, int code);

  void removeCode(int code);

  void setFalseisRequestingStudentsByCourse();

  void setTrueisRequestingStudentsByCourse();

  //void updateEnrollmentEvolution(Map<String, int> enrollmentEvolution);

  void updateGenderDistribution(
      Map<String, Map<String, double>> genderDistribution);

  void updateAgeDistribution(Map<String, Map<String, double>> ageDistribution);

  void updateAffirmativePolicyDistribution(
      Map<String, Map<String, double>> affirmativePolicyDistribution);

  void updateStatusDistribution(
      Map<String, Map<String, double>> statusDistribution);

  void updateInactivityReasonDistribution(
      Map<String, Map<String, double>> inactivityReasonDistribution);

  void updateAdmissionTypeDistribution(
      Map<String, Map<String, double>> admissionTypeDistribution);

  void updateSecondarySchoolTypeDistribution(
      Map<String, Map<String, double>> secondarySchoolTypeDistribution);

  void updateOriginDistribution(
      Map<String, Map<String, double>> originDistribution);

  void updateColorDistribution(
      Map<String, Map<String, double>> colorDistribution);

  void updateDisabilitiesDistribution(
      Map<String, Map<String, double>> disabilitiesDistribution);

  void updateInactivityPerPeriodoDeEvasaoDistribution(
      Map<String, Map<String, double>>
          inactivityPerPeriodoDeEvasaoDistribution);

  void updateAgeAtEnrollmentDistribution(
      Map<String, Map<String, double>> ageAtEnrollmentDistribution);

  void updateCreditCompletedVsFailedDistribution(
      Map<String, Map<String, double>> creditCompletedVsFailedDistribution);

  void updateEvasionStatisticsByEvasionPeriod(
      Map<String, Map<String, double>> evasionStatisticsByPeriod);

  void updateGraduationStatisticsByEvasionPeriod(
      Map<String, Map<String, double>> graduationStatisticsByPeriod);

  void updateEvasionByColor(Map<String, Map<String, double>> evasionByRace);

  void updateEvasionByAge(Map<String, Map<String, double>> evasionByAge);

  void updateEvasionByGender(Map<String, Map<String, double>> evasionByGender);

  void updateEvasionByAdmissionType(
      Map<String, Map<String, double>> evasionByAdmissionType);

  void updateEvasionBySecondarySchoolType(
      Map<String, Map<String, double>> evasionBySecondarySchoolType);

  void updateEvasionByDisabilities(
      Map<String, Map<String, double>> evasionByDisabilities);

  void setTerms(List<String> terms);

  void changeIndexMenu(int index);

  void addTermToData(String term);

  void removeTermToData(String term);

  void message(String message);

  void showLoading();

  void hideLoading();

  List<int> getCourseSelectedIndexes();
  List<int> getTermSelectedIndexes();
  void addCourseSelectIndex(int index);
  void removeCourseSelectIndex(int index);
  void addTermSelectIndex(int index);
  void removeTermSelectIndex(int index);
}
