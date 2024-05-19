import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:todoapp/core/state/appstate.dart';
import 'package:todoapp/core/string_lbl.dart';
import 'package:todoapp/core/utils/helper_function.dart';
import 'package:todoapp/features/task/data/models/param/add_new_task_param.dart';
import 'package:todoapp/service_locator.dart';

import '../../../../core/styles.dart';
import '../../../../core/utils/common_sizes.dart';
import '../../../../core/utils/network_info.dart';
import '../../../../core/validators/validators.dart';
import '../../../../core/widget/custom_button.dart';
import '../../../../core/widget/custom_text.dart';
import '../../../../core/widget/custom_text_field.dart';
import '../../../../core/widget/error_widget.dart';
import '../bloc/task_bloc.dart';

const String addButtonKey = "ADD BUTTON KEY";
const String titleTextFieldKey = "TITLE TEXT FIELD KEY";
const String contentTextFieldKey = "CONTENT TEXT FIELD KEY";

class InsertTaskScreen extends StatefulWidget {
  const InsertTaskScreen({Key? key}) : super(key: key);

  @override
  _InsertTaskScreenState createState() => _InsertTaskScreenState();
}

class _InsertTaskScreenState extends State<InsertTaskScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    sl<TaskBloc>().add(ResetBlocEvent());
  }

  final _contentController = TextEditingController();

  FocusNode _contentFocusNode = FocusNode();

  final GlobalKey<FormFieldState<String>> _contentKey =
      new GlobalKey<FormFieldState<String>>();
  bool isCompleted = false;

  @override
  void dispose() {
    _contentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Styles.colorPrimary,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Styles.colorTextWhite),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text(
          StringLbl.insertTask,
          style: Styles.w700TextStyle()
              .copyWith(fontSize: 20.sp, color: Styles.colorTextWhite),
        ),
        actions: [
          ValueListenableBuilder<ConnectivityResult>(
              valueListenable: sl<NetworkInfo>().connectivityNotifier,
              builder: (context, result, widget) {
                return Container(
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    child: Center(
                        child: CustomText(
                            text: result != ConnectivityResult.none
                                ? StringLbl.online
                                : StringLbl.offline,
                            style: Styles.w700TextStyle().copyWith(
                                fontSize: 12.sp,
                                color: Styles.colorTextWhite))));
              })
        ],
      ),
      body: Container(
        width: screenSize.width,
        height: screenSize.height,
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            CommonSizes.vSmallSpace,
            _buildTastStatus(),
            CommonSizes.vSmallSpace,
            _buildContent(),
            CommonSizes.vSmallSpace,
            _buildBtnAdd(),
          ],
        ),
      ),
    );
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
              text:StringLbl.isCompleted,
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

  _buildBtnAdd() {
    return BlocConsumer<TaskBloc, TaskState>(
        bloc: sl<TaskBloc>(),
        listener: (context, TaskState state) {
          if (state is AddNewTaskState) {
            Navigator.pop<bool>(context, true);
          } else if (state is TaskError) {
            HelperFunction.showToast(state.message);

            Navigator.pop<bool>(context, false);
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
                if (!Validators.isNotEmptyString(_contentController.text)) {
                  HelperFunction.showToast(
                      '${StringLbl.validationMessage} ${StringLbl.todo} ');
                } else {
                  HelperFunction.showToast("all validated");

                  sl<TaskBloc>().add(AddNewTaskEvent(
                      addTaskParams: AddTaskParams(
                          body: AddTaskParamsBody(
                              todo: _contentController.text,
                              completed: isCompleted,
                              userId: sl<AppStateModel>().user!.id))));
                }
              },
              message: state.message,
              height: 250.h,
              width: 250.w,
            );

          return Center(
            child: CustomButton(
                text: StringLbl.add,
                style: Styles.w600TextStyle()
                    .copyWith(fontSize: 14.sp, color: Styles.colorTextWhite),
                raduis: 14.r,
                textAlign: TextAlign.center,
                color: Styles.colorPrimary,
                fillColor: Styles.colorPrimary,
                // width: 350.w,
                height: 52.h,
                alignmentDirectional: AlignmentDirectional.center,
                onPressed: () async {
                  FocusManager.instance.primaryFocus?.unfocus();
if(!_contentKey.currentState!.validate()){
                  // if (!Validators.isNotEmptyString(_contentController.text)) {
                    HelperFunction.showToast(
                        '${StringLbl.validationMessage} ${StringLbl.todo} ');
                  } else {
                    HelperFunction.showToast("all validated");

                    sl<TaskBloc>().add(AddNewTaskEvent(
                        addTaskParams: AddTaskParams(
                            body: AddTaskParamsBody(
                                todo: _contentController.text,
                                completed: isCompleted,
                                userId: sl<AppStateModel>().user!.id))));
                  }
                }),
          );
        });
  }

  _buildContent() {
    return CustomTextField(
      height: 56.h,
      // width: 217.w,
      justLatinLetters: true,
      textKey: _contentKey,
      controller: _contentController,
      textInputAction: TextInputAction.next,
      keyboardType: TextInputType.text,
      validator: (value) {
        if (Validators.isNotEmptyString(value ?? '')) {
          return null;
        }
        setState(() {});
        return 'not valid todo';
      },
      textStyle: Styles.w400TextStyle()
          .copyWith(fontSize: 16.sp, color: Styles.colorTextTextField),
      textAlign: TextAlign.left,
      focusNode: _contentFocusNode,
      hintText:StringLbl.todo,
      minLines: 1,
      onChanged: (String value) {
        if (_contentKey.currentState!.validate()) {}
        setState(() {});
      },
      maxLines: 1,
      onFieldSubmitted: (String value) {
        if (_contentKey.currentState!.validate()) {}
        setState(() {});
      },
    );
  }
}
