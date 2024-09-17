import 'package:bi_ufcg/core/ui/helpers/loader.dart';
import 'package:bi_ufcg/core/ui/helpers/messages.dart';
import 'package:bi_ufcg/models/course.dart';
import 'package:bi_ufcg/models/student.dart';
import 'package:bi_ufcg/service/data_service/data.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../home_page.dart';
import 'home_view.dart';

abstract class HomeViewImpl extends State<HomePage>
    with Loader<HomePage>, Messages<HomePage>
    implements HomeView {
  int menuIndexSelected = 0;
  List<Course> listCourses = [];
  List<Course> selecteCourses = [];
  List<String> terms = [];
  List<String> selectedTerms = [];
  List<int> courseSelectedIndexes = [];
  List<int> termSelectedIndexes = [];
  bool isRequestingStudentsByCourse = false;

  @override
  void initState() {
    widget.presenter.view = this;
    widget.presenter.getCourses();
    widget.presenter.getTerms(14102100);
    super.initState();
  }

  @override
  void setCourse(List<Course> courses) {
    setState(() {
      listCourses = courses;
    });
  }

  @override
  void setTerms(List<String> terms) {
    setState(() {
      this.terms = terms;
    });
  }

  @override
  void setFalseisRequestingStudentsByCourse() {
    setState(() {
      isRequestingStudentsByCourse = false;
    });
  }

  @override
  void setTrueisRequestingStudentsByCourse() {
    setState(() {
      isRequestingStudentsByCourse = true;
    });
  }

  @override
  void changeIndexMenu(int index) {
    setState(() {
      menuIndexSelected = index;
    });
  }

  @override
  List<int> getCourseSelectedIndexes() {
    return courseSelectedIndexes;
  }

  @override
  List<int> getTermSelectedIndexes() {
    return termSelectedIndexes;
  }

  @override
  void addCourseSelectIndex(int index) {
    setState(() {
      courseSelectedIndexes.add(index);
    });
  }

  @override
  void removeCourseSelectIndex(int index) {
    setState(() {
      courseSelectedIndexes.remove(index);
    });
  }

  @override
  void addTermSelectIndex(int index) {
    setState(() {
      termSelectedIndexes.add(index);
    });
  }

  @override
  void removeTermSelectIndex(int index) {
    setState(() {
      termSelectedIndexes.remove(index);
    });
  }

  @override
  void onStudentsReceived(List<Student> students, int courseCode) {
    setState(() {
      selecteCourses.add(listCourses
          .firstWhere((element) => element.codigoDoCurso == courseCode)
        ..students = students);
    });
    widget.presenter.attDataBase(selecteCourses, selectedTerms);
    setFalseisRequestingStudentsByCourse();
  }

  @override
  void removeCode(int coursecode) {
    setState(() {
      selecteCourses = selecteCourses
          .where((element) => element.codigoDoCurso != coursecode)
          .toList();
    });
    widget.presenter.attDataBase(selecteCourses, selectedTerms);
  }

  @override
  void addTermToData(String term) {
    setState(() {
      selectedTerms.add(term);
    });
    widget.presenter.attDataBase(selecteCourses, selectedTerms);
  }

  @override
  void removeTermToData(String term) {
    setState(() {
      selectedTerms.remove(term);
    });
    widget.presenter.attDataBase(selecteCourses, selectedTerms);
  }

  @override
  void onError(String error) {
    showError(error);
  }

  @override
  void message(String message) {
    showInfo(message);
  }

  @override
  void showLoading() {
    showLoader();
  }

  @override
  void hideLoading() {
    hideLoader();
  }

  // @override
  // void updateEnrollmentEvolution(Map<String, int> enrollmentEvolution) {
  //   context.read<Data>().setEnrollmentEvolution(enrollmentEvolution);
  // }

  @override
  void updateGenderDistribution(
      Map<String, Map<String, double>> genderDistribution) {
    context.read<Data>().setGenderDistribution(genderDistribution);
    //   print('genderDistribution:  $genderDistribution');
  }

  @override
  void updateAgeDistribution(Map<String, Map<String, double>> ageDistribution) {
    context.read<Data>().setAgeDistribution(ageDistribution);
    //   print('ageDistribution:  $ageDistribution');
  }

  @override
  void updateAffirmativePolicyDistribution(
      Map<String, Map<String, double>> affirmativePolicyDistribution) {
    context
        .read<Data>()
        .setAffirmativePolicyDistribution(affirmativePolicyDistribution);
  }

  @override
  void updateStatusDistribution(
      Map<String, Map<String, double>> statusDistribution) {
    context.read<Data>().setStatusDistribution(statusDistribution);
    //   print('statusDistribuition:  $statusDistribution');
  }

  @override
  void updateInactivityReasonDistribution(
      Map<String, Map<String, double>> inactivityReasonDistribution) {
    context
        .read<Data>()
        .setInactivityReasonDistribution(inactivityReasonDistribution);
    print('inactivityReasonDistribution:  $inactivityReasonDistribution');
  }

  @override
  void updateAdmissionTypeDistribution(
      Map<String, Map<String, double>> admissionTypeDistribution) {
    context
        .read<Data>()
        .setAdmissionTypeDistribution(admissionTypeDistribution);
//    print('admissionTypeDistribution:  $admissionTypeDistribution');
  }

  @override
  void updateSecondarySchoolTypeDistribution(
      Map<String, Map<String, double>> secondarySchoolTypeDistribution) {
    context
        .read<Data>()
        .setSecondarySchoolTypeDistribution(secondarySchoolTypeDistribution);
    //   print('secondarySchoolTypeDistribution:  $secondarySchoolTypeDistribution');
  }

  @override
  void updateOriginDistribution(
      Map<String, Map<String, double>> originDistribution) {
    context.read<Data>().setOriginDistribution(originDistribution);
    //   print('originDistribution:  $originDistribution');
  }

  @override
  void updateColorDistribution(
      Map<String, Map<String, double>> colorDistribution) {
    context.read<Data>().setColorDistribution(colorDistribution);
    //  print('colorDistribution:  $colorDistribution');
  }

  @override
  void updateDisabilitiesDistribution(
      Map<String, Map<String, double>> disabilitiesDistribution) {
    context.read<Data>().setDisabilitiesDistribution(disabilitiesDistribution);
    //  print('disabilitiesDistribution:  $disabilitiesDistribution');
  }

  @override
  void updateInactivityPerPeriodoDeEvasaoDistribution(
      Map<String, Map<String, double>>
          inactivityPerPeriodoDeEvasaoDistribution) {
    context.read<Data>().setInactivityPerPeriodoDeEvasaoDistribution(
        inactivityPerPeriodoDeEvasaoDistribution);
    //  print(
//        'inactivityPerPeriodoDeEvasaoDistribution:  $inactivityPerPeriodoDeEvasaoDistribution');
  }

  @override
  void updateAgeAtEnrollmentDistribution(
      Map<String, Map<String, double>> ageAtEnrollmentDistribution) {
    context
        .read<Data>()
        .setAgeAtEnrollmentDistribution(ageAtEnrollmentDistribution);
//    print('ageAtEnrollmentDistribution:  $ageAtEnrollmentDistribution');
  }

  @override
  void updateCreditCompletedVsFailedDistribution(
      Map<String, Map<String, double>> creditCompletedVsFailedDistribution) {
    context.read<Data>().setCreditCompletedVsFailedDistribution(
        creditCompletedVsFailedDistribution);
    //  print(
    //    'creditCompletedVsFailedDistribution:  $creditCompletedVsFailedDistribution');
  }

  @override
  void updateEvasionStatisticsByEvasionPeriod(
      Map<String, Map<String, double>> evasionStatisticsByPeriod) {
    context
        .read<Data>()
        .setEvasionStatisticsByEvasionPeriod(evasionStatisticsByPeriod);
    //  print('evasionStatisticsByPeriod:  $evasionStatisticsByPeriod');
  }

  @override
  void updateGraduationStatisticsByEvasionPeriod(
      Map<String, Map<String, double>> graduationStatisticsByPeriod) {
    context
        .read<Data>()
        .setGraduationStatisticsByEvasionPeriod(graduationStatisticsByPeriod);
    //  print('graduationStatisticsByPeriod:  $graduationStatisticsByPeriod');
  }

  @override
  void updateEvasionByColor(Map<String, Map<String, double>> evasionByRace) {
    context.read<Data>().setEvasionByColor(evasionByRace);
    print('evasionByRace:  $evasionByRace');
  }

  @override
  void updateEvasionByAge(Map<String, Map<String, double>> evasionByAge) {
    context.read<Data>().setEvasionByAge(evasionByAge);
    print('evasionByAge:  $evasionByAge');
  }

  @override
  void updateEvasionByGender(Map<String, Map<String, double>> evasionByGender) {
    context.read<Data>().setEvasionByGender(evasionByGender);
    print('evasionByGender:  $evasionByGender');
  }

  @override
  void updateEvasionByAdmissionType(
      Map<String, Map<String, double>> evasionByAdmissionType) {
    context.read<Data>().setEvasionByAdmissionType(evasionByAdmissionType);
    print('evasionByAdmissionType:  $evasionByAdmissionType');
  }

  @override
  void updateEvasionBySecondarySchoolType(
      Map<String, Map<String, double>> evasionBySecondarySchoolType) {
    context
        .read<Data>()
        .setEvasionBySecondarySchoolType(evasionBySecondarySchoolType);
    print('evasionBySecondarySchoolType:  $evasionBySecondarySchoolType');
  }

  @override
  void updateEvasionByDisabilities(
      Map<String, Map<String, double>> evasionByDisabilities) {
    context.read<Data>().setEvasionByDisabilities(evasionByDisabilities);
    print('evasionByDisabilities:  $evasionByDisabilities');
  }
}
