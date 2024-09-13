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

  @override
  Map<String, Map<String, int>> getInactivityReasonDistribution(
      List<Course> courses, List<String> terms) {
    Map<String, Map<String, int>> inactivityReasonDistribution = {};

    for (var course in courses) {
      for (var student in course.students ?? []) {
        // Verifica se o estudante evadiu no mesmo período em que ingressou
        if (student.periodoDeIngresso == null ||
                student.periodoDeEvasao == null ||
                student.periodoDeIngresso != student.periodoDeEvasao ||
                !terms.contains(student.periodoDeIngresso) ||
                student.motivoDeEvasao == null
            // || student.motivoDeEvasao == "REGULAR"
            ) {
          continue;
        }

        // Cria a chave para o período de ingresso
        if (!inactivityReasonDistribution
            .containsKey(student.periodoDeIngresso)) {
          inactivityReasonDistribution[student.periodoDeIngresso] = {};
        }

        // Cria a chave para o motivo de evasão
        if (!inactivityReasonDistribution[student.periodoDeIngresso]!
            .containsKey(student.motivoDeEvasao)) {
          inactivityReasonDistribution[student.periodoDeIngresso]![
              student.motivoDeEvasao!] = 0;
        }

        // Incrementa o contador de estudantes que evadiram por esse motivo
        inactivityReasonDistribution[student.periodoDeIngresso]![
            student.motivoDeEvasao!] = inactivityReasonDistribution[
                student.periodoDeIngresso]![student.motivoDeEvasao!]! +
            1;
      }
    }

    return inactivityReasonDistribution;
  }

  @override
  Map<String, Map<String, int>> getInactivityPerPeriodoDeEvasaoDistribution(
      List<Course> courses, List<String> terms) {
    Map<String, Map<String, int>> inactivityDistribution = {};

    for (var course in courses) {
      for (var student in course.students ?? []) {
        // Verifica se o estudante evadiu e se o período de evasão está nos termos fornecidos
        if (student.periodoDeEvasao == null ||
            !terms.contains(student.periodoDeEvasao) ||
            student.motivoDeEvasao == null ||
            student.motivoDeEvasao == "REGULAR" ||
            student.motivoDeEvasao == "GRADUADO") {
          continue;
        }

        // Cria a chave para o período de evasão
        if (!inactivityDistribution.containsKey(student.periodoDeEvasao)) {
          inactivityDistribution[student.periodoDeEvasao] = {};
        }

        // Cria a chave para o motivo de evasão
        if (!inactivityDistribution[student.periodoDeEvasao]!
            .containsKey(student.motivoDeEvasao)) {
          inactivityDistribution[student.periodoDeEvasao]![
              student.motivoDeEvasao!] = 0;
        }

        // Incrementa o contador de estudantes que evadiram por esse motivo
        inactivityDistribution[student.periodoDeEvasao]![
            student.motivoDeEvasao!] = inactivityDistribution[
                student.periodoDeEvasao]![student.motivoDeEvasao!]! +
            1;
      }
    }

    return inactivityDistribution;
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

  // 10. Distribuição por naturalidade ao longo dos períodos (associando nulos a "Desconhecido").
  @override
  Map<String, Map<String, int>> getOriginDistribution(
      List<Course> courses, List<String> terms) {
    Map<String, Map<String, int>> originDistribution = {};
    for (var course in courses) {
      for (var student in course.students ?? []) {
        if (student.periodoDeIngresso == null ||
            !terms.contains(student.periodoDeIngresso)) {
          continue;
        }

        // Se naturalidade for nulo, associe a "Desconhecido"
        String naturalidade = student.naturalidade ?? 'Desconhecido';

        if (!originDistribution.containsKey(student.periodoDeIngresso)) {
          originDistribution[student.periodoDeIngresso] = {};
        }
        if (!originDistribution[student.periodoDeIngresso]!
            .containsKey(naturalidade)) {
          originDistribution[student.periodoDeIngresso]![naturalidade] = 0;
        }
        originDistribution[student.periodoDeIngresso]![naturalidade] =
            originDistribution[student.periodoDeIngresso]![naturalidade]! + 1;
      }
    }
    return originDistribution;
  }

// 11. Distribuição por cor ao longo dos períodos (associando nulos a "Desconhecido").
  @override
  Map<String, Map<String, int>> getColorDistribution(
      List<Course> courses, List<String> terms) {
    Map<String, Map<String, int>> colorDistribution = {};
    for (var course in courses) {
      for (var student in course.students ?? []) {
        if (student.periodoDeIngresso == null ||
            !terms.contains(student.periodoDeIngresso)) {
          continue;
        }

        // Se cor for nulo, associe a "Desconhecido"
        String cor = student.cor ?? 'Desconhecido';

        if (!colorDistribution.containsKey(student.periodoDeIngresso)) {
          colorDistribution[student.periodoDeIngresso] = {};
        }
        if (!colorDistribution[student.periodoDeIngresso]!.containsKey(cor)) {
          colorDistribution[student.periodoDeIngresso]![cor] = 0;
        }
        colorDistribution[student.periodoDeIngresso]![cor] =
            colorDistribution[student.periodoDeIngresso]![cor]! + 1;
      }
    }
    return colorDistribution;
  }

// 12. Distribuição por deficiências ao longo dos períodos (ignorando null e listas vazias).
  @override
  Map<String, Map<String, int>> getDisabilitiesDistribution(
      List<Course> courses, List<String> terms) {
    Map<String, Map<String, int>> disabilitiesDistribution = {};
    for (var course in courses) {
      for (var student in course.students ?? []) {
        if (student.periodoDeIngresso == null ||
            !terms.contains(student.periodoDeIngresso) ||
            student.deficiencias == null ||
            student.deficiencias!.isEmpty) {
          continue;
        }

        for (var deficiencia in student.deficiencias!) {
          if (!disabilitiesDistribution
              .containsKey(student.periodoDeIngresso)) {
            disabilitiesDistribution[student.periodoDeIngresso] = {};
          }
          if (!disabilitiesDistribution[student.periodoDeIngresso]!
              .containsKey(deficiencia)) {
            disabilitiesDistribution[student.periodoDeIngresso]![deficiencia] =
                0;
          }
          disabilitiesDistribution[student.periodoDeIngresso]![deficiencia] =
              disabilitiesDistribution[student.periodoDeIngresso]![
                      deficiencia]! +
                  1;
        }
      }
    }
    return disabilitiesDistribution;
  }

  @override
  Map<String, Map<String, int>> getAgeAtEnrollmentDistribution(
      List<Course> courses, List<String> terms) {
    Map<String, Map<String, int>> ageDistribution = {};
    for (var course in courses) {
      for (var student in course.students ?? []) {
        if (student.periodoDeIngresso == null ||
            !terms.contains(student.periodoDeIngresso)) {
          continue;
        }
        // Calcular a idade no momento da matrícula
        int idadeNaMatricula = _calcularIdadeNaMatricula(
            int.parse(student.idade), student.periodoDeIngresso);

        String ageRange = _getAgeRange(idadeNaMatricula.toString());
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

  int _calcularIdadeNaMatricula(int idadeAtual, String periodoIngresso) {
    // Extraindo o ano de ingresso do período
    List<String> partesPeriodo = periodoIngresso.split('.');
    int anoIngresso = int.parse(partesPeriodo[0]);

    // Obtendo o ano atual
    DateTime dataAtual = DateTime.now();
    int anoAtual = dataAtual.year;

    // Calculando a diferença de anos
    int diferencaAnos = anoAtual - anoIngresso;

    // Calculando a idade no momento da matrícula
    int idadeNaMatricula = idadeAtual - diferencaAnos;

    return idadeNaMatricula;
  }

  String _getAgeRange(String age) {
    int idade = int.parse(age);
    if (idade >= 16 && idade <= 18) {
      return '16-18';
    } else if (idade >= 19 && idade <= 21) {
      return '19-21';
    } else if (idade >= 22 && idade <= 24) {
      return '22-24';
    } else if (idade >= 25 && idade <= 27) {
      return '25-27';
    } else if (idade >= 28 && idade <= 30) {
      return '28-30';
    } else {
      return '31+';
    }
  }
}
