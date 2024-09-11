import 'package:bi_ufcg/models/course.dart';
import 'data_service.dart';

class DataServiceImpl implements DataService {
  DataServiceImpl();

  // 1. Evolução do número de matrículas ao longo dos períodos.
  @override
  Map<String, int> getEnrollmentEvolution(
      List<Course> courses, List<String> terms) {
    Map<String, int> enrollmentEvolution = {};
    for (var course in courses) {
      for (var student in course.students ?? []) {
        if (student.periodoDeIngresso == null ||
            !terms.contains(student.periodoDeIngresso)) {
          continue;
        }
        if (!enrollmentEvolution.containsKey(student.periodoDeIngresso)) {
          enrollmentEvolution[student.periodoDeIngresso] = 0;
        }
        enrollmentEvolution[student.periodoDeIngresso] =
            enrollmentEvolution[student.periodoDeIngresso]! + 1;
      }
    }
    return enrollmentEvolution;
  }

  // 2. Distribuição de alunos por gênero no curso ao longo dos períodos.
  @override
  Map<String, Map<String, int>> getGenderDistribution(
      List<Course> courses, List<String> terms) {
    Map<String, Map<String, int>> genderDistribution = {};
    for (var course in courses) {
      for (var student in course.students ?? []) {
        if (student.periodoDeIngresso == null ||
            !terms.contains(student.periodoDeIngresso)) {
          continue;
        }
        if (!genderDistribution.containsKey(student.periodoDeIngresso)) {
          genderDistribution[student.periodoDeIngresso] = {};
        }
        // Adiciona o gênero dinamicamente
        if (!genderDistribution[student.periodoDeIngresso]!
            .containsKey(student.genero)) {
          genderDistribution[student.periodoDeIngresso]![student.genero] = 0;
        }
        genderDistribution[student.periodoDeIngresso]![student.genero] =
            genderDistribution[student.periodoDeIngresso]![student.genero]! + 1;
      }
    }
    return genderDistribution;
  }

  // 3. Distribuição dos alunos por idade no curso ao longo dos períodos.
  @override
  Map<String, Map<String, int>> getAgeDistribution(
      List<Course> courses, List<String> terms) {
    Map<String, Map<String, int>> ageDistribution = {};
    for (var course in courses) {
      for (var student in course.students ?? []) {
        if (student.periodoDeIngresso == null ||
            !terms.contains(student.periodoDeIngresso)) {
          continue;
        }
        String ageRange = _getAgeRange(student.idade);
        if (!ageDistribution.containsKey(student.periodoDeIngresso)) {
          ageDistribution[student.periodoDeIngresso] = {};
        }
        if (!ageDistribution[student.periodoDeIngresso]!
            .containsKey(ageRange)) {
          ageDistribution[student.periodoDeIngresso]![ageRange] = 0;
        }
        ageDistribution[student.periodoDeIngresso]![ageRange] =
            ageDistribution[student.periodoDeIngresso]![ageRange]! + 1;
      }
    }
    return ageDistribution;
  }

  String _getAgeRange(String age) {
    int idade = int.parse(age);
    if (idade >= 16 && idade <= 20) {
      return '16-20';
    } else if (idade >= 21 && idade <= 25) {
      return '21-25';
    } else if (idade >= 26 && idade <= 30) {
      return '26-30';
    } else {
      return '30+';
    }
  }

  // 4. Distribuição por cotas de ação afirmativa ao longo dos períodos.
  @override
  Map<String, Map<String, int>> getAffirmativePolicyDistribution(
      List<Course> courses, List<String> terms) {
    Map<String, Map<String, int>> affirmativePolicyDistribution = {};
    for (var course in courses) {
      for (var student in course.students ?? []) {
        if (student.periodoDeIngresso == null ||
            !terms.contains(student.periodoDeIngresso)) {
          continue;
        }
        if (!affirmativePolicyDistribution
            .containsKey(student.periodoDeIngresso)) {
          affirmativePolicyDistribution[student.periodoDeIngresso] = {};
        }
        if (!affirmativePolicyDistribution[student.periodoDeIngresso]!
            .containsKey(student.politicaAfirmativa)) {
          affirmativePolicyDistribution[student.periodoDeIngresso]![
              student.politicaAfirmativa] = 0;
        }
        affirmativePolicyDistribution[student.periodoDeIngresso]![
            student.politicaAfirmativa] = affirmativePolicyDistribution[
                student.periodoDeIngresso]![student.politicaAfirmativa]! +
            1;
      }
    }
    return affirmativePolicyDistribution;
  }

