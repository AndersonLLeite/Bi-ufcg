import 'package:flutter/material.dart';

class InfoChartStrings {
  static InfoChartStrings? _instance;
  // Avoid self isntance
  InfoChartStrings._();
  static InfoChartStrings get instance {
    _instance ??= InfoChartStrings._();
    return _instance!;
  }

  String get admissionInfo =>
      "Esse dado informa como os alunos ingressaram no curso, classificando-os de acordo com os diferentes tipos de admissão, como vestibular, ENEM ou transferência, ao longo dos períodos acadêmicos. Isso permite identificar quais formas de ingresso foram mais comuns em cada período, ajudando a entender o perfil de entrada dos alunos.";
  String get genderInfo =>
      'Aqui é mostrada a distribuição de alunos por gênero ao longo dos períodos acadêmicos. Para cada período, são contabilizados os alunos conforme os gêneros informados, como  "Masculino", "Feminino" ou outras categorias especificadas. Esse dado fornece uma visão demográfica sobre o gênero dos alunos que ingressaram em cada período.';
  String get ageInfo =>
      "Esse dado classifica os alunos em faixas etárias (como 16-18, 19-21, etc.) e distribui esses grupos ao longo dos períodos acadêmicos. O objetivo é entender a faixa etária predominante em cada período de ingresso, mostrando a diversidade de idades entre os alunos de cada período. A faixa etária é gerada a partir da idade atual dos alunos";
  String get ageAtEnrollmentInfo =>
      "A distribuição por idade na matrícula mostra a idade dos alunos no momento da matrícula em cada período acadêmico. Os alunos são classificados em faixas etárias, permitindo visualizar a idade predominante dos alunos no momento da entrada no curso. A idade é calculada a partir da data de nascimento e do período de ingresso.";
  String get affirmativePolicyInfo =>
      "A distribuição por cotas de ação afirmativa mostra quantos alunos se beneficiaram de políticas afirmativas em cada período acadêmico. Essas políticas podem incluir diferentes tipos de cotas, como raciais ou sociais. O dado agrupa os alunos conforme a política afirmativa pela qual foram admitidos, permitindo entender a evolução e a representatividade dessas políticas ao longo do tempo";
  String get statusInfo =>
      "Esse dado apresenta a quantidade de alunos em situação ativa ou inativa ao longo dos períodos acadêmicos. Para cada período, os alunos são classificados de acordo com o seu status no curso, permitindo visualizar a quantidade de estudantes ativos (matriculados) ou inativos. Alunos graduados fazem parte da contagem de inativos";
  String get inactivityReasonsInfo =>
      "A distribuição dos motivos de evasão analisa as razões pelas quais os alunos deixaram o curso, levando em consideração aqueles que evadiram no mesmo período em que ingressaram (PI = PE). Essa análise permite identificar os principais fatores que contribuem para a inatividade dos alunos, destacando padrões e tendências que podem ser fundamentais para a formulação de estratégias de retenção ao longo dos períodos acadêmicos";
  String get inactivityPerPeriodoDeEvasao =>
      'A distribuição dos motivos de evasão por período oferece uma visão abrangente dos motivos que levaram os alunos à inatividade, considerando o period acadêmico em que os alunos evadiu. Essa abordagem facilita a identificação de variações nos motivos ao longo do tempo e possibilita um entendimento mais profundo dos desafios enfrentados pelos alunos, permitindo ações direcionadas para melhorar a permanência e o sucesso acadêmico.';
  String get secondarySchoolInfo =>
      "A distribuição por tipo de escola secundária mostra o tipo de ensino médio cursado pelos alunos antes de ingressarem no curso superior, seja ele público ou privado, ao longo dos períodos. Esse dado ajuda a compreender o histórico educacional dos alunos e sua relação com o tipo de escola frequentada.";
  String get colorInfo =>
      'A distribuição por cor categoriza os alunos de acordo com a autodeclaração de cor ou raça ao longo dos períodos acadêmicos. Esse dado ajuda a entender a composição racial dos alunos ingressantes em cada período.';
  String get originInfo =>
      'A naturalidade dos alunos refere-se ao local de nascimento (estado) e é distribuída ao longo dos períodos acadêmicos. Para cada período, os alunos são classificados de acordo com sua naturalidade. Quando essa informação não está disponível, é registrada como "Desconhecido". Isso permite traçar um perfil geográfico dos alunos ao longo dos anos.';
  String get disabilityInfo =>
      'Esse dado apresenta a distribuição de alunos com deficiências declaradas ao longo dos períodos acadêmicos. Para cada período, são contabilizados os alunos com algum tipo de deficiência informada, categorizando as diferentes deficiências.';
}

extension InfoChartStringsExtensions on BuildContext {
  InfoChartStrings get infoStrings => InfoChartStrings.instance;
}
