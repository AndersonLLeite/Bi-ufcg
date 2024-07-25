import 'package:bi_ufcg/models/course.dart';
import 'package:bi_ufcg/repositories/data/data_repository.dart';
import 'package:bi_ufcg/service/course_data_service/course_data_service.dart';

import '../view/home_view.dart';
import 'home_presenter.dart';

class HomePresenterImpl implements HomePresenter {
  DataRepository dataRepository;
  CourseDataService courseDataService;
  late HomeView _view;

  HomePresenterImpl(
      {required this.dataRepository, required this.courseDataService});

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
    _view.showLoading();
    dataRepository.getStudentsByCourse(code).then((students) {
      _view.onStudentsReceived(students, code);
      _view.hideLoading();
    }).catchError((e) {
      _view.onError(e.toString());
      _view.hideLoading();
    });
  }

  @override
  void removeCourse(String code) {
    _view.removeCode(code);
  }

  @override
  void attDataBase(List<Course> courses, List<String> terms) {
    if (terms.isEmpty) {
      _view.message('Selecione um periodo');
      return;
    } else if (courses.isEmpty) {
      _view.message('Selecione um curso');
      return;
    }
    _view.updateEnrollmentEvolution(
        courseDataService.getEnrollmentEvolution(courses, terms));
    _view.updateGenderDistribution(
        courseDataService.getGenderDistribution(courses, terms));
    _view.updateAgeDistribution(
        courseDataService.getAgeDistribution(courses, terms));
    _view.updateAffirmativePolicyDistribution(
        courseDataService.getAffirmativePolicyDistribution(courses, terms));
    _view.updateActiveInactiveDistribution(
        courseDataService.getActiveInactiveDistribution(courses, terms));
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
}
