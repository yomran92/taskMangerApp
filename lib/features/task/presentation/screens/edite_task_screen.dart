import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:todoapp/core/string_lbl.dart';
import 'package:todoapp/core/utils/helper_function.dart';
import 'package:todoapp/service_locator.dart';

import '../../../../core/styles.dart';
import '../../../../core/utils/common_sizes.dart';
import '../../../../core/widget/custom_button.dart';
import '../../../../core/widget/custom_text.dart';
import '../../../../core/widget/error_widget.dart';
import '../../data/models/param/update_task_param.dart';
import '../../domain/entities/get_task_entity.dart';
import '../bloc/task_bloc.dart';

class EditeTaskScreen extends StatefulWidget {
  const EditeTaskScreen({required this.task, Key? key}) : super(key: key);
  final GetTaskEntity? task;

  @override
  _EditeTaskScreenState createState() => _EditeTaskScreenState();
}

class _EditeTaskScreenState extends State<EditeTaskScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  bool isCompleted = false;

  @override
  void dispose() {
    isCompleted = widget.task!.completed ?? false;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    // var changeNotifier = Provider.of<TodoChangeNotifier>(context);
    return Container(
        width: screenSize.width,
        height: screenSize.height,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            CommonSizes.vBigSpace,
            _buildTastStatus(),
            CommonSizes.vSmallSpace,
            _buildContent(),
            CommonSizes.vSmallSpace,
            _buildBtnAdd()
          ],
        ));
  }

  _buildContent() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
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
            text: widget.task!.todo!,
            style: TextStyle(
              fontWeight: FontWeight.normal,
            ),
          ))
        ],
      ),
    );
  }

  _buildBtnAdd() {
    return BlocConsumer<TaskBloc, TaskState>(
        bloc: sl<TaskBloc>(),
        listener: (context, TaskState state) {
          if (state is UpdateTaskState) {
            Navigator.pop<bool>(context, true);
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
                sl<TaskBloc>().add(UpdateTaskEvent(UpdateTaskParams(
                    body: UpdateTaskParamsBody(
                  taskId: widget.task!.id ?? 0,
                  completed: isCompleted,
                ))));
              },
              message: state.message,
              height: 250.h,
              width: 250.w,
            );
          return Center(
            child: CustomButton(
                text: StringLbl.save,
                style: Styles.w600TextStyle()
                    .copyWith(fontSize: 14.sp, color: Styles.colorTextWhite),
                raduis: 14.r,
                textAlign: TextAlign.center,
                color: isCompleted == widget.task!.completed
                    ? Styles.colorPrimary.withOpacity(0.5)
                    : Styles.colorPrimary,
                fillColor: isCompleted == widget.task!.completed
                    ? Styles.colorPrimary.withOpacity(0.8)
                    : Styles.colorPrimary,
                // width: 350.w,
                height: 52.h,
                alignmentDirectional: AlignmentDirectional.center,
                onPressed: isCompleted == widget.task!.completed
                    ? () {}
                    : () async {
                        FocusManager.instance.primaryFocus?.unfocus();

                        HelperFunction.showToast("all validated");

                        sl<TaskBloc>().add(UpdateTaskEvent(UpdateTaskParams(
                            body: UpdateTaskParamsBody(
                          taskId: widget.task!.id ?? 0,
                          completed: isCompleted,
                        ))));
                      }),
          );
        });
  }

  _buildTastStatus() {
    return Container(
        height: 56.h,
        padding: EdgeInsetsDirectional.only(
            start: CommonSizes.TINY_LAYOUT_W_GAP,
            end: CommonSizes.TINY_LAYOUT_W_GAP,
            top: 0,
            bottom: 0),
        child: Row(
          children: [
            Expanded(
                child: CustomText(
              text: StringLbl.isCompleted,
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            )),
            Switch(
              activeColor: Styles.colorPrimary,
              onChanged: (value) {
                isCompleted = !isCompleted ?? false;
                setState(() {});
              },
              value: isCompleted ?? false,
            ),
          ],
        ));
  }
}
