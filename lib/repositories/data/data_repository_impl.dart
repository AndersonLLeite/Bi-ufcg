import 'package:bi_ufcg/models/course.dart';
import 'package:bi_ufcg/repositories/data/data_repository.dart';
import '../../core/rest/dio_custom.dart';
import '../../models/student.dart';

class DataRepositoryImpl implements DataRepository {
  final CustomDio dio;

  DataRepositoryImpl({required this.dio});

  @override
  Future<List<Course>> getCourses() async {
    try {
      final response =
          await dio.auth().dio.get('/das-scao/das/courses/getActives');
      final courses =
          (response.data as List).map((e) => Course.fromMap(e)).toList();
      return courses;
    } catch (e) {
      throw Exception('Erro ao buscar cursos');
    }
  }

  @override
  getStudentsByCourse(String courseCode) async {
    bool anonymize = true;
    String curriculumCode = 'All';
    String from = '0000.0';
    String to = '9999.9';
    try {
      final response = await dio.auth().dio.get(
        '/das-scao/das/students/',
        queryParameters: {
          'courseCode': courseCode,
          'curriculumCode': curriculumCode,
          'from': from,
          'to': to,
          'anonymize': anonymize.toString(),
        },
      );

      final data = response.data;
      if (data != null && data['students'] != null) {
        final studentsList = data['students'] as List;
        final students = studentsList.map((e) => Student.fromMap(e)).toList();
        print(students);
        return students;
      } else {
        throw Exception('Resposta da API não contém a chave "students"');
      }
    } catch (e) {
      print(e);
      throw Exception('Erro ao buscar estudantes: $e');
    }
  }
}
