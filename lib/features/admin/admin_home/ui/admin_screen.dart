import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sahl_school_app/core/di/dependency_injection.dart';
import 'package:sahl_school_app/core/theming/color/light_colors.dart';
import 'package:sahl_school_app/features/admin/admin_home/data/models/exam.dart';
import 'package:sahl_school_app/features/admin/admin_home/logic/admin_cubit.dart';
import 'package:sahl_school_app/features/admin/admin_home/logic/admin_state.dart';
import 'package:sahl_school_app/features/admin/admin_home/ui/widgets/add_exam_fab.dart';
import 'package:sahl_school_app/features/admin/exam_details/ui/exam_details_screen.dart';

class AdminScreen extends StatelessWidget {
  const AdminScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<AdminCubit>()..getExams(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Welcome Admin'),
          automaticallyImplyLeading: false,
        ),
        body: BlocConsumer<AdminCubit, AdminState>(
          listener:  (context, state) {

          },
          builder: (context, state) {
            if (state is AdminLoading) {
              // Show loading state
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is AdminLoaded) {
              // Use the state to get the list of exams
              List<Exam> exams = state.exams;

              return SingleChildScrollView(
                child: ListView.separated(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemBuilder: (context, index) => Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ExamDetailsScreen(
                                exam: exams[index]
                            ),
                          ),
                        );

                      },
                      child: ListTile(
                        title: Text(exams[index].title),
                        subtitle: Text(
                            'Number of questions: ${exams[index].questions.length}'),
                        trailing: Icon(
                          Icons.edit_note,
                          color: LightColors.primaryColor,
                          size: 36,
                        ),
                        contentPadding: EdgeInsets.symmetric(horizontal: 8),
                        shape: RoundedRectangleBorder(
                          side: BorderSide(color: LightColors.primaryColor),
                          borderRadius: BorderRadius.all(Radius.circular(8)),
                        ),
                      ),
                    ),
                  ),
                  separatorBuilder: (context, index) => SizedBox(
                    height: 5,
                  ),
                  itemCount: exams.length,
                ),
              );
            } else if (state is AdminError) {
              // Show error state
              return Center(
                child: Text('Error: ${state.errorMessage}'),
              );
            } else {
              return Center(
                child: Text('Unexpected state'),
              );
            }
          },
        ),
        floatingActionButton: const AddExamFAB(),
      ),
    );
  }
}


