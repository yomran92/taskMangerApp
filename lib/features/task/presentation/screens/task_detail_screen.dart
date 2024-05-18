import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:todoapp/features/task/domain/entities/get_task_entity.dart';
import 'package:todoapp/features/task/presentation/components/task_detail_widget.dart';

import '../../../../core/styles.dart';
import 'edite_task_screen.dart';

class TaskDetailScreen extends StatelessWidget {
  final GetTaskEntity? task;

  TaskDetailScreen({Key? key, this.task}) : super(key: key);
  ValueNotifier<bool> isEditable = ValueNotifier(false);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Styles.colorPrimary,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Styles.colorTextWhite),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text("task",
            style: Styles.w700TextStyle()
                .copyWith(fontSize: 20.sp, color: Styles.colorTextWhite)),
        actions: [
          InkWell(
              onTap: () {
                isEditable.value = !isEditable.value;
              },
              child: ValueListenableBuilder<bool>(
                  valueListenable: isEditable,
                  builder: (context, isEditable, widget) {
                    return Container(
                        padding: EdgeInsets.symmetric(horizontal: 12.w),
                        child: Icon(
                          size: 32.r,
                          isEditable ? Icons.preview : Icons.edit,
                          color: Styles.colorTextWhite,
                        ));
                  }))
        ],
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: ValueListenableBuilder<bool>(
                valueListenable: isEditable,
                builder: (context, isEditable, widget) {
                  return !isEditable
                      ? TaskDetailWidget(id: task!.id)
                      : EditeTaskScreen(task: task);
                })),
      ),
    );
  }
}
