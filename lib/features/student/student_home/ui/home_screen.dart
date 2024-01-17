import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sahl_school_app/core/di/dependency_injection.dart';
import 'package:sahl_school_app/core/theming/color/light_colors.dart';
import 'package:sahl_school_app/features/student/student_home/data/models/exam.dart';
import 'package:sahl_school_app/features/student/student_home/ui/exam_screen.dart';
import 'package:sahl_school_app/features/student/student_home/logic/student_cubit.dart';
import 'package:sahl_school_app/features/student/student_home/logic/student_state.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => StudentCubit(getIt())..getExams(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Welcome Abdalla'),
          automaticallyImplyLeading: false,
        ),
        body: BlocBuilder<StudentCubit, StudentState>(
          builder: (context, state) {
            if (state is StudentLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is StudentError) {
              return Center(child: Text('Error: ${state.error}'));
            } else if (state is StudentExamsLoaded) {
              List<Exam> exams = state.exams;
              return SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text('Choose an exam:', style: Theme.of(context).textTheme.titleLarge),
                    const SizedBox(height: 16),
                    ListView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: exams.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ListTile(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            tileColor: LightColors.primaryColor,
                            textColor: Colors.white,
                            title: Text(exams[index].title),
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => ExamScreen(exams[index]),
                                ),
                              );
                            },
                          ),
                        );
                      },
                    ),
                  ],
                ),
              );
            } else {
              return const Center(child: Text('Unknown state'));
            }
          },
        ),
      ),
    );
  }
}
