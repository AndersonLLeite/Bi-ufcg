import 'package:bi_ufcg/core/ui/styles/colors_app.dart';
import 'package:bi_ufcg/core/ui/styles/text_styles.dart';
import 'package:bi_ufcg/models/course.dart';
import 'package:bi_ufcg/screens/home/presenter/home_presenter.dart';
import 'package:flutter/material.dart';
import '../core/ui/styles/app_padding.dart';

class DrawerScreen extends StatefulWidget {
  final List<Course> courses;
  final List<String> terms;
  final HomePresenter homePresenter;
  final int indexSelected;
  final bool isRequestingStudentByCourse;

  const DrawerScreen(
      {super.key,
      required this.courses,
      required this.homePresenter,
      required this.indexSelected,
      required this.isRequestingStudentByCourse,
      required this.terms});

  @override
  State<DrawerScreen> createState() => _DrawerScreenState();
}

class _DrawerScreenState extends State<DrawerScreen> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Drawer(
          backgroundColor: context.colors.drawerBackgroundColor,
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
                                decoration: widget.homePresenter
                                        .getCourseSelectedIndexes()
                                        .contains(index)
                                    ? BoxDecoration(
                                        borderRadius: BorderRadius.circular(20),
                                        gradient: LinearGradient(colors: [
                                          context.colors.senary,
                                          context.colors.tertiary,
                                        ]))
                                    : null,
                                child: ListTile(
                                  title: Text(widget.courses[index].descricao,
                                      style: context
                                          .textStyles.textDrawerCourseItems),
                                  onTap: () {
                                    setState(() {
                                      if (widget.homePresenter
                                          .getCourseSelectedIndexes()
                                          .contains(index)) {
                                        widget.homePresenter
                                            .removeCourseSelectIndex(index);
                                        widget.homePresenter.removeCourse(widget
                                            .courses[index].codigoDoCurso);
                                      } else {
                                        widget.homePresenter
                                            .addCourseSelectIndex(index);
                                        widget.homePresenter
                                            .getStudentsByCourse(widget
                                                .courses[index].codigoDoCurso);
                                      }
                                    });
                                  },
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                ),
                              ),
                              Divider(
                                color: context.colors.senary,
                                thickness: 0.2,
                              ),
                            ],
                          ),
                        )
                      : List.generate(
                          widget.terms.length,
                          (index) => Column(
                            children: [
                              Container(
                                decoration: widget.homePresenter
                                        .getTermSelectedIndexes()
                                        .contains(index)
                                    ? BoxDecoration(
                                        borderRadius: BorderRadius.circular(20),
                                        gradient: LinearGradient(colors: [
                                          context.colors.senary,
                                          context.colors.tertiary,
                                        ]))
                                    : null,
                                child: ListTile(
                                  title: Text(
                                    widget.terms[index],
                                    style:
                                        context.textStyles.textDrawerTermsItems,
                                  ),
                                  onTap: () {
                                    setState(() {
                                      if (widget.homePresenter
                                          .getTermSelectedIndexes()
                                          .contains(index)) {
                                        widget.homePresenter
                                            .removeTermSelectIndex(index);
                                        widget.homePresenter
                                            .removeTerm(widget.terms[index]);
                                      } else {
                                        widget.homePresenter
                                            .addTermSelectIndex(index);
                                        widget.homePresenter
                                            .attDataByTerm(widget.terms[index]);
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
                        )),
                ],
              ),
            ),
          ),
        ),
        if (widget.isRequestingStudentByCourse ||
            widget.courses.isEmpty ||
            widget.terms.isEmpty)
          Positioned.fill(
            child: Container(
              color: Colors.black54,
              child: Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const CircularProgressIndicator(),
                    const SizedBox(height: 20),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        'Aguarde, estamos obtendo os dados...',
                        style:
                            context.textStyles.textDrawerCourseItems.copyWith(
                          color: Colors.white,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
      ],
    );
  }
}
