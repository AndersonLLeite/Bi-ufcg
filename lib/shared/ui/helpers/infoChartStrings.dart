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
      "Esse dado informa como os discentes ingressaram no curso, classificando-os de acordo com os diferentes tipos de admissão, como vestibular, ENEM ou transferência, ao longo dos períodos acadêmicos. Isso permite identificar quais formas de ingresso foram mais comuns em cada período, ajudando a entender o perfil de entrada dos discentes.";
  String get genderInfo =>
      'Aqui é mostrada a distribuição de discentes por gênero ao longo dos períodos acadêmicos. Para cada período, são contabilizados os discentes conforme os gêneros informados, como  "Masculino", "Feminino" ou outras categorias especificadas. Esse dado fornece uma visão demográfica sobre o gênero dos discentes que ingressaram em cada período.';
  String get ageInfo =>
      "Esse dado classifica os discentes em faixas etárias (como 16-18, 19-21, etc.) e distribui esses grupos ao longo dos períodos acadêmicos. O objetivo é entender a faixa etária predominante em cada período de ingresso, mostrando a diversidade de idades entre os discentes de cada período. A faixa etária é gerada a partir da idade atual dos discentes";
  String get ageAtEnrollmentInfo =>
      "A distribuição por idade na matrícula mostra a idade dos discentes no momento da matrícula em cada período acadêmico. Os discentes são classificados em faixas etárias, permitindo visualizar a idade predominante dos discentes no momento da entrada no curso. A idade é calculada a partir da data de nascimento e do período de ingresso.";
  String get affirmativePolicyInfo =>
      "A distribuição por cotas de ação afirmativa mostra quantos discentes se beneficiaram de políticas afirmativas em cada período acadêmico. Essas políticas podem incluir diferentes tipos de cotas, como raciais ou sociais. O dado agrupa os discentes conforme a política afirmativa pela qual foram admitidos, permitindo entender a evolução e a representatividade dessas políticas ao longo do tempo";
  String get statusInfo =>
      "Esse dado apresenta a quantidade de discentes em situação ativa ou inativa ao longo dos períodos acadêmicos. Para cada período, os discentes são classificados de acordo com o seu status no curso, permitindo visualizar a quantidade de discentes ativos (matriculados) ou inativos. discentes graduados fazem parte da contagem de inativos";
  String get inactivityReasonsInfo =>
      "A distribuição dos motivos de evasão analisa as razões pelas quais os discentes deixaram o curso, levando em consideração aqueles que evadiram no mesmo período em que ingressaram (PI = PE). Essa análise permite identificar os principais fatores que contribuem para a inatividade dos discentes, destacando padrões e tendências que podem ser fundamentais para a formulação de estratégias de retenção ao longo dos períodos acadêmicos";
  String get inactivityPerPeriodoDeEvasao =>
      'A distribuição dos motivos de evasão por período oferece uma visão abrangente dos motivos que levaram os discentes à inatividade, considerando o period acadêmico em que os discentes evadiu. Essa abordagem facilita a identificação de variações nos motivos ao longo do tempo e possibilita um entendimento mais profundo dos desafios enfrentados pelos discentes, permitindo ações direcionadas para melhorar a permanência e o sucesso acadêmico.';
  String get secondarySchoolInfo =>
      "A distribuição por tipo de escola secundária mostra o tipo de ensino médio cursado pelos discentes antes de ingressarem no curso superior, seja ele público ou privado, ao longo dos períodos. Esse dado ajuda a compreender o histórico educacional dos discentes e sua relação com o tipo de escola frequentada.";
  String get colorInfo =>
      'A distribuição por cor categoriza os discentes de acordo com a autodeclaração de cor ao longo dos períodos acadêmicos. Esse dado ajuda a entender a composição de cor de pele dos discentes ingressantes em cada período.';
  String get originInfo =>
      'A naturalidade dos discentes refere-se ao local de nascimento (estado) e é distribuída ao longo dos períodos acadêmicos. Para cada período, os discentes são classificados de acordo com sua naturalidade. Quando essa informação não está disponível, é registrada como "Desconhecido". Isso permite traçar um perfil geográfico dos discentes ao longo dos anos.';
  String get disabilityInfo =>
      'Esse dado apresenta a distribuição de discentes com deficiências declaradas ao longo dos períodos acadêmicos. Para cada período, são contabilizados os discentes com algum tipo de deficiência informada, categorizando as diferentes deficiências.';
  String get creditCompletedVsFailedInfo =>
      'A distribuição de créditos concluídos e Falhados compara a quantidade de créditos que os discentes concluíram com a quantidade de créditos que falharam em cada período acadêmico. Esse dado permite avaliar o desempenho acadêmico dos discentes, identificando padrões de aprovação e reprovação ao longo dos anos.';
  String get evasionStatisticsByEvasionPeriod =>
      'As estatísticas dos evadidos por período em que evadiram analisa o total de discentes que evadiram, excluindo aqueles que se graduaram ou são considerados regulares. Além disso, fornece informações sobre a média de créditos tentados, créditos falhados, velocidade média e a média de períodos completados. Esses dados são essenciais para entender as taxas de evasão e identificar tendências que podem influenciar as políticas de retenção e apoio acadêmico.';
  String get graduationStatisticsByEvasionPeriod =>
      'As estatísticas de graduados por período de egressão analisam o total de discentes que se graduaram, excluindo aqueles que evadiram ou são considerados regulares. Além disso, fornece informações sobre a média de créditos tentados, créditos falhados, velocidade média e a média de períodos completados. Esses dados são essenciais para entender as taxas de graduação e identificar tendências que podem influenciar as políticas de retenção e apoio acadêmico.';
  String get evasionByColor =>
      'A evasão por cor analisa a evasão dos discentes de acordo com a autodeclaração de cor ao longo dos períodos acadêmicos. Esse dado ajuda a entender a relação entre a evasão e a cor dos discentes, identificando possíveis disparidades no contexto da evasão.';
  String get evasionByAge =>
      'A evasão por idade analisa a evasão dos discentes de acordo com a faixa etária ao longo dos períodos acadêmicos. Esse dado ajuda a entender a relação entre a evasão e a idade dos discentes, identificando possíveis disparidades no contexto da evasão.';
  String get evasionByGender =>
      'A evasão por gênero analisa a evasão dos discentes de acordo com o gênero ao longo dos períodos acadêmicos. Esse dado ajuda a entender a relação entre a evasão e o gênero dos discentes, identificando possíveis disparidades no contexto da evasão.';
  String get evasionByAdmissionType =>
      'A evasão por forma de ingresso analisa a evasão dos discentes de acordo com a forma de ingresso ao longo dos períodos acadêmicos. Esse dado ajuda a entender a relação entre a evasão e a forma de ingresso dos discentes, identificando possíveis disparidades no contexto da evasão.';
  String get evasionBySecondarySchool =>
      'A evasão por tipo de ensino médio analisa a evasão dos discentes de acordo com o tipo de ensino médio ao longo dos períodos acadêmicos. Esse dado ajuda a entender a relação entre a evasão e o tipo de ensino médio dos discentes, identificando possíveis disparidades no contexto da evasão.';
  String get evasionByDisabilities =>
      'A evasão por deficiência analisa a evasão dos discentes de acordo com a presença de deficiências ao longo dos períodos acadêmicos. Esse dado ajuda a entender a relação entre a evasão e a presença de deficiências dos discentes, identificando possíveis disparidades no contexto da evasão.';
}

extension InfoChartStringsExtensions on BuildContext {
  InfoChartStrings get infoStrings => InfoChartStrings.instance;
}
