import 'dart:convert';

import 'package:flutter/foundation.dart';

class Student {
  // Atributos obrigatórios
  int? codigoDoCurso;
  String? genero;
  String? idade;
  String? situacao;
  String? motivoDeEvasao;
  String? periodoDeEvasao;
  String? formaDeIngresso;
  String? periodoDeIngresso;
  String? naturalidade;
  String? cor;
  List<String>? deficiencias;
  String? tipoDeEnsinoMedio;
  String? politicaAfirmativa;

  // Atributos opcionais
  String? matriculaDoEstudante;
  String? nome;
  String? nomeDoCurso;
  String? turnoDoCurso;
  int? codigoDoCurriculo;
  int? campus;
  String? nomeDoCampus;
  int? codigoDoSetor;
  String? nomeDoSetor;
  String? estadoCivil;
  String? endereco;
  String? dataDeNascimento;
  String? cpf;
  String? cep;
  String? telefone;
  String? email;
  String? nacionalidade;
  String? localDeNascimento;
  int? anoDeConclusaoEnsinoMedio;
  int? creditosDoCra;
  double? notasAcumuladas;
  int? periodosCompletados;
  int? creditosTentados;
  int? creditosCompletados;
  int? creditosIsentos;
  int? creditosFalhados;
  int? creditosSuspensos;
  int? creditosEmAndamento;
  double? velocidadeMedia;
  double? taxaDeSucesso;
  String? pracAtualizado;
  String? pracAtualizadoEm;
  String? pracCor;
  String? pracQuilombola;
  String? pracIndigenaAldeado;
  double? pracRendaPerCapitaAte;
  String? pracDeficiente;
  List<String>? pracDeficiencias;
  String? pracDeslocouMudou;
  int? ufpb;

  // Construtor
  Student({
    this.codigoDoCurso,
    this.genero,
    this.idade,
    this.situacao,
    this.motivoDeEvasao,
    this.periodoDeEvasao,
    this.formaDeIngresso,
    this.periodoDeIngresso,
    this.naturalidade,
    this.cor,
    this.deficiencias,
    this.tipoDeEnsinoMedio,
    this.politicaAfirmativa,
    this.matriculaDoEstudante,
    this.nome,
    this.nomeDoCurso,
    this.turnoDoCurso,
    this.codigoDoCurriculo,
    this.campus,
    this.nomeDoCampus,
    this.codigoDoSetor,
    this.nomeDoSetor,
    this.estadoCivil,
    this.endereco,
    this.dataDeNascimento,
    this.cpf,
    this.cep,
    this.telefone,
    this.email,
    this.nacionalidade,
    this.localDeNascimento,
    this.anoDeConclusaoEnsinoMedio,
    this.creditosDoCra,
    this.notasAcumuladas,
    this.periodosCompletados,
    this.creditosTentados,
    this.creditosCompletados,
    this.creditosIsentos,
    this.creditosFalhados,
    this.creditosSuspensos,
    this.creditosEmAndamento,
    this.velocidadeMedia,
    this.taxaDeSucesso,
    this.pracAtualizado,
    this.pracAtualizadoEm,
    this.pracCor,
    this.pracQuilombola,
    this.pracIndigenaAldeado,
    this.pracRendaPerCapitaAte,
    this.pracDeficiente,
    this.pracDeficiencias,
    this.pracDeslocouMudou,
    this.ufpb,
  });

