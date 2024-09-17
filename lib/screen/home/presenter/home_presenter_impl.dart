import 'package:bi_ufcg/models/course.dart';
import 'package:bi_ufcg/models/student.dart';
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
    dataRepository.getCourses().then((courses) {
      courses.sort((a, b) => a.descricao.compareTo(b.descricao));
      _view.setCourse(courses);
    }).catchError((e) {
      _view.onError(e.toString());
    });
  }

  @override
  void getStudentsByCourse(int code) {
    _view.setTrueisRequestingStudentsByCourse();
    dataRepository.getStudentsByCourse(code).then((students) {
      _view.onStudentsReceived(students, code);
    }).catchError((e) {
      _view.onError(e.toString());
    });
  }

  @override
  void removeCourse(int code) {
    _view.removeCode(code);
  }

  @override
  void attDataBase(List<Course> courses, List<String> terms) {
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
    _view.updateOriginDistribution(
        dataService.getOriginDistribution(courses, terms));
    _view.updateColorDistribution(
        dataService.getColorDistribution(courses, terms));
    _view.updateDisabilitiesDistribution(
        dataService.getDisabilitiesDistribution(courses, terms));
    _view.updateInactivityPerPeriodoDeEvasaoDistribution(dataService
        .getInactivityPerPeriodoDeEvasaoDistribution(courses, terms));
    _view.updateAgeAtEnrollmentDistribution(
        dataService.getAgeAtEnrollmentDistribution(courses, terms));
    _view.updateCreditCompletedVsFailedDistribution(
        dataService.getCreditCompletedVsFailedDistribution(courses, terms));

    _view.updateEvasionStatisticsByEvasionPeriod(
        dataService.getEvasionStatisticsByEvasionPeriod(courses, terms));
    _view.updateGraduationStatisticsByEvasionPeriod(
        dataService.getGraduationStatisticsByEvasionPeriod(courses, terms));
    _view.updateEvasionByColor(dataService.getEvasionByColor(courses, terms));
    _view.updateEvasionByAge(dataService.getEvasionByAge(courses, terms));
    _view.updateEvasionByGender(dataService.getEvasionByGender(courses, terms));
  }

  @override
  void getTerms(int courseCode) {
    dataRepository.getStudentsByCourse(courseCode).then((students) {
      List<String> terms = findTerms(students);
      _view.setTerms(terms);
    }).catchError((e) {
      _view.onError(e.toString());
    });
  }

  List<String> findTerms(List<Student> students) {
    List<String> terms = [];
    for (var student in students) {
      if (!terms.contains(student.periodoDeIngresso)) {
        terms.add(student.periodoDeIngresso ?? '');
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
