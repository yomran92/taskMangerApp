import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:todoapp/core/utils/helper_function.dart';

import 'package:todoapp/service_locator.dart';
import 'package:uuid/uuid.dart';

import '../../../../core/styles.dart';
import '../../../../core/utils/common_sizes.dart';
import '../../../../core/utils/network_info.dart';
import '../../../../core/validators/validators.dart';
import '../../../../core/widget/custom_button.dart';
import '../../../../core/widget/custom_text.dart';
import '../../../../core/widget/custom_text_field.dart';
import '../../data/models/task_model.dart';
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
  final _titleController = TextEditingController();
  final _contentController = TextEditingController();

  FocusNode _titleFocusNode = FocusNode();
  FocusNode _contentFocusNode = FocusNode();

  final GlobalKey<FormFieldState<String>> _titleKey =
  new GlobalKey<FormFieldState<String>>();

  final GlobalKey<FormFieldState<String>> _contentKey =
  new GlobalKey<FormFieldState<String>>();
  TaskBloc _taskBloc=new TaskBloc();
  @override
  void dispose() {
    _titleController.dispose();
    _contentController.dispose();
    _taskBloc.close();
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
        title: Text("Insert Task",style: Styles.w700TextStyle().copyWith(

            fontSize: 20.sp,
            color: Styles.colorTextWhite),),
        actions: [
          ValueListenableBuilder<ConnectivityResult>(
              valueListenable: sl<NetworkInfo>().connectivityNotifier,
              builder: (context, result, widget) {
                return Container(
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    child: Center(
                        child: CustomText(
                            text: result != ConnectivityResult.none
                                ? 'online'
                                : 'offline',style:  Styles.w700TextStyle().copyWith(

                            fontSize: 12.sp,
                            color: Styles.colorTextWhite))));
              })
        ],
      ),
      body: Container(
        width: screenSize.width,
        height: screenSize.height,
        padding: EdgeInsets.symmetric(horizontal: 20.w,vertical: 16.h),

        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            CommonSizes.vSmallSpace,

            _buildTitle(),                              CommonSizes.vSmallSpace,

            _buildContent(),
            CommonSizes.vSmallSpace,
            _buildBtnAdd(),
            ],
        ),
      ),
    );
  }
  _buildBtnAdd() {
    return

      BlocConsumer<TaskBloc, TaskState>(
          bloc:  _taskBloc ,
          listener: (context, TaskState state) {
            if (state is AddNewTaskState) {

              Navigator.pop<bool>(context,true);
            } else if (state is TaskError) {
              HelperFunction.showToast('data stored to hive');

              Navigator.pop<bool>(context,false);
            }
          },
          builder: (context, state) {
            if (state is TaskLoading)
              return Center(
                child: CircularProgressIndicator(),
              );
            if (state is TaskError) return Container();
            return
              Center(
                child: CustomButton(
                  text: "Add",
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


                    if (!Validators.isNotEmptyString(_titleController.text)) {
                      HelperFunction.showToast('not valid title');
                    }
                    if (!Validators.isNotEmptyString(_contentController.text)) {
                      HelperFunction.showToast('not valid content');
                    } else {
                      HelperFunction.showToast("all validated");


                      TaskModel todo = TaskModel(
                        id: Uuid().v1(),
                        title: _titleController.text,
                        content: _contentController.text,
                        synced: sl<NetworkInfo>().connectivityNotifier.value !=
                            ConnectivityResult.none,
                      );
                      FocusManager.instance.primaryFocus?.unfocus();

                      _taskBloc.add(AddNewTaskEvent(todo));
                    }
                  }
                ),
              );});
  }

  _buildTitle() {
    return CustomTextField(
      height: 56.h,
      // width: 217.w,
      justLatinLetters: true,
      textKey: _titleKey,
      controller: _titleController,
      textInputAction: TextInputAction.next,
      keyboardType: TextInputType.text,
      validator: (value) {
        if (Validators.isNotEmptyString(value ?? '')) {
          return null;
        }
        setState(() {});
        return 'not valid title';
      },
      textStyle: Styles.w400TextStyle()
          .copyWith(fontSize: 16.sp, color: Styles.colorTextTextField),
      textAlign: TextAlign.left,
      focusNode: _titleFocusNode,
      hintText: "title",
      minLines: 1,
      onChanged: (String value) {
        if (_titleKey.currentState!.validate()) {}
        setState(() {});
      },
      maxLines: 1,
      onFieldSubmitted: (String value) {},
    );
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
        return 'not valid content';
      },
      textStyle: Styles.w400TextStyle()
          .copyWith(fontSize: 16.sp, color: Styles.colorTextTextField),
      textAlign: TextAlign.left,
      focusNode: _contentFocusNode,
      hintText: "content",
      minLines: 1,
      onChanged: (String value) {
        if (_contentKey.currentState!.validate()) {}
        setState(() {});
      },
      maxLines: 1,
      onFieldSubmitted: (String value) {
        if (_contentKey.currentState!.validate()) {}
      setState(() {});},
    );
  }

}
