import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:todoapp/core/widget/custom_text.dart';
import '../../../../service_locator.dart';
import '../../domain/entities/get_task_entity.dart';
import '../bloc/task_bloc.dart';
import '../screens/task_detail_screen.dart';

class TaskWidget extends StatelessWidget {
  final GetTaskEntity? task;

  const TaskWidget({Key? key, this.task}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
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
            padding: EdgeInsets.symmetric(horizontal: 16.w,vertical: 12.h),
            child:
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                   Expanded(child:   CustomText(
                      text:
                      task!.title!,
                      numOfLine: 2,
                       style: TextStyle(fontWeight: FontWeight.bold),
                     )),
                    IconButton(
                        icon: Icon(
                          Icons.delete,
                          size: 20,
                          color: Colors.grey,
                        ),
                        onPressed: () {
                          sl<TaskBloc>().add(DeleteTaskEvent(task!.id ?? ''));
                        })
                  ],
                )

          ),
        ),
      ),
    );
  }
}
