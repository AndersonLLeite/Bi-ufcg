import 'package:bi_ufcg/core/ui/styles/colors_app.dart';
import 'package:bi_ufcg/core/ui/styles/text_styles.dart';
import 'package:bi_ufcg/models/course.dart';
import 'package:bi_ufcg/screen/home/presenter/home_presenter.dart';
import 'package:flutter/material.dart';
import '../core/ui/styles/app_padding.dart';

class DrawerScreen extends StatefulWidget {
  final List<Course> courses;
  final List<String> terms;
  final HomePresenter homePresenter;
  final int indexSelected;
  const DrawerScreen(
      {super.key,
      required this.courses,
      required this.homePresenter,
      required this.indexSelected,
      required this.terms});

  @override
  State<DrawerScreen> createState() => _DrawerScreenState();
}

class _DrawerScreenState extends State<DrawerScreen> {
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
                            decoration: widget.homePresenter
                                    .getCourseSelectedIndexes()
                                    .contains(index)
                                ? BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    gradient: LinearGradient(colors: [
                                      // context.colors.red.withOpacity(0.9),
                                      // context.colors.orange.withOpacity(0.9),
                                      context.colors.senary,
                                      context.colors.tertiary,
                                    ]))
                                : null,
                            child: ListTile(
                              title: Text(widget.courses[index].name,
                                  style:
                                      context.textStyles.textDrawerCourseItems),
                              onTap: () {
                                setState(() {
                                  if (widget.homePresenter
                                      .getCourseSelectedIndexes()
                                      .contains(index)) {
                                    widget.homePresenter
                                        .removeCourseSelectIndex(index);
                                    widget.homePresenter.removeCourse(
                                        widget.courses[index].code);
                                  } else {
                                    widget.homePresenter
                                        .addCourseSelectIndex(index);
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
                                style: context.textStyles.textDrawerTermsItems,
                              ),
                              onTap: () {
                                if (widget.homePresenter
                                        .getTermSelectedIndexes()
                                        .length >=
                                    15) {
                                  if (widget.homePresenter
                                      .getTermSelectedIndexes()
                                      .contains(index)) {
                                    widget.homePresenter
                                        .removeTermSelectIndex(index);
                                    widget.homePresenter
                                        .removeTerm(widget.terms[index]);
                                  } else {
                                    widget.homePresenter.showError(
                                        'Você só pode selecionar até 4 períodos');
                                  }
                                } else {
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