  // Método para criar uma instância de Student a partir de um Map
  factory Student.fromMap(Map<String, dynamic> map) {
    return Student(
      codigoDoCurso: map['codigo_do_curso'] as int?,
      genero: map['genero'] as String?,
      idade: map['idade'] as String?,
      situacao: map['situacao'] as String?,
      motivoDeEvasao: map['motivo_de_evasao'] as String?,
      periodoDeEvasao: map['periodo_de_evasao'] as String?,
      formaDeIngresso: map['forma_de_ingresso'] as String?,
      periodoDeIngresso: map['periodo_de_ingresso'] as String?,
      naturalidade: map['naturalidade'] as String?,
      cor: map['cor'] as String?,
      deficiencias: map['deficiencias'] != null
          ? List<String>.from(map['deficiencias'])
          : null,
      tipoDeEnsinoMedio: map['tipo_de_ensino_medio'] as String?,
      politicaAfirmativa: map['politica_afirmativa'] as String?,
      matriculaDoEstudante: map['matricula_do_estudante'] as String?,
      nome: map['nome'] as String?,
      nomeDoCurso: map['nome_do_curso'] as String?,
      turnoDoCurso: map['turno_do_curso'] as String?,
      codigoDoCurriculo: map['codigo_do_curriculo'] as int?,
      campus: map['campus'] as int?,
      nomeDoCampus: map['nome_do_campus'] as String?,
      codigoDoSetor: map['codigo_do_setor'] as int?,
      nomeDoSetor: map['nome_do_setor'] as String?,
      estadoCivil: map['estado_civil'] as String?,
      endereco: map['endereco'] as String?,
      dataDeNascimento: map['data_de_nascimento'] as String?,
      cpf: map['cpf'] as String?,
      cep: map['cep'] as String?,
      telefone: map['telefone'] as String?,
      email: map['email'] as String?,
      nacionalidade: map['nacionalidade'] as String?,
      localDeNascimento: map['local_de_nascimento'] as String?,
      anoDeConclusaoEnsinoMedio: map['ano_de_conclusao_ensino_medio'] as int?,
      creditosDoCra: map['creditos_do_cra'] as int?,
      notasAcumuladas: map['notas_acumuladas'] as double?,
      periodosCompletados: map['periodos_completados'] as int?,
      creditosTentados: map['creditos_tentados'] as int?,
      creditosCompletados: map['creditos_completados'] as int?,
      creditosIsentos: map['creditos_isentos'] as int?,
      creditosFalhados: map['creditos_falhados'] as int?,
      creditosSuspensos: map['creditos_suspensos'] as int?,
      creditosEmAndamento: map['creditos_em_andamento'] as int?,
      velocidadeMedia: map['velocidade_media'] as double?,
      taxaDeSucesso: map['taxa_de_sucesso'] as double?,
      pracAtualizado: map['prac_atualizado'] as String?,
      pracAtualizadoEm: map['prac_atualizado_em'] as String?,
      pracCor: map['prac_cor'] as String?,
      pracQuilombola: map['prac_quilombola'] as String?,
      pracIndigenaAldeado: map['prac_indigena_aldeado'] as String?,
      pracRendaPerCapitaAte: map['prac_renda_per_capita_ate'] as double?,
      pracDeficiente: map['prac_deficiente'] as String?,
      pracDeficiencias: map['prac_deficiencias'] != null
          ? List<String>.from(map['prac_deficiencias'])
          : null,
      pracDeslocouMudou: map['prac_deslocou_mudou'] as String?,
      ufpb: map['ufpb'] as int?,
    );
  }

  // toMap
  Map<String, dynamic> toMap() {
    return {
      'codigoDoCurso': codigoDoCurso,
      'genero': genero,
      'idade': idade,
      'situacao': situacao,
      'motivoDeEvasao': motivoDeEvasao,
      'periodoDeEvasao': periodoDeEvasao,
      'formaDeIngresso': formaDeIngresso,
      'periodoDeIngresso': periodoDeIngresso,
      'naturalidade': naturalidade,
      'cor': cor,
      'deficiencias': deficiencias,
      'tipoDeEnsinoMedio': tipoDeEnsinoMedio,
      'politicaAfirmativa': politicaAfirmativa,
      'matriculaDoEstudante': matriculaDoEstudante,
      'nome': nome,
      'nomeDoCurso': nomeDoCurso,
      'turnoDoCurso': turnoDoCurso,
      'codigoDoCurriculo': codigoDoCurriculo,
      'campus': campus,
      'nomeDoCampus': nomeDoCampus,
      'codigoDoSetor': codigoDoSetor,
      'nomeDoSetor': nomeDoSetor,
      'estadoCivil': estadoCivil,
      'endereco': endereco,
      'dataDeNascimento': dataDeNascimento,
      'cpf': cpf,
      'cep': cep,
      'telefone': telefone,
      'email': email,
      'nacionalidade': nacionalidade,
      'localDeNascimento': localDeNascimento,
      'anoDeConclusaoEnsinoMedio': anoDeConclusaoEnsinoMedio,
      'creditosDoCra': creditosDoCra,
      'notasAcumuladas': notasAcumuladas,
      'periodosCompletados': periodosCompletados,
      'creditosTentados': creditosTentados,
      'creditosCompletados': creditosCompletados,
      'creditosIsentos': creditosIsentos,
      'creditosFalhados': creditosFalhados,
      'creditosSuspensos': creditosSuspensos,
      'creditosEmAndamento': creditosEmAndamento,
      'velocidadeMedia': velocidadeMedia,
      'taxaDeSucesso': taxaDeSucesso,
      'pracAtualizado': pracAtualizado,
      'pracAtualizadoEm': pracAtualizadoEm,
      'pracCor': pracCor,
      'pracQuilombola': pracQuilombola,
      'pracIndigenaAldeado': pracIndigenaAldeado,
      'pracRendaPerCapitaAte': pracRendaPerCapitaAte,
      'pracDeficiente': pracDeficiente,
      'pracDeficiencias': pracDeficiencias,
      'pracDeslocouMudou': pracDeslocouMudou,
      'ufpb': ufpb,
    };
  }

