import 'package:flutter/material.dart';
import 'package:ostad_task_manager/data/model/task_list_model.dart';
import '../../data/network_caller/network_caller.dart';
import '../../data/network_caller/network_response.dart';
import '../../data/utility/urls.dart';
import '../widgets/profile_summery_card.dart';
import '../widgets/task_item_card.dart';
class ProgressTaskScreen extends StatefulWidget {
  const ProgressTaskScreen({super.key});

  @override
  State<ProgressTaskScreen> createState() => _ProgressTaskScreenState();
}

class _ProgressTaskScreenState extends State<ProgressTaskScreen> {

bool getProgressTaskInProgress =false;
TaskListModel taskListModel = TaskListModel();

  Future<void> getProgressTaskList() async {
    getProgressTaskInProgress = true;
    if (mounted) {
      setState(() {});
      final NetworkResponse response =
      await NetWorkCaller().getRequest(Urls.getProgressTask);
      if (response.isSuccess) {
        taskListModel = TaskListModel.fromJson(response.jsonResponse);
      }
      getProgressTaskInProgress = false;
      if (mounted) {
        setState(() {});
      }
    }
  }
  @override
  void initState() {

    super.initState();
    getProgressTaskList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
          child: Column(
            children: [
              const ProfileSummeryCard(),

              Expanded(
                child: Visibility(
                  visible: getProgressTaskInProgress == false,
                  replacement: Center(
                    child: const CircularProgressIndicator(),
                  ),
                  child: RefreshIndicator(
                    onRefresh: getProgressTaskList,
                    child: ListView.builder(
                        itemCount: taskListModel.taskList?.length ?? 0,
                        itemBuilder: (context, index) {
                          return TaskItemCard(
                            task: taskListModel.taskList![index],
                            onStatusChange: (){
                              getProgressTaskList();

                            },
                            showProgress: (inProgress){
                              getProgressTaskInProgress = inProgress;
                              if(mounted){
                                setState(() {

                                });
                              }
                            },
                          );
                        }),
                  ),
                ),
              ),
            ],
          ),
        ));
  }
}