  @override
  Map<String, Map<String, int>> getStatusDistribution(
      List<Course> courses, List<String> terms) {
    Map<String, Map<String, int>> statusDistribution = {};
    for (var course in courses) {
      for (var student in course.students ?? []) {
        if (student.periodoDeIngresso == null ||
            !terms.contains(student.periodoDeIngresso)) {
          continue;
        }
        if (!statusDistribution.containsKey(student.periodoDeIngresso)) {
          statusDistribution[student.periodoDeIngresso] = {};
        }
        if (!statusDistribution[student.periodoDeIngresso]!
            .containsKey(student.situacao)) {
          statusDistribution[student.periodoDeIngresso]![student.situacao] = 0;
        }
        statusDistribution[student.periodoDeIngresso]![student.situacao] =
            statusDistribution[student.periodoDeIngresso]![student.situacao]! +
                1;
      }
    }
    return statusDistribution;
  }

  // 7. Distribuição por motivo de inatividade ao longo dos períodos.
  @override
  Map<String, Map<String, int>> getInactivityReasonDistribution(
      List<Course> courses, List<String> terms) {
    Map<String, Map<String, int>> inactivityReasonDistribution = {};
    for (var course in courses) {
      for (var student in course.students ?? []) {
        if (student.periodoDeIngresso == null ||
            !terms.contains(student.periodoDeIngresso)) {
          continue;
        }
        if (!inactivityReasonDistribution
            .containsKey(student.periodoDeIngresso)) {
          inactivityReasonDistribution[student.periodoDeIngresso] = {};
        }
        if (!inactivityReasonDistribution[student.periodoDeIngresso]!
            .containsKey(student.motivoDeEvasao)) {
          inactivityReasonDistribution[student.periodoDeIngresso]![
              student.motivoDeEvasao] = 0;
        }
        inactivityReasonDistribution[student.periodoDeIngresso]![
            student.motivoDeEvasao] = inactivityReasonDistribution[
                student.periodoDeIngresso]![student.motivoDeEvasao]! +
            1;
      }
    }
    return inactivityReasonDistribution;
  }

  // 8. Distribuição por tipo de admissão ao longo dos períodos.
  @override
  Map<String, Map<String, int>> getAdmissionTypeDistribution(
      List<Course> courses, List<String> terms) {
    Map<String, Map<String, int>> admissionTypeDistribution = {};
    for (var course in courses) {
      for (var student in course.students ?? []) {
        if (student.periodoDeIngresso == null ||
            !terms.contains(student.periodoDeIngresso)) {
          continue;
        }
        if (!admissionTypeDistribution.containsKey(student.periodoDeIngresso)) {
          admissionTypeDistribution[student.periodoDeIngresso] = {};
        }
        if (!admissionTypeDistribution[student.periodoDeIngresso]!
            .containsKey(student.formaDeIngresso)) {
          admissionTypeDistribution[student.periodoDeIngresso]![
              student.formaDeIngresso] = 0;
        }
        admissionTypeDistribution[student.periodoDeIngresso]![
            student.formaDeIngresso] = admissionTypeDistribution[
                student.periodoDeIngresso]![student.formaDeIngresso]! +
            1;
      }
    }
    return admissionTypeDistribution;
  }

  // 9. Distribuição por tipo de escola secundária ao longo dos períodos.
  @override
  Map<String, Map<String, int>> getSecondarySchoolTypeDistribution(
      List<Course> courses, List<String> terms) {
    Map<String, Map<String, int>> secondarySchoolTypeDistribution = {};
    for (var course in courses) {
      for (var student in course.students ?? []) {
        if (student.periodoDeIngresso == null ||
            !terms.contains(student.periodoDeIngresso)) {
          continue;
        }
        if (!secondarySchoolTypeDistribution
            .containsKey(student.periodoDeIngresso)) {
          secondarySchoolTypeDistribution[student.periodoDeIngresso] = {};
        }
        if (!secondarySchoolTypeDistribution[student.periodoDeIngresso]!
            .containsKey(student.tipoDeEnsinoMedio)) {
          secondarySchoolTypeDistribution[student.periodoDeIngresso]![
              student.tipoDeEnsinoMedio] = 0;
        }
        secondarySchoolTypeDistribution[student.periodoDeIngresso]![
            student.tipoDeEnsinoMedio] = secondarySchoolTypeDistribution[
                student.periodoDeIngresso]![student.tipoDeEnsinoMedio]! +
            1;
      }
    }
    return secondarySchoolTypeDistribution;
  }
}
