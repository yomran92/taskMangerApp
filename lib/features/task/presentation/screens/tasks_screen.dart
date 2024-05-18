import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:todoapp/core/state/appstate.dart';
import 'package:todoapp/core/string_lbl.dart';
import 'package:todoapp/core/utils/common_sizes.dart';
import 'package:todoapp/core/utils/network_info.dart';
import 'package:todoapp/core/widget/empty_state_widget.dart';
import 'package:todoapp/features/task/data/models/param/get_all_task_param.dart';
import 'package:todoapp/features/task/domain/entities/get_all_task_entity.dart';
import 'package:todoapp/features/task/domain/entities/get_task_entity.dart';
import 'package:todoapp/service_locator.dart';

import '../../../../core/constants.dart';
import '../../../../core/styles.dart';
import '../../../../core/utils/helper_function.dart';
import '../../../../core/utils/hive_keys.dart';
import '../../../../core/utils/hive_paramter.dart';
import '../../../../core/widget/custom_button_with_icon.dart';
import '../../../../core/widget/custom_text.dart';
import '../../../../core/widget/error_widget.dart';
import '../../data/models/get_all_task_model.dart';
import '../bloc/task_bloc.dart';
import '../components/task_widget.dart';
import 'insert_task_screen.dart';

const String progressIndicatorKey = "PROGRESS INDICATOR KEY";

class TaskScreen extends StatefulWidget {
  const TaskScreen({Key? key}) : super(key: key);

  @override
  _TaskScreenState createState() => _TaskScreenState();
}

class _TaskScreenState extends State<TaskScreen> {
  GetAllTaskLoadedState? getAllTaskLoadedState;
  bool _enablePullUp = true;
  int _currentSection = 1;
  final _refreshController = RefreshController();
  late GetAllTaskLoadedState currentState;

  @override
  void dispose() {
    super.dispose();
  }

  @override
  void initState() {
    _initTasks();
    _requestTask();

    super.initState();
  }

  _requestTask() async {
    sl<TaskBloc>().add(GetAllTaskEvent(
        params: GetAllTaskParams(
            body: GetAllTaskParamsBody(
                limit: Pagelimit, skip: (_currentSection - 1) * Pagelimit))));
  }

  void _initTasks() {
    _currentSection = 1;
    _enablePullUp = true;
  }

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;

