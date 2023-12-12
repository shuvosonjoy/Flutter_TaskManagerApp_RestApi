import 'package:flutter/material.dart';

import '../../data/model/task_list_model.dart';
import '../../data/network_caller/network_caller.dart';
import '../../data/network_caller/network_response.dart';
import '../../data/utility/urls.dart';
import '../widgets/profile_summery_card.dart';
import '../widgets/task_item_card.dart';

class CancelledTaskScreen extends StatefulWidget {
  const CancelledTaskScreen({super.key});

  @override
  State<CancelledTaskScreen> createState() => _CancelledTaskScreenState();
}

class _CancelledTaskScreenState extends State<CancelledTaskScreen> {
  bool getCancelledTaskInProgress = false;
  TaskListModel taskListModel = TaskListModel();

  Future<void> getCancelledTaskList() async {
    getCancelledTaskInProgress = true;
    if (mounted) {
      setState(() {});
      final NetworkResponse response =
          await NetWorkCaller().getRequest(Urls.getCancelledTask);
      if (response.isSuccess) {
        taskListModel = TaskListModel.fromJson(response.jsonResponse);
      }
      getCancelledTaskInProgress = false;
      if (mounted) {
        setState(() {});
      }
    }
  }

  void initState() {
    super.initState();
    getCancelledTaskList();
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
              visible: getCancelledTaskInProgress == false,
              replacement: Center(
                child: const CircularProgressIndicator(),
              ),
              child: RefreshIndicator(
                onRefresh: getCancelledTaskList,
                child: ListView.builder(
                    itemCount: taskListModel.taskList?.length ?? 0,
                    itemBuilder: (context, index) {
                      return TaskItemCard(
                        task: taskListModel.taskList![index],
                        onStatusChange: () {
                          getCancelledTaskList();
                        },
                        showProgress: (inProgress) {
                          getCancelledTaskInProgress = inProgress;
                          if (mounted) {
                            setState(() {});
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
