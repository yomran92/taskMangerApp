import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:todoapp/core/styles.dart';
import 'package:todoapp/core/widget/custom_text.dart';
import 'package:todoapp/features/task/data/models/param/get_task_by_id_param.dart';

import '../../../../core/string_lbl.dart';
import '../../../../core/utils/helper_function.dart';
import '../../../../core/widget/error_widget.dart';
import '../../../../service_locator.dart';
import '../bloc/task_bloc.dart';

class TaskDetailWidget extends StatelessWidget {
  final int? id;

  const TaskDetailWidget({Key? key, this.id}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    sl<TaskBloc>().add(GetTaskByIDEvent(
        params: GetTaskByIDParams(body: GetTaskByIDParamsBody(id: id ?? 0))));
    return BlocConsumer<TaskBloc, TaskState>(
      bloc: sl<TaskBloc>(),
      listener: (context, TaskState state) {
        if (state is GetTaskByIDLoadedState) {
        } else if (state is TaskError) {
          HelperFunction.showToast(state.message);
        }
      },
      builder: (context, state) {
        if (state is TaskLoading)
          return Center(
            child: CircularProgressIndicator(),
          );
         if (state is TaskError)
        return ErrorWidgetScreen(
          callBack: () {
            sl<TaskBloc>().add(GetTaskByIDEvent(
                params: GetTaskByIDParams(
                    body: GetTaskByIDParamsBody(id: id ?? 0))));
          },
          message: state.message,
          height: 250.h,
          width: 250.w,
        );
        if (state is GetTaskByIDLoadedState)
          return Column(
            children: [
              Card(
                child: Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
                  child: Row(
                    children: [
                      CustomText(
                        text: StringLbl.isCompleted,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Expanded(
                          child: CustomText(
                        text: "${state.task!.completed} ",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      )),
                      IconButton(
                          icon: Icon(
                            state.task!.completed ?? false
                                ? Icons.circle
                                : Icons.incomplete_circle,
                            size: 20,
                            color: Styles.colorPrimary,
                          ),
                          onPressed: () {
                            // sl<TaskBloc>().add(DeleteTaskEvent(task!.id ?? ''));
                          }),
                    ],
                  ),
                ),
              ),
              Card(
                child: Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
                  child: Row(
                    children: [
                      CustomText(
                        text: StringLbl.todo,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Expanded(
                          child: CustomText(
                        text: state.task!.todo!,
                        style: TextStyle(
                          fontWeight: FontWeight.normal,
                        ),
                      ))
                    ],
                  ),
                ),
              )
            ],
          );
        return Container();
      },
    );
  }
}