    return Scaffold(
        appBar: AppBar(
          backgroundColor: Styles.colorPrimary,
          automaticallyImplyLeading: false,
          title: CustomText(
            text: "${sl<AppStateModel>().user!.firstName ?? ""} tasks",
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
                }),
            CustomButtonWithIcon(
              icon: Icon(
                Icons.logout,
                color: Styles.colorTextWhite,
              ),
              onPressed: () {
                sl<AppStateModel>().logOut();
                Phoenix.rebirth(context);
              },
            )
          ],
        ),
        floatingActionButton: ValueListenableBuilder<ConnectivityResult>(
            valueListenable: sl<NetworkInfo>().connectivityNotifier,
            builder: (context, result, widget) {
              return Visibility(
                  visible: sl<NetworkInfo>().connectivityNotifier.value !=
                      ConnectivityResult.none,
                  child: FloatingActionButton(
                    backgroundColor: Styles.colorPrimary,
                    child: Icon(
                      Icons.add,
                      color: Styles.colorTextWhite,
                    ),
                    onPressed: () {
                      Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => InsertTaskScreen()))
                          .then((value) => {if (value) {} else {}});
                    },
                  ));
            }),
        body: Container(
            width: screenSize.width,
            height: screenSize.height,
            child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: BlocConsumer<TaskBloc, TaskState>(
                    bloc: sl<TaskBloc>(),
                    listener: (context, TaskState state) async {
                      if (state is GetAllTaskLoadedState) {
                        sl<NetworkInfo>().connectivityNotifier.value =
                            ConnectivityResult.mobile;

                        _refreshController.loadComplete();
                        _refreshController.refreshCompleted();
                        if ((state.total ?? 0) > 0) {
                          if (getAllTaskLoadedState == null) {
                            getAllTaskLoadedState = state;
                          } else if (_currentSection == 1) {
                            getAllTaskLoadedState = state;
                          } else if (_currentSection > 1) {
                            getAllTaskLoadedState!.tasks!
                                .addAll(state.tasks ?? []);
                          }
                        } else {
                          _enablePullUp = true;
                        }
                        if (state.total! <= ((_currentSection) * Pagelimit)) {
                          _enablePullUp = false;
                        }
                      } else if (state is AddNewTaskState) {
                        sl<NetworkInfo>().connectivityNotifier.value =
                            ConnectivityResult.mobile;
                        getAllTaskLoadedState!.tasks!.add(GetTaskEntity(
                            completed: state.task.completed,
                            userId: state.task.userId,
                            id: state.task.id,
                            todo: state.task.todo));
                        getAllTaskLoadedState!.total !=
                            getAllTaskLoadedState!.total! + 1;
                      } else if (state is UpdateTaskState) {
                        sl<NetworkInfo>().connectivityNotifier.value =
                            ConnectivityResult.mobile;
                        int index = -1;
                        index = getAllTaskLoadedState!.tasks!.indexWhere(
                            (element) => element.id == state.taskModel!.id);

                        if (index == -1) {
                          _initTasks();
                          _requestTask();
                        } else {
                          getAllTaskLoadedState!.tasks![index].completed =
                              state.taskModel.completed;
                        }
                      } else if (state is TaskError) {
                        HelperFunction.showToast(state.message.toString());
                        if (state.message
                                .toString()
                                .compareTo(StringLbl.noInternetConnection) ==
                            0) {
                          sl<NetworkInfo>().connectivityNotifier.value =
                              ConnectivityResult.none;
                          final taskBox = await sl<HiveParamter>()
                              .hive
                              .box(HiveKeys.taskBox);
                          GetAllTaskEntity allTaskEntity = (taskBox
                                  .get(HiveKeys.taskListKey) as GetAllTaskModel)
                              .toEntity();
                          getAllTaskLoadedState = GetAllTaskLoadedState(
                              limit: allTaskEntity.limit,
                              total: allTaskEntity.total,
                              skip: allTaskEntity.skip,
                              tasks: allTaskEntity.todos);

                          _currentSection = 1;
                          _enablePullUp = false;
                        }
                      } else if (state is DeleteTaskState) {
                        sl<NetworkInfo>().connectivityNotifier.value =
                            ConnectivityResult.mobile;
                        getAllTaskLoadedState!.tasks!.removeWhere(
                            (element) => state.taskModel.id == element.id);
                        getAllTaskLoadedState!.total !=
                            getAllTaskLoadedState!.total! - 1;
                        HelperFunction.showToast('Deleted Successfully ');
                      }
                    },
                    builder: (context, state) {
                      if (state is TaskLoading && _currentSection == 1)
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      if (state is TaskError && getAllTaskLoadedState == null)
                        return ErrorWidgetScreen(
                          callBack: () {
                            _requestTask();
                          },
                          message: state.message,
                          height: 250.h,
                          width: 250.w,
                        );
                      return Scrollbar(
                          interactive: true,
                          radius: const Radius.circular(10),
                          child: SmartRefresher(
                              controller: _refreshController,
                              enablePullUp: _enablePullUp,
                              onRefresh: () {
                                _initTasks();
                                _requestTask();
                              },
                              onLoading: () {
                                setState(() {
                                  _currentSection++;

                                  _requestTask();
                                });
                              },
                              child: getAllTaskLoadedState == null
                                  ? EmptyStateWidget(
                                      text: 'no data found add some task',
                                    )
                                  : ListView.separated(
                                      itemCount:
                                          getAllTaskLoadedState!.tasks!.length,
                                      itemBuilder:
                                          (BuildContext context, index) {
                                        return TaskWidget(
                                          allowEdite: sl<NetworkInfo>()
                                                  .connectivityNotifier
                                                  .value !=
                                              ConnectivityResult.none,
                                          task: getAllTaskLoadedState!
                                              .tasks![index],
                                        );
                                      },
                                      separatorBuilder:
                                          (BuildContext context, int index) =>
                                              CommonSizes.vSmallerSpace,
                                    )));
                      return Container();
                    }))));
  }
}
