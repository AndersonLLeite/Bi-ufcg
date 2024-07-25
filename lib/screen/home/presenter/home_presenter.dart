import 'package:bi_ufcg/core/mvp/biufcg_presenter.dart';

import '../../../models/course.dart';
import '../view/home_view.dart';

abstract class HomePresenter extends BiUfcgPresenter<HomeView> {
  void getCourses();
  void getStudentsByCourse(String code);

  void removeCourse(String code);
  void attDataBase(List<Course> courses, List<String> terms);

  void getTerms(String courseCode);

  void changeIndexMenu(int index);

  void showError(String message);

  void removeTerm(String term);

  void attDataByTerm(String term);
}
