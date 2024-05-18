import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:todoapp/core/styles.dart';
import 'package:todoapp/core/widget/custom_text.dart';
import 'package:todoapp/features/task/data/models/param/delete_task_param.dart';

import '../../../../service_locator.dart';
import '../../domain/entities/get_task_entity.dart';
import '../bloc/task_bloc.dart';
import '../screens/task_detail_screen.dart';

class TaskWidget extends StatelessWidget {
  final GetTaskEntity? task;
  final bool allowEdite;

  const TaskWidget({Key? key, this.task, this.allowEdite = true})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (allowEdite)
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (BuildContext context) => TaskDetailScreen(
                        task: task,
                      )));
      },
      child: Card(
        elevation: 3,
        child: Container(
          width: MediaQuery.of(context).size.width,
          child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                      icon: Icon(
                        task!.completed ?? false
                            ? Icons.circle
                            : Icons.incomplete_circle,
                        size: 20,
                        color: Styles.colorPrimary,
                      ),
                      onPressed: () {}),
                  Expanded(
                      child: CustomText(
                    text: task!.todo!,
                    numOfLine: 2,
                    style: TextStyle(fontWeight: FontWeight.bold),
                  )),
                  IconButton(
                      icon: Icon(
                        Icons.delete,
                        size: 20,
                        color: Styles.colorPrimary.withOpacity(0.8),
                      ),
                      onPressed: () {
                        sl<TaskBloc>().add(DeleteTaskEvent(
                            params: DeleteTaskParams(
                                body:
                                    DeleteTaskParamsBody(id: task!.id ?? 0))));
                      })
                ],
              )),
        ),
      ),
    );
  }
}
