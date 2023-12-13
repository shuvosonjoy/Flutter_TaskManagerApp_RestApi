import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ostad_task_manager/ui/controller/canceltask_controller.dart';
import 'package:ostad_task_manager/ui/widgets/snack_message.dart';
import '../../data/model/task_list_model.dart';
import '../widgets/profile_summery_card.dart';
import '../widgets/task_item_card.dart';

class CancelledTaskScreen extends StatefulWidget {
  const CancelledTaskScreen({super.key});

  @override
  State<CancelledTaskScreen> createState() => _CancelledTaskScreenState();
}

class _CancelledTaskScreenState extends State<CancelledTaskScreen> {
  CancelTaskController _cancelTaskController = Get.find<CancelTaskController>();

  TaskListModel taskListModel = TaskListModel();

  Future<void> getCancelledTaskList() async {


     if(mounted) {
       final response = await _cancelTaskController.getCancelledTaskList();
       if (response) {
         showSnackMessage(context, _cancelTaskController.snackMessage);


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
            child: GetBuilder<CancelTaskController>(
              builder: (controller) {
                return Visibility(
                  visible: _cancelTaskController.getCancelledTaskInProgress == false,
                  replacement: Center(
                    child: const CircularProgressIndicator(),
                  ),
                  child: RefreshIndicator(
                    onRefresh: getCancelledTaskList,
                    child: ListView.builder(
                        itemCount: _cancelTaskController.taskListModel.taskList?.length ?? 0,
                        itemBuilder: (context, index) {
                          return TaskItemCard(
                            task: _cancelTaskController.taskListModel.taskList![index],
                            onStatusChange: () {
                              _cancelTaskController.getCancelledTaskList();
                            },
                            showProgress: (inProgress) {

                            },
                          );
                        }),
                  ),
                );
              }
            ),
          ),
        ],
      ),
    ));
  }
}
