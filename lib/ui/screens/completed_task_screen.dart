import 'package:flutter/material.dart';

import '../../data/model/task_list_model.dart';
import '../../data/network_caller/network_caller.dart';
import '../../data/network_caller/network_response.dart';
import '../../data/utility/urls.dart';
import '../widgets/profile_summery_card.dart';
import '../widgets/task_item_card.dart';

class CompletedTaskScreen extends StatefulWidget {
  const CompletedTaskScreen({super.key});

  @override
  State<CompletedTaskScreen> createState() => _CompletedTaskScreenState();
}

class _CompletedTaskScreenState extends State<CompletedTaskScreen> {
  bool getCompletedTaskInProgress = false;
  TaskListModel taskListModel = TaskListModel();

  Future<void> getCompletedTaskList() async {
    getCompletedTaskInProgress = true;
    if (mounted) {
      setState(() {});
      final NetworkResponse response =
          await NetWorkCaller().getRequest(Urls.getCompletedTask);
      if (response.isSuccess) {
        taskListModel = TaskListModel.fromJson(response.jsonResponse);
      }
      getCompletedTaskInProgress = false;
      if (mounted) {
        setState(() {});
      }
    }
  }

  void initState() {
    super.initState();
    getCompletedTaskList();
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
                  visible: getCompletedTaskInProgress == false,
                  replacement: Center(
                    child: const CircularProgressIndicator(),
                  ),
                  child: RefreshIndicator(
                    onRefresh: getCompletedTaskList,
                    child: ListView.builder(
                        itemCount: taskListModel.taskList?.length ?? 0,
                        itemBuilder: (context, index) {
                          return TaskItemCard(
                            task: taskListModel.taskList![index],
                            onStatusChange: (){
                              getCompletedTaskList();

                            },
                            showProgress: (inProgress){
                              getCompletedTaskInProgress = inProgress;
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
