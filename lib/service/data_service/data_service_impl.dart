import 'package:bi_ufcg/domain/models/course.dart';
import 'data_service.dart';

class DataServiceImpl implements DataService {
  DataServiceImpl();

  // 1. Evolução do número de matrículas ao longo dos períodos.
  @override
  Map<String, double> getEnrollmentEvolution(
      List<Course> courses, List<String> terms) {
    Map<String, double> enrollmentEvolution = {};
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
  Map<String, Map<String, double>> getGenderDistribution(
      List<Course> courses, List<String> terms) {
    Map<String, Map<String, double>> genderDistribution = {};
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
  Map<String, Map<String, double>> getAgeDistribution(
      List<Course> courses, List<String> terms) {
    Map<String, Map<String, double>> ageDistribution = {};
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
  Map<String, Map<String, double>> getAffirmativePolicyDistribution(
      List<Course> courses, List<String> terms) {
    Map<String, Map<String, double>> affirmativePolicyDistribution = {};
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
  Map<String, Map<String, double>> getStatusDistribution(
      List<Course> courses, List<String> terms) {
    Map<String, Map<String, double>> statusDistribution = {};
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
  Map<String, Map<String, double>> getInactivityReasonDistribution(
      List<Course> courses, List<String> terms) {
    Map<String, Map<String, double>> inactivityReasonDistribution = {};

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
  Map<String, Map<String, double>> getInactivityPerPeriodoDeEvasaoDistribution(
      List<Course> courses, List<String> terms) {
    Map<String, Map<String, double>> inactivityDistribution = {};

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
  Map<String, Map<String, double>> getAdmissionTypeDistribution(
      List<Course> courses, List<String> terms) {
    Map<String, Map<String, double>> admissionTypeDistribution = {};
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
  Map<String, Map<String, double>> getSecondarySchoolTypeDistribution(
      List<Course> courses, List<String> terms) {
    Map<String, Map<String, double>> secondarySchoolTypeDistribution = {};
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
  Map<String, Map<String, double>> getOriginDistribution(
      List<Course> courses, List<String> terms) {
    Map<String, Map<String, double>> originDistribution = {};
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
  Map<String, Map<String, double>> getColorDistribution(
      List<Course> courses, List<String> terms) {
    Map<String, Map<String, double>> colorDistribution = {};
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
  Map<String, Map<String, double>> getDisabilitiesDistribution(
      List<Course> courses, List<String> terms) {
    Map<String, Map<String, double>> disabilitiesDistribution = {};
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
  Map<String, Map<String, double>> getAgeAtEnrollmentDistribution(
      List<Course> courses, List<String> terms) {
    Map<String, Map<String, double>> ageDistribution = {};
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

  @override
  Map<String, Map<String, double>> getCreditCompletedVsFailedDistribution(
      List<Course> courses, List<String> terms) {
    Map<String, Map<String, double>> creditDistribution = {};
    for (var course in courses) {
      for (var student in course.students ?? []) {
        if (student.periodoDeIngresso == null ||
            !terms.contains(student.periodoDeIngresso)) {
          continue;
        }

        String period = student.periodoDeIngresso!;
        int failed = student.creditosFalhados ?? 0;
        int completed = student.creditosCompletados ?? 0;

        if (!creditDistribution.containsKey(period)) {
          creditDistribution[period] = {'Completados': 0, 'Falhados': 0};
        }

        creditDistribution[period]!['Falhados'] =
            creditDistribution[period]!['Falhados']! + failed;
        creditDistribution[period]!['Completados'] =
            creditDistribution[period]!['Completados']! + completed;
      }
    }
    return creditDistribution;
  }

  @override
  Map<String, Map<String, double>> getEvasionStatisticsByEvasionPeriod(
      List<Course> courses, List<String> terms) {
    Map<String, Map<String, double>> evasionStatistics = {};

    for (var course in courses) {
      for (var student in course.students ?? []) {
        if (student.periodoDeEvasao == null ||
            !terms.contains(student.periodoDeEvasao) ||
            student.situacao == "ATIVO") {
          continue;
        }

        // Ignorar o motivo de evasão GRADUADO ou REGULAR
        if (student.motivoDeEvasao == 'GRADUADO' ||
            student.motivoDeEvasao == 'REGULAR') {
          continue;
        }

        if (!evasionStatistics.containsKey(student.periodoDeEvasao)) {
          evasionStatistics[student.periodoDeEvasao] = {
            'Soma Créditos Tentados': 0,
            'Soma Créditos Falhados': 0,
            'Soma Velocidade Média': 0,
            'Soma Períodos Completados': 0,
            'Soma CRA': 0,
            'Total Evadidos': 0,
          };
        }

        var currentStats = evasionStatistics[student.periodoDeEvasao]!;

        // Acumular soma dos créditos tentados
        if (student.creditosTentados != null) {
          currentStats['Soma Créditos Tentados'] =
              currentStats['Soma Créditos Tentados']! +
                  student.creditosTentados!;
        }

        // Acumular soma dos créditos falhados
        if (student.creditosFalhados != null) {
          currentStats['Soma Créditos Falhados'] =
              currentStats['Soma Créditos Falhados']! +
                  student.creditosFalhados!;
        }

        // Acumular soma da velocidade média
        if (student.velocidadeMedia != null) {
          currentStats['Soma Velocidade Média'] =
              currentStats['Soma Velocidade Média']! + student.velocidadeMedia!;
        }

        // Acumular soma dos períodos completados
        if (student.periodosCompletados != null) {
          currentStats['Soma Períodos Completados'] =
              currentStats['Soma Períodos Completados']! +
                  student.periodosCompletados!;
        }

        // Calcular e acumular o CRA
        if (student.notasAcumuladas != null && student.creditosDoCra != null) {
          if (student.creditosDoCra! > 0 && student.notasAcumuladas! > 0) {
            double cra = student.notasAcumuladas! / student.creditosDoCra!;
            currentStats['Soma CRA'] = currentStats['Soma CRA']! + cra;
          }
        }

        // Incrementar o total de evadidos
        currentStats['Total Evadidos'] = currentStats['Total Evadidos']! + 1;
      }
    }

    // Calcular as médias ao final
    evasionStatistics.forEach((period, stats) {
      if (stats['Total Evadidos']! > 0) {
        stats['Média Créditos Tentados'] =
            stats['Soma Créditos Tentados']! / stats['Total Evadidos']!;
        stats['Média Créditos Falhados'] =
            stats['Soma Créditos Falhados']! / stats['Total Evadidos']!;
        stats['Média Velocidade Média'] =
            stats['Soma Velocidade Média']! / stats['Total Evadidos']!;
        stats['Média Períodos Completados'] =
            stats['Soma Períodos Completados']! / stats['Total Evadidos']!;
        stats['Média CRA'] = stats['Soma CRA']! / stats['Total Evadidos']!;
      }

      // Remover as somas intermediárias após o cálculo das médias
      stats.remove('Soma Créditos Tentados');
      stats.remove('Soma Créditos Falhados');
      stats.remove('Soma Velocidade Média');
      stats.remove('Soma Períodos Completados');
      stats.remove('Soma CRA');
      stats.remove('Total Evadidos');
    });

    return evasionStatistics;
  }

  @override
  Map<String, Map<String, double>> getGraduationStatisticsByEvasionPeriod(
      List<Course> courses, List<String> terms) {
    Map<String, Map<String, double>> graduationStatistics = {};

    for (var course in courses) {
      for (var student in course.students ?? []) {
        if (student.periodoDeEvasao == null ||
            !terms.contains(student.periodoDeEvasao) ||
            student.situacao == "ATIVO") {
          continue;
        }

        // Considerar apenas o motivo de evasão "GRADUADO"
        if (student.motivoDeEvasao != 'GRADUADO') {
          continue;
        }

        if (!graduationStatistics.containsKey(student.periodoDeEvasao)) {
          graduationStatistics[student.periodoDeEvasao] = {
            'Soma Créditos Tentados': 0,
            'Soma Créditos Falhados': 0,
            'Soma Velocidade Média': 0,
            'Soma Períodos Completados': 0,
            'Soma CRA': 0,
            'Total Graduados': 0,
          };
        }

        var currentStats = graduationStatistics[student.periodoDeEvasao]!;

        // Acumular soma dos créditos tentados
        if (student.creditosTentados != null) {
          currentStats['Soma Créditos Tentados'] =
              currentStats['Soma Créditos Tentados']! +
                  student.creditosTentados!;
        }

        // Acumular soma dos créditos falhados
        if (student.creditosFalhados != null) {
          currentStats['Soma Créditos Falhados'] =
              currentStats['Soma Créditos Falhados']! +
                  student.creditosFalhados!;
        }

        // Acumular soma da velocidade média
        if (student.velocidadeMedia != null) {
          currentStats['Soma Velocidade Média'] =
              currentStats['Soma Velocidade Média']! + student.velocidadeMedia!;
        }

        // Acumular soma dos períodos completados
        if (student.periodosCompletados != null) {
          currentStats['Soma Períodos Completados'] =
              currentStats['Soma Períodos Completados']! +
                  student.periodosCompletados!;
        }

        // Calcular e acumular o CRA
        if (student.notasAcumuladas != null && student.creditosDoCra != null) {
          if (student.creditosDoCra! > 0 && student.notasAcumuladas! > 0) {
            double cra = student.notasAcumuladas! / student.creditosDoCra!;
            currentStats['Soma CRA'] = currentStats['Soma CRA']! + cra;
          }
        }

        // Incrementar o total de graduados
        currentStats['Total Graduados'] = currentStats['Total Graduados']! + 1;
      }
    }

    // Calcular as médias ao final
    graduationStatistics.forEach((period, stats) {
      if (stats['Total Graduados']! > 0) {
        stats['Média Créditos Tentados'] =
            stats['Soma Créditos Tentados']! / stats['Total Graduados']!;
        stats['Média Créditos Falhados'] =
            stats['Soma Créditos Falhados']! / stats['Total Graduados']!;
        stats['Média Velocidade Média'] =
            stats['Soma Velocidade Média']! / stats['Total Graduados']!;
        stats['Média Períodos Completados'] =
            stats['Soma Períodos Completados']! / stats['Total Graduados']!;
        stats['Média CRA'] = stats['Soma CRA']! / stats['Total Graduados']!;
      }

      // Remover as somas intermediárias após o cálculo das médias
      stats.remove('Soma Créditos Tentados');
      stats.remove('Soma Créditos Falhados');
      stats.remove('Soma Velocidade Média');
      stats.remove('Soma Períodos Completados');
      stats.remove('Soma CRA');
      stats.remove('Total Graduados');
    });

    return graduationStatistics;
  }

  @override
  Map<String, Map<String, double>> getEvasionByColor(
      List<Course> courses, List<String> terms) {
    Map<String, Map<String, double>> evasionByColor = {};

    for (var course in courses) {
      for (var student in course.students ?? []) {
        if (student.periodoDeEvasao == null ||
            !terms.contains(student.periodoDeEvasao) ||
            student.situacao == "ATIVO") {
          continue;
        }

        // Ignorar os motivos de evasão REGULAR e GRADUADO
        if (student.motivoDeEvasao == 'GRADUADO' ||
            student.motivoDeEvasao == 'REGULAR') {
          continue;
        }

        // Inicializa o período se ainda não estiver no mapa
        if (!evasionByColor.containsKey(student.periodoDeEvasao)) {
          evasionByColor[student.periodoDeEvasao] = {};
        }

        String cor = student.cor ?? 'Desconhecido';

        // Incrementa o contador da cor
        if (!evasionByColor[student.periodoDeEvasao]!.containsKey(cor)) {
          evasionByColor[student.periodoDeEvasao]![cor] = 0;
        }

        evasionByColor[student.periodoDeEvasao]![cor] =
            evasionByColor[student.periodoDeEvasao]![cor]! + 1;
      }
    }

    return evasionByColor;
  }

  @override
  Map<String, Map<String, double>> getEvasionByAge(
      List<Course> courses, List<String> terms) {
    Map<String, Map<String, double>> evasionByAgeGroup = {};

    for (var course in courses) {
      for (var student in course.students ?? []) {
        if (student.periodoDeEvasao == null ||
            !terms.contains(student.periodoDeEvasao) ||
            student.situacao == "ATIVO") {
          continue;
        }

        // Ignorar motivos de evasão REGULAR e GRADUADO
        if (student.motivoDeEvasao == 'GRADUADO' ||
            student.motivoDeEvasao == 'REGULAR') {
          continue;
        }

        // Calcula a idade no momento da evasão
        int idadeNoMomentoDaEvasao = _calcularIdadeNaEvasao(
          int.parse(student.idade),
          student.periodoDeIngresso,
          student.periodoDeEvasao!,
        );

        // Obtém a faixa etária
        String faixaEtaria = _getAgeRange(idadeNoMomentoDaEvasao.toString());

        // Adiciona o período de evasão no mapa, se não existir
        if (!evasionByAgeGroup.containsKey(student.periodoDeEvasao)) {
          evasionByAgeGroup[student.periodoDeEvasao!] = {};
        }

        // Adiciona a faixa etária no mapa para o período de evasão, se não existir
        if (!evasionByAgeGroup[student.periodoDeEvasao]!
            .containsKey(faixaEtaria)) {
          evasionByAgeGroup[student.periodoDeEvasao]![faixaEtaria] = 0;
        }

        // Incrementa o contador da faixa etária para o período de evasão
        evasionByAgeGroup[student.periodoDeEvasao]![faixaEtaria] =
            evasionByAgeGroup[student.periodoDeEvasao]![faixaEtaria]! + 1;
      }
    }

    return evasionByAgeGroup;
  }

// Método para calcular a idade no momento da evasão
  int _calcularIdadeNaEvasao(
      int idadeAtual, String periodoIngresso, String periodoEvasao) {
    List<String> partesPeriodoIngresso = periodoIngresso.split('.');
    int anoIngresso = int.parse(partesPeriodoIngresso[0]);

    List<String> partesPeriodoEvasao = periodoEvasao.split('.');
    int anoEvasao = int.parse(partesPeriodoEvasao[0]);

    // Calcula a diferença de anos entre o ingresso e a evasão
    int diferencaAnos = anoEvasao - anoIngresso;

    // Calcula a idade no momento da evasão
    int idadeNaEvasao = idadeAtual - diferencaAnos;

    return idadeNaEvasao;
  }

  @override
  Map<String, Map<String, double>> getEvasionByGender(
      List<Course> courses, List<String> terms) {
    Map<String, Map<String, double>> evasionByGender = {};

    for (var course in courses) {
      for (var student in course.students ?? []) {
        if (student.periodoDeEvasao == null ||
            !terms.contains(student.periodoDeEvasao) ||
            student.situacao == "ATIVO") {
          continue;
        }

        // Ignorar os motivos de evasão REGULAR e GRADUADO
        if (student.motivoDeEvasao == 'GRADUADO' ||
            student.motivoDeEvasao == 'REGULAR') {
          continue;
        }

        // Inicializa o período se ainda não estiver no mapa
        if (!evasionByGender.containsKey(student.periodoDeEvasao)) {
          evasionByGender[student.periodoDeEvasao] = {};
        }

        String genero = student.genero ?? 'Desconhecido';

        // Incrementa o contador do gênero
        if (!evasionByGender[student.periodoDeEvasao]!.containsKey(genero)) {
          evasionByGender[student.periodoDeEvasao]![genero] = 0;
        }

        evasionByGender[student.periodoDeEvasao]![genero] =
            evasionByGender[student.periodoDeEvasao]![genero]! + 1;
      }
    }

    return evasionByGender;
  }

  @override
  Map<String, Map<String, double>> getEvasionByAdmissionType(
      List<Course> courses, List<String> terms) {
    Map<String, Map<String, double>> evasionByAdmissionType = {};

    for (var course in courses) {
      for (var student in course.students ?? []) {
        if (student.periodoDeEvasao == null ||
            !terms.contains(student.periodoDeEvasao) ||
            student.situacao == "ATIVO") {
          continue;
        }

        // Ignorar os motivos de evasão REGULAR e GRADUADO
        if (student.motivoDeEvasao == 'GRADUADO' ||
            student.motivoDeEvasao == 'REGULAR') {
          continue;
        }

        // Inicializa o período se ainda não estiver no mapa
        if (!evasionByAdmissionType.containsKey(student.periodoDeEvasao)) {
          evasionByAdmissionType[student.periodoDeEvasao] = {};
        }

        String formaDeIngresso = student.formaDeIngresso ?? 'Desconhecido';

        // Incrementa o contador da forma de ingresso
        if (!evasionByAdmissionType[student.periodoDeEvasao]!
            .containsKey(formaDeIngresso)) {
          evasionByAdmissionType[student.periodoDeEvasao]![formaDeIngresso] = 0;
        }

        evasionByAdmissionType[student.periodoDeEvasao]![formaDeIngresso] =
            evasionByAdmissionType[student.periodoDeEvasao]![formaDeIngresso]! +
                1;
      }
    }

    return evasionByAdmissionType;
  }

  @override
  Map<String, Map<String, double>> getEvasionBySecondarySchoolType(
      List<Course> courses, List<String> terms) {
    Map<String, Map<String, double>> evasionBySecondarySchoolType = {};

    for (var course in courses) {
      for (var student in course.students ?? []) {
        if (student.periodoDeEvasao == null ||
            !terms.contains(student.periodoDeEvasao) ||
            student.situacao == "ATIVO") {
          continue;
        }

        // Ignorar os motivos de evasão REGULAR e GRADUADO
        if (student.motivoDeEvasao == 'GRADUADO' ||
            student.motivoDeEvasao == 'REGULAR') {
          continue;
        }

        // Inicializa o período se ainda não estiver no mapa
        if (!evasionBySecondarySchoolType
            .containsKey(student.periodoDeEvasao)) {
          evasionBySecondarySchoolType[student.periodoDeEvasao] = {};
        }

        String tipoDeEnsinoMedio = student.tipoDeEnsinoMedio ?? 'Desconhecido';

        // Incrementa o contador do tipo de ensino médio
        if (!evasionBySecondarySchoolType[student.periodoDeEvasao]!
            .containsKey(tipoDeEnsinoMedio)) {
          evasionBySecondarySchoolType[student.periodoDeEvasao]![
              tipoDeEnsinoMedio] = 0;
        }

        evasionBySecondarySchoolType[student.periodoDeEvasao]![
            tipoDeEnsinoMedio] = evasionBySecondarySchoolType[
                student.periodoDeEvasao]![tipoDeEnsinoMedio]! +
            1;
      }
    }

    return evasionBySecondarySchoolType;
  }

  @override
  Map<String, Map<String, double>> getEvasionByDisabilities(
      List<Course> courses, List<String> terms) {
    Map<String, Map<String, double>> evasionByDisabilities = {};

    for (var course in courses) {
      for (var student in course.students ?? []) {
        if (student.periodoDeEvasao == null ||
            !terms.contains(student.periodoDeEvasao) ||
            student.situacao == "ATIVO") {
          continue;
        }

        // Ignorar os motivos de evasão REGULAR e GRADUADO
        if (student.motivoDeEvasao == 'GRADUADO' ||
            student.motivoDeEvasao == 'REGULAR') {
          continue;
        }

        // Ignorar estudantes sem deficiências
        if (student.deficiencias == null || student.deficiencias!.isEmpty) {
          continue;
        }

        // Iterar sobre as deficiências do estudante
        for (var deficiencia in student.deficiencias!) {
          // Inicializa o período se ainda não estiver no mapa
          if (!evasionByDisabilities.containsKey(student.periodoDeEvasao)) {
            evasionByDisabilities[student.periodoDeEvasao] = {};
          }

          // Incrementa o contador da deficiência
          if (!evasionByDisabilities[student.periodoDeEvasao]!
              .containsKey(deficiencia)) {
            evasionByDisabilities[student.periodoDeEvasao]![deficiencia] = 0;
          }

          evasionByDisabilities[student.periodoDeEvasao]![deficiencia] =
              evasionByDisabilities[student.periodoDeEvasao]![deficiencia]! + 1;
        }
      }
    }

    return evasionByDisabilities;
  }
}
