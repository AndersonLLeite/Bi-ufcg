import 'package:bi_ufcg/domain/models/course.dart';

abstract class DataRepository {
  Future<List<Course>> getCourses();

  getStudentsByCourse(int courseId);
}
