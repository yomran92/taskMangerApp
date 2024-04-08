import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:todoapp/core/state/appstate.dart';
import 'package:todoapp/core/utils/common_sizes.dart';
import 'package:todoapp/core/utils/network_info.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:todoapp/core/widget/empty_state_widget.dart';

import 'package:todoapp/service_locator.dart';

import '../../../../core/styles.dart';
import '../../../../core/utils/helper_function.dart';
import '../../../../core/widget/custom_button_with_icon.dart';
import '../../../../core/widget/custom_text.dart';
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
  _requestTask(){
    sl<TaskBloc>().add(GetAllTaskEvent(pageNumber: _currentSection));

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

          title:  CustomText(
            text:"tasks",style: Styles.w700TextStyle().copyWith(

              fontSize: 20.sp,
              color: Styles.colorTextWhite),),
          actions: [
            ValueListenableBuilder<ConnectivityResult>(
                valueListenable: sl<NetworkInfo>().connectivityNotifier,
                builder: (context, result, widget) {
                  return Container(
                      padding: EdgeInsets.symmetric(horizontal: 16),
                      child: Center(
                          child:  CustomText(
                  text: result != ConnectivityResult.none
                              ? 'online'
                              : 'offline',style:  Styles.w700TextStyle().copyWith(

                              fontSize: 12.sp,
                              color: Styles.colorTextWhite))));
                }),
            CustomButtonWithIcon(
            icon:Icon(Icons.logout,color: Styles.colorTextWhite,),

               onPressed: (){
                 sl<AppStateModel>().logOut() ;
                 Phoenix.rebirth(context);

               },
                )

          ],
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: Styles.colorPrimary,
          child: Icon(Icons.add,color: Styles.colorTextWhite,),
          onPressed: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => InsertTaskScreen())).then((value) =>
            {
              if(value){
 _initTasks(),_requestTask()
          }
            else{

              }}
            );
          },
        ),
        body: Container(
            width: screenSize.width,
            height: screenSize.height,
            child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: BlocConsumer<TaskBloc, TaskState>(
                    bloc: sl<TaskBloc>(),
                    listener: (context, TaskState state) {
                      if (state is GetAllTaskLoadedState) {
                        _refreshController.loadComplete();
                        _refreshController.refreshCompleted();
                        if(state.tasks.isNotEmpty){
                        if(getAllTaskLoadedState==null){

                          getAllTaskLoadedState=state;
                        }
                        else if(_currentSection==1){
                          getAllTaskLoadedState=state;
                        }
                        else if (_currentSection>1){
                          getAllTaskLoadedState!.tasks.addAll(state.tasks);
                          final ids =  getAllTaskLoadedState!.tasks.map((e) => e.id)
                              .toSet();
                          getAllTaskLoadedState!.tasks.retainWhere((x) => ids.remove(x.id));
                          _currentSection--;
                        }}
                        else{
                          _enablePullUp=true;
                        }

                      } else if (state is TaskError) {
                        HelperFunction.showToast(state.message.toString());
                      } else if (state is DeleteTaskState) {

                        getAllTaskLoadedState!.tasks
                            .removeWhere((element) => state.id == element.id);
                        HelperFunction.showToast('Deleted Successfully ');
                        _initTasks();
                        _requestTask();

                      }
                    },
                    builder: (context, state) {
                      if (state is TaskLoading)
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      if (state is TaskError) return Container();
                      return getAllTaskLoadedState == null
                          ? EmptyStateWidget(
                        text: 'no data found add some task',

                      )
                          :

                      Scrollbar(
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
                      child: ListView.separated(


                              itemCount: getAllTaskLoadedState!.tasks.length,
                              itemBuilder: (BuildContext context, index) {
                                return TaskWidget(
                                  task: getAllTaskLoadedState!.tasks[index],
                                );
                              }, separatorBuilder: (BuildContext context, int index) =>
    CommonSizes.vSmallerSpace
                      ,))
                      );
                      return Container();
                    }))));
  }
}
