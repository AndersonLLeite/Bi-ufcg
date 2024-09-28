import 'package:bi_ufcg/core/mvp/biufcg_presenter.dart';
import 'package:bi_ufcg/models/course.dart';

import '../view/home_view.dart';

abstract class HomePresenter extends BiUfcgPresenter<HomeView> {
  void getCourses();
  void getStudentsByCourse(int courseCode);

  void removeCourse(int code);
  void attDataBase(List<Course> courses, List<String> terms);

  void getTerms(int courseCode);

  void changeIndexMenu(int index);

  void showError(String message);

  void removeTerm(String term);

  void attDataByTerm(String term);

  List<int> getCourseSelectedIndexes();
  List<int> getTermSelectedIndexes();
  void addCourseSelectIndex(int index);
  void removeCourseSelectIndex(int index);
  void addTermSelectIndex(int index);
  void removeTermSelectIndex(int index);
}
