import 'package:bi_ufcg/core/ui/helpers/loader.dart';
import 'package:bi_ufcg/core/ui/helpers/messages.dart';
import 'package:flutter/material.dart';

import '../../../models/course.dart';
import '../../../models/student.dart';
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
  Map<String, int> enrollmentEvolution = {};
  Map<String, Map<String, int>> genderDistribution = {};
  Map<String, Map<String, int>> ageDistribution = {};
  Map<String, Map<String, int>> affirmativePolicyDistribution = {};
  Map<String, Map<String, int>> activeInactiveDistribution = {};

  @override
  void initState() {
    widget.presenter.view = this;
    super.initState();
    widget.presenter.getCourses();
  }

  @override
  void onCoursesReceived(List<Course> courses) {
    setState(() {
      listCourses = courses;
    });
    if (listCourses.isNotEmpty) {
      widget.presenter.getTerms(courses[0].code);
    }
  }

  @override
  void setTerms(List<String> terms) {
    setState(() {
      this.terms = terms;
    });
  }

  @override
  void changeIndexMenu(int index) {
    setState(() {
      menuIndexSelected = index;
    });
  }

  @override
  void onStudentsReceived(List<Student> students, String code) {
    setState(() {
      selecteCourses.add(
          listCourses.firstWhere((element) => element.code == code)
            ..students = students);
    });
    widget.presenter.attDataBase(selecteCourses, selectedTerms);
  }

  @override
  void removeCode(String coursecode) {
    setState(() {
      selecteCourses =
          listCourses.where((element) => element.code != coursecode).toList();
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

  @override
  void updateEnrollmentEvolution(Map<String, int> enrollmentEvolution) {
    setState(() {
      this.enrollmentEvolution = enrollmentEvolution;
    });
    print('updateEnrollmentEvolution: ${this.enrollmentEvolution}');
  }

  @override
  void updateGenderDistribution(
      Map<String, Map<String, int>> genderDistribution) {
    setState(() {
      this.genderDistribution = genderDistribution;
    });
    print('updateGenderDistribution: ${this.genderDistribution}');
  }

  @override
  void updateAgeDistribution(Map<String, Map<String, int>> ageDistribution) {
    setState(() {
      this.ageDistribution = ageDistribution;
    });
    print('updateAgeDistribution: ${this.ageDistribution}');
  }

  @override
  void updateAffirmativePolicyDistribution(
      Map<String, Map<String, int>> affirmativePolicyDistribution) {
    setState(() {
      this.affirmativePolicyDistribution = affirmativePolicyDistribution;
    });
    print(
        'updateAffirmativePolicyDistribution: ${this.affirmativePolicyDistribution}');
  }

  @override
  void updateActiveInactiveDistribution(
      Map<String, Map<String, int>> activeInactiveDistribution) {
    setState(() {
      this.activeInactiveDistribution = activeInactiveDistribution;
    });
    print(
        'updateActiveInactiveDistribution: ${this.activeInactiveDistribution}');
  }
}
