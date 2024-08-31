import 'package:bi_ufcg/models/course.dart';
import 'package:bi_ufcg/screen/home/presenter/home_presenter.dart';
import 'package:flutter/material.dart';
import '../resource/app_colors.dart';
import '../resource/app_padding.dart';
import '../charts/responsive_layout.dart';

class DrawerScreen extends StatefulWidget {
  List<Course> courses = [];
  List<String> terms = [];
  HomePresenter homePresenter;
  int indexSelected = 0;
  DrawerScreen(
      {super.key,
      required this.courses,
      required this.homePresenter,
      required this.indexSelected,
      required this.terms});

  @override
  State<DrawerScreen> createState() => _DrawerScreenState();
}

class _DrawerScreenState extends State<DrawerScreen> {
  List<int> courseSelectedIndexes = [];
  List<int> termSelectedIndexes = [];

  @override
  Widget build(BuildContext context) {
    return Drawer(
      elevation: 0,
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(AppPadding.P10),
          child: Column(
            children: [
              ...(widget.indexSelected == 0
                  ? List.generate(
                      widget.courses.length,
                      (index) => Column(
                        children: [
                          Container(
                            decoration: courseSelectedIndexes.contains(index)
                                ? BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    gradient: LinearGradient(colors: [
                                      AppColors.red.withOpacity(0.9),
                                      AppColors.orange.withOpacity(0.9),
                                    ]))
                                : null,
                            child: ListTile(
                              title: Text(
                                widget.courses[index].name,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 15,
                                ),
                              ),
                              onTap: () {
                                setState(() {
                                  if (courseSelectedIndexes.contains(index)) {
                                    courseSelectedIndexes.remove(index);
                                    widget.homePresenter.removeCourse(
                                        widget.courses[index].code);
                                  } else {
                                    courseSelectedIndexes.add(index);
                                    widget.homePresenter.getStudentsByCourse(
                                        widget.courses[index].code);
                                  }
                                });
                              },
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                            ),
                          ),
                          const Divider(
                            color: Colors.white,
                            thickness: 0.1,
                          ),
                        ],
                      ),
                    )
                  : List.generate(
                      widget.terms.length,
                      (index) => Column(
                        children: [
                          Container(
                            decoration: termSelectedIndexes.contains(index)
                                ? BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    gradient: LinearGradient(colors: [
                                      AppColors.red.withOpacity(0.9),
                                      AppColors.orange.withOpacity(0.9),
                                    ]))
                                : null,
                            child: ListTile(
                              title: Text(
                                widget.terms[index],
                                style: const TextStyle(color: Colors.white),
                              ),
                              onTap: () {
                                if (termSelectedIndexes.length >= 4) {
                                  if (termSelectedIndexes.contains(index)) {
                                    termSelectedIndexes.remove(index);
                                    widget.homePresenter
                                        .removeTerm(widget.terms[index]);
                                  } else {
                                    widget.homePresenter.showError(
                                        'Você só pode selecionar até 4 períodos');
                                  }
                                } else {
                                  setState(() {
                                    if (termSelectedIndexes.contains(index)) {
                                      termSelectedIndexes.remove(index);
                                      widget.homePresenter
                                          .removeTerm(widget.terms[index]);
                                    } else {
                                      termSelectedIndexes.add(index);
                                      widget.homePresenter
                                          .attDataByTerm(widget.terms[index]);
                                    }
                                  });
                                }
                              },
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                            ),
                          ),
                          const Divider(
                            color: Colors.white,
                            thickness: 0.1,
                          ),
                        ],
                      ),
                    )),
            ],
          ),
        ),
      ),
    );
  }
}
