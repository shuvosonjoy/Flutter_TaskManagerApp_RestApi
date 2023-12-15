import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ostad_task_manager/ui/controller/completedtask_controller.dart';
import 'package:ostad_task_manager/ui/widgets/snack_message.dart';
import '../../data/model/task_list_model.dart';
import '../widgets/profile_summery_card.dart';
import '../widgets/task_item_card.dart';

class CompletedTaskScreen extends StatefulWidget {
  const CompletedTaskScreen({super.key});

  @override
  State<CompletedTaskScreen> createState() => _CompletedTaskScreenState();
}

class _CompletedTaskScreenState extends State<CompletedTaskScreen> {
  TaskListModel taskListModel = TaskListModel();
  CompletedTaskController _completedTaskController =
      Get.find<CompletedTaskController>();

  Future<void> getCompletedTaskList() async {
    final response = await _completedTaskController.getCompletedTaskList();

    if (response) {
      print("entered entered");
      showSnackMessage(context, _completedTaskController.snackMessage);
    }
  }

  void initState() {
    super.initState();
    _completedTaskController.getCompletedTaskList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: Column(
        children: [
          const ProfileSummeryCard(),
          Expanded(
            child: GetBuilder<CompletedTaskController>(builder: (controller) {
              return Visibility(
                visible: controller.getTaskInProgress == false,
                replacement: Center(
                  child: const CircularProgressIndicator(),
                ),
                child: RefreshIndicator(
                  onRefresh: getCompletedTaskList,
                  child: ListView.builder(
                      itemCount: controller.taskListModel.taskList?.length ?? 0,
                      itemBuilder: (context, index) {
                        return TaskItemCard(
                          task: controller.taskListModel.taskList![index],
                          onStatusChange: () {
                            controller.getCompletedTaskList();
                          },
                          showProgress: (inProgress) {},
                        );
                      }),
                ),
              );
            }),
          ),
        ],
      ),
    ));
  }
}
