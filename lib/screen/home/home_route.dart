import 'package:bi_ufcg/repositories/data/data_repository.dart';
import 'package:bi_ufcg/repositories/data/data_repository_impl.dart';
import 'package:bi_ufcg/screen/home/presenter/home_presenter_impl.dart';
import 'package:bi_ufcg/service/course_data_service/course_data_service.dart';
import 'package:bi_ufcg/service/course_data_service/course_data_service_impl.dart';
import 'package:bi_ufcg/service/data/data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_getit/flutter_getit.dart';
import 'home_page.dart';

import 'presenter/home_presenter.dart';

class HomeRoute extends FlutterGetItPageRoute {
  const HomeRoute({super.key});

  @override
  List<Bind<Object>> get bindings => [
        Bind.lazySingleton<CourseDataService>((i) => CourseDataServiceImpl()),
        Bind.lazySingleton<DataRepository>((i) => DataRepositoryImpl(dio: i())),
        Bind.lazySingleton<HomePresenter>((i) =>
            HomePresenterImpl(dataRepository: i(), courseDataService: i())),
      ];

  @override
  WidgetBuilder get page => (context) => HomePage(
        presenter: context.get(),
      );
}
