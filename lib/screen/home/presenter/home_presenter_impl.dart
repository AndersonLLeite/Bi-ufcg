import 'package:bi_ufcg/models/course.dart';
import 'package:bi_ufcg/repositories/data/data_repository.dart';
import 'package:bi_ufcg/service/data_service/data_service.dart';

import '../view/home_view.dart';
import 'home_presenter.dart';

class HomePresenterImpl implements HomePresenter {
  DataRepository dataRepository;
  DataService dataService;
  late HomeView _view;

  HomePresenterImpl({
    required this.dataRepository,
    required this.dataService,
  });

  @override
  set view(HomeView view) {
    _view = view;
  }

  @override
  void getCourses() {
    _view.showLoading();
    dataRepository.getCourses().then((courses) {
      _view.onCoursesReceived(courses);
      _view.hideLoading();
    }).catchError((e) {
      _view.onError(e.toString());
      _view.hideLoading();
    });
  }

  @override
  void getStudentsByCourse(String code) {
    dataRepository.getStudentsByCourse(code).then((students) {
      _view.onStudentsReceived(students, code);
    }).catchError((e) {
      _view.onError(e.toString());
    });
  }

  @override
  void removeCourse(String code) {
    _view.removeCode(code);
  }

  @override
  void attDataBase(List<Course> courses, List<String> terms) {
    _view.updateEnrollmentEvolution(
        dataService.getEnrollmentEvolution(courses, terms));
    _view.updateGenderDistribution(
        dataService.getGenderDistribution(courses, terms));
    _view.updateAgeDistribution(dataService.getAgeDistribution(courses, terms));
    _view.updateAffirmativePolicyDistribution(
        dataService.getAffirmativePolicyDistribution(courses, terms));
    _view.updateStatusDistribution(
        dataService.getStatusDistribution(courses, terms));
    _view.updateInactivityReasonDistribution(
        dataService.getInactivityReasonDistribution(courses, terms));
    _view.updateAdmissionTypeDistribution(
        dataService.getAdmissionTypeDistribution(courses, terms));
    _view.updateSecondarySchoolTypeDistribution(
        dataService.getSecondarySchoolTypeDistribution(courses, terms));
  }

  @override
  void getTerms(String courseCode) {
    dataRepository.getStudentsByCourse(courseCode).then((students) {
      List<String> terms = findTerms(students);
      _view.setTerms(terms);
    }).catchError((e) {
      _view.onError(e.toString());
    });
  }

  List<String> findTerms(students) {
    List<String> terms = [];
    for (var student in students) {
      if (!terms.contains(student.admissionTerm)) {
        terms.add(student.admissionTerm);
      }
    }
    // tranformar as strings em double e ordenar e depois transformar em string novamente
    terms.sort((a, b) => double.parse(b).compareTo(double.parse(a)));
    return terms;
  }

  @override
  void changeIndexMenu(int index) {
    _view.changeIndexMenu(index);
  }

  @override
  void showError(String message) {
    _view.onError(message);
  }

  @override
  void attDataByTerm(String term) {
    _view.addTermToData(term);
  }

  @override
  void removeTerm(String term) {
    _view.removeTermToData(term);
  }

  @override
  void addCourseSelectIndex(int index) {
    _view.addCourseSelectIndex(index);
  }

  @override
  void addTermSelectIndex(int index) {
    _view.addTermSelectIndex(index);
  }

  @override
  List<int> getCourseSelectedIndexes() {
    return _view.getCourseSelectedIndexes();
  }

  @override
  List<int> getTermSelectedIndexes() {
    return _view.getTermSelectedIndexes();
  }

  @override
  void removeCourseSelectIndex(int index) {
    _view.removeCourseSelectIndex(index);
  }

  @override
  void removeTermSelectIndex(int index) {
    _view.removeTermSelectIndex(index);
  }
}
