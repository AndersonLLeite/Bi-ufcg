import 'package:bi_ufcg/domain/models/course.dart';
import 'package:bi_ufcg/domain/models/filter_data.dart';
import 'package:bi_ufcg/domain/models/student.dart';
import 'package:bi_ufcg/domain/repositories/data/data_repository.dart';
import '../../../core/rest/dio_custom.dart';

class DataRepositoryImpl implements DataRepository {
  final CustomDio dio;

  DataRepositoryImpl({required this.dio});

  @override
  Future<FilterData> getFilterData() async {
    try {
      // Fazendo a requisição GET para a URL
      final response = await dio.dio.get('/filter_data');

      // Convertendo a resposta em um objeto FilterData
      final filterData = FilterData.fromMap(response.data);
      return filterData;
    } catch (e) {
      print(e);
      throw Exception('Erro ao buscar dados de filtro');
    }
  }

  @override
  Future<List<Course>> getCourses() async {
    try {
      // Fazendo a requisição GET para a URL com o parâmetro de status
      final response = await dio.dio.get(
        '/cursos',
        queryParameters: {'status-enum': 'ATIVOS'},
      );

      // Convertendo a resposta em uma lista de objetos Course
      final courses =
          (response.data as List).map((e) => Course.fromMap(e)).toList();

      return courses;
    } catch (e) {
      print(e);
      throw Exception('Erro ao buscar cursos');
    }
  }

  @override
  Future<List<Student>> getStudentsByCourse(int courseCode) async {
    try {
      // Faz a requisição GET com o código do curso como parâmetro de consulta
      final response = await dio.dio.get(
        '/estudantes',
        queryParameters: {
          'curso': courseCode,
        },
      );

      // Verifica se os dados foram retornados corretamente
      final data = response.data;
      if (data != null && data is List) {
        // Converte a lista de estudantes
        final students = data.map((e) => Student.fromMap(e)).toList();
        return students;
      } else {
        throw Exception('Resposta da API não contém dados esperados');
      }
    } catch (e) {
      print(e);
      throw Exception('Erro ao buscar estudantes: $e');
    }
  }

  // @override
  // getStudentsDropouts(String courseCode) async {
  //   bool anonymize = true;
  //   String curriculumCode = 'All';
  //   String from = '0000.0';
  //   String to = '9999.9';
  //   try {
  //     final response = await dio.auth().dio.get(
  //       '/das-scao/das/students/getDropouts',
  //       queryParameters: {
  //         'courseCode': courseCode,
  //         'curriculumCode': curriculumCode,
  //         'from': from,
  //         'to': to,
  //         'anonymize': anonymize.toString(),
  //       },
  //     );

  //     final data = response.data;
  //     if (data != null && data['students'] != null) {
  //       final studentsList = data['students'] as List;
  //       final students = studentsList.map((e) => Student.fromMap(e)).toList();
  //       return students;
  //     } else {
  //       throw Exception('Resposta da API não contém a chave "students"');
  //     }
  //   } catch (e) {
  //     throw Exception('Erro ao buscar estudantes: $e');
  //   }
  // }
}
