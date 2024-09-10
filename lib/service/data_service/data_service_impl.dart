import '../../models/course.dart';
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
        if (student.admissionTerm == null ||
            !terms.contains(student.admissionTerm)) {
          continue;
        }
        if (!enrollmentEvolution.containsKey(student.admissionTerm)) {
          enrollmentEvolution[student.admissionTerm] = 0;
        }
        enrollmentEvolution[student.admissionTerm] =
            enrollmentEvolution[student.admissionTerm]! + 1;
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
        if (student.admissionTerm == null ||
            !terms.contains(student.admissionTerm)) {
          continue;
        }
        if (!genderDistribution.containsKey(student.admissionTerm)) {
          genderDistribution[student.admissionTerm] = {
            'MASCULINO': 0,
            'FEMININO': 0,
            'other': 0
          };
        }
        if (!genderDistribution[student.admissionTerm]!
            .containsKey(student.gender)) {
          genderDistribution[student.admissionTerm]![student.gender] = 0;
        }
        genderDistribution[student.admissionTerm]![student.gender] =
            genderDistribution[student.admissionTerm]![student.gender]! + 1;
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
        if (student.admissionTerm == null ||
            !terms.contains(student.admissionTerm)) {
          continue;
        }
        String ageRange = _getAgeRange(student.age);
        if (!ageDistribution.containsKey(student.admissionTerm)) {
          ageDistribution[student.admissionTerm] = {};
        }
        if (!ageDistribution[student.admissionTerm]!.containsKey(ageRange)) {
          ageDistribution[student.admissionTerm]![ageRange] = 0;
        }
        ageDistribution[student.admissionTerm]![ageRange] =
            ageDistribution[student.admissionTerm]![ageRange]! + 1;
      }
    }
    return ageDistribution;
  }

  String _getAgeRange(int age) {
    if (age >= 16 && age <= 20) {
      return '16-20';
    } else if (age >= 21 && age <= 25) {
      return '21-25';
    } else if (age >= 26 && age <= 30) {
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
        if (student.admissionTerm == null ||
            !terms.contains(student.admissionTerm)) {
          continue;
        }
        if (!affirmativePolicyDistribution.containsKey(student.admissionTerm)) {
          affirmativePolicyDistribution[student.admissionTerm] = {};
        }
        if (!affirmativePolicyDistribution[student.admissionTerm]!
            .containsKey(student.affirmativePolicy)) {
          affirmativePolicyDistribution[student.admissionTerm]![
              student.affirmativePolicy] = 0;
        }
        affirmativePolicyDistribution[student.admissionTerm]![
            student.affirmativePolicy] = affirmativePolicyDistribution[
                student.admissionTerm]![student.affirmativePolicy]! +
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
        if (student.admissionTerm == null ||
            !terms.contains(student.admissionTerm)) {
          continue;
        }
        if (!statusDistribution.containsKey(student.admissionTerm)) {
          statusDistribution[student.admissionTerm] = {};
        }
        if (!statusDistribution[student.admissionTerm]!
            .containsKey(student.status)) {
          statusDistribution[student.admissionTerm]![student.status] = 0;
        }
        statusDistribution[student.admissionTerm]![student.status] =
            statusDistribution[student.admissionTerm]![student.status]! + 1;
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
        if (student.admissionTerm == null ||
            !terms.contains(student.admissionTerm)) {
          continue;
        }
        if (!inactivityReasonDistribution.containsKey(student.admissionTerm)) {
          inactivityReasonDistribution[student.admissionTerm] = {};
        }
        if (!inactivityReasonDistribution[student.admissionTerm]!
            .containsKey(student.inactivityReason)) {
          inactivityReasonDistribution[student.admissionTerm]![
              student.inactivityReason] = 0;
        }
        inactivityReasonDistribution[student.admissionTerm]![
            student.inactivityReason] = inactivityReasonDistribution[
                student.admissionTerm]![student.inactivityReason]! +
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
        if (student.admissionTerm == null ||
            !terms.contains(student.admissionTerm)) {
          continue;
        }
        if (!admissionTypeDistribution.containsKey(student.admissionTerm)) {
          admissionTypeDistribution[student.admissionTerm] = {};
        }
        if (!admissionTypeDistribution[student.admissionTerm]!
            .containsKey(student.admissionType)) {
          admissionTypeDistribution[student.admissionTerm]![
              student.admissionType] = 0;
        }
        admissionTypeDistribution[student.admissionTerm]![
            student.admissionType] = admissionTypeDistribution[
                student.admissionTerm]![student.admissionType]! +
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
        if (student.admissionTerm == null ||
            !terms.contains(student.admissionTerm)) {
          continue;
        }
        if (!secondarySchoolTypeDistribution
            .containsKey(student.admissionTerm)) {
          secondarySchoolTypeDistribution[student.admissionTerm] = {};
        }
        if (!secondarySchoolTypeDistribution[student.admissionTerm]!
            .containsKey(student.secondarySchoolType)) {
          secondarySchoolTypeDistribution[student.admissionTerm]![
              student.secondarySchoolType] = 0;
        }
        secondarySchoolTypeDistribution[student.admissionTerm]![
            student.secondarySchoolType] = secondarySchoolTypeDistribution[
                student.admissionTerm]![student.secondarySchoolType]! +
            1;
      }
    }
    return secondarySchoolTypeDistribution;
  }
}
