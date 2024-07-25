import 'package:bi_ufcg/models/course.dart';

abstract class DataRepository {
  Future<List<Course>> getCourses();

  getStudentsByCourse(String courseId);
}
