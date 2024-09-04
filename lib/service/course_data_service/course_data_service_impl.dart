import '../../models/course.dart';
import 'course_data_service.dart';

class CourseDataServiceImpl implements CourseDataService {
  CourseDataServiceImpl();

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

  // 5. Distribuição por período de aluno ativo e inativo.
  @override
  Map<String, Map<String, int>> getActiveInactiveDistribution(
      List<Course> courses, List<String> terms) {
    Map<String, Map<String, int>> activeInactiveDistribution = {};

    for (var term in terms) {
      activeInactiveDistribution[term] = {
        'total': 0,
        'active': 0,
        'inactive': 0
      };
    }

    for (var course in courses) {
      for (var student in course.students ?? []) {
        if (student.admissionTerm == null ||
            !terms.contains(student.admissionTerm)) {
          continue;
        }

        var termData = activeInactiveDistribution[student.admissionTerm]!;
        termData['total'] = termData['total']! + 1;

        if (student.active) {
          termData['active'] = termData['active']! + 1;
        } else {
          termData['inactive'] = termData['inactive']! + 1;
        }
      }
    }

    return activeInactiveDistribution;
  }
}