  // toJson
  String toJson() => json.encode(toMap());

  // fromJson
  factory Student.fromJson(String source) =>
      Student.fromMap(json.decode(source));

  //operator ==
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Student &&
        other.codigoDoCurso == codigoDoCurso &&
        other.genero == genero &&
        other.idade == idade &&
        other.situacao == situacao &&
        other.motivoDeEvasao == motivoDeEvasao &&
        other.periodoDeEvasao == periodoDeEvasao &&
        other.formaDeIngresso == formaDeIngresso &&
        other.periodoDeIngresso == periodoDeIngresso &&
        other.naturalidade == naturalidade &&
        other.cor == cor &&
        listEquals(other.deficiencias, deficiencias) &&
        other.tipoDeEnsinoMedio == tipoDeEnsinoMedio &&
        other.politicaAfirmativa == politicaAfirmativa &&
        other.matriculaDoEstudante == matriculaDoEstudante &&
        other.nome == nome &&
        other.nomeDoCurso == nomeDoCurso &&
        other.turnoDoCurso == turnoDoCurso &&
        other.codigoDoCurriculo == codigoDoCurriculo &&
        other.campus == campus &&
        other.nomeDoCampus == nomeDoCampus &&
        other.codigoDoSetor == codigoDoSetor &&
        other.nomeDoSetor == nomeDoSetor &&
        other.estadoCivil == estadoCivil &&
        other.endereco == endereco &&
        other.dataDeNascimento == dataDeNascimento &&
        other.cpf == cpf &&
        other.cep == cep &&
        other.telefone == telefone &&
        other.email == email &&
        other.nacionalidade == nacionalidade &&
        other.localDeNascimento == localDeNascimento &&
        other.anoDeConclusaoEnsinoMedio == anoDeConclusaoEnsinoMedio &&
        other.creditosDoCra == creditosDoCra &&
        other.notasAcumuladas == notasAcumuladas &&
        other.periodosCompletados == periodosCompletados &&
        other.creditosTentados == creditosTentados &&
        other.creditosCompletados == creditosCompletados &&
        other.creditosIsentos == creditosIsentos &&
        other.creditosFalhados == creditosFalhados &&
        other.creditosSuspensos == creditosSuspensos &&
        other.creditosEmAndamento == creditosEmAndamento &&
        other.velocidadeMedia == velocidadeMedia &&
        other.taxaDeSucesso == taxaDeSucesso &&
        other.pracAtualizado == pracAtualizado &&
        other.pracAtualizadoEm == pracAtualizadoEm &&
        other.pracCor == pracCor &&
        other.pracQuilombola == pracQuilombola &&
        other.pracIndigenaAldeado == pracIndigenaAldeado &&
        other.pracRendaPerCapitaAte == pracRendaPerCapitaAte &&
        other.pracDeficiente == pracDeficiente &&
        listEquals(other.pracDeficiencias, pracDeficiencias) &&
        other.pracDeslocouMudou == pracDeslocouMudou &&
        other.ufpb == ufpb;
  }

  //hashCode
  @override
  int get hashCode {
    return codigoDoCurso.hashCode ^
        genero.hashCode ^
        idade.hashCode ^
        situacao.hashCode ^
        motivoDeEvasao.hashCode ^
        periodoDeEvasao.hashCode ^
        formaDeIngresso.hashCode ^
        periodoDeIngresso.hashCode ^
        naturalidade.hashCode ^
        cor.hashCode ^
        deficiencias.hashCode ^
        tipoDeEnsinoMedio.hashCode ^
        politicaAfirmativa.hashCode ^
        matriculaDoEstudante.hashCode ^
        nome.hashCode ^
        nomeDoCurso.hashCode ^
        turnoDoCurso.hashCode ^
        codigoDoCurriculo.hashCode ^
        campus.hashCode ^
        nomeDoCampus.hashCode ^
        codigoDoSetor.hashCode ^
        nomeDoSetor.hashCode ^
        estadoCivil.hashCode ^
        endereco.hashCode ^
        dataDeNascimento.hashCode ^
        cpf.hashCode ^
        cep.hashCode ^
        telefone.hashCode ^
        email.hashCode ^
        nacionalidade.hashCode ^
        localDeNascimento.hashCode ^
        anoDeConclusaoEnsinoMedio.hashCode ^
        creditosDoCra.hashCode ^
        notasAcumuladas.hashCode ^
        periodosCompletados.hashCode ^
        creditosTentados.hashCode ^
        creditosCompletados.hashCode ^
        creditosIsentos.hashCode ^
        creditosFalhados.hashCode ^
        creditosSuspensos.hashCode ^
        creditosEmAndamento.hashCode ^
        velocidadeMedia.hashCode ^
        taxaDeSucesso.hashCode ^
        pracAtualizado.hashCode ^
        pracAtualizadoEm.hashCode ^
        pracCor.hashCode ^
        pracQuilombola.hashCode ^
        pracIndigenaAldeado.hashCode ^
        pracRendaPerCapitaAte.hashCode ^
        pracDeficiente.hashCode ^
        pracDeficiencias.hashCode ^
        pracDeslocouMudou.hashCode ^
        ufpb.hashCode;
  }

  @override
  String toString() {
    return 'Student(codigoDoCurso: $codigoDoCurso, genero: $genero, idade: $idade, situacao: $situacao, motivoDeEvasao: $motivoDeEvasao, periodoDeEvasao: $periodoDeEvasao, formaDeIngresso: $formaDeIngresso, periodoDeIngresso: $periodoDeIngresso, naturalidade: $naturalidade, cor: $cor, deficiencias: $deficiencias, tipoDeEnsinoMedio: $tipoDeEnsinoMedio, politicaAfirmativa: $politicaAfirmativa, matriculaDoEstudante: $matriculaDoEstudante, nome: $nome, nomeDoCurso: $nomeDoCurso, turnoDoCurso: $turnoDoCurso, codigoDoCurriculo: $codigoDoCurriculo, campus: $campus, nomeDoCampus: $nomeDoCampus, codigoDoSetor: $codigoDoSetor, nomeDoSetor: $nomeDoSetor, estadoCivil: $estadoCivil, endereco: $endereco, dataDeNascimento: $dataDeNascimento, cpf: $cpf, cep: $cep, telefone: $telefone, email: $email, nacionalidade: $nacionalidade, localDeNascimento: $localDeNascimento, anoDeConclusaoEnsinoMedio: $anoDeConclusaoEnsinoMedio, creditosDoCra: $creditosDoCra, notasAcumuladas: $notasAcumuladas, periodosCompletados: $periodosCompletados, creditosTentados: $creditosTentados, creditosCompletados: $creditosCompletados, creditosIsentos: $creditosIsentos, creditosFalhados: $creditosFalhados, creditosSuspensos: $creditosSuspensos, creditosEmAndamento: $creditosEmAndamento, velocidadeMedia: $velocidadeMedia, taxaDeSucesso: $taxaDeSucesso, pracAtualizado: $pracAtualizado, pracAtualizadoEm: $pracAtualizadoEm, pracCor: $pracCor, pracQuilombola: $pracQuilombola, pracIndigenaAldeado: $pracIndigenaAldeado, pracRendaPerCapitaAte: $pracRendaPerCapitaAte, pracDeficiente: $pracDeficiente, pracDeficiencias: $pracDeficiencias, pracDeslocouMudou: $pracDeslocouMudou, ufpb: $ufpb)';
  }
}
