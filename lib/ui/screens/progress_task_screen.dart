import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ostad_task_manager/data/model/task_list_model.dart';
import 'package:ostad_task_manager/ui/controller/progress_task_controller.dart';
import 'package:ostad_task_manager/ui/widgets/snack_message.dart';
import '../widgets/profile_summery_card.dart';
import '../widgets/task_item_card.dart';
class ProgressTaskScreen extends StatefulWidget {
  const ProgressTaskScreen({super.key});

  @override
  State<ProgressTaskScreen> createState() => _ProgressTaskScreenState();
}

class _ProgressTaskScreenState extends State<ProgressTaskScreen> {
  ProgressTaskController _progressTaskController = Get.find<ProgressTaskController>();


TaskListModel taskListModel = TaskListModel();

  Future<void> getProgressTaskList() async {

 final response= await _progressTaskController.getProgressTaskList();

      if (response) {
        showSnackMessage(context, _progressTaskController.snackMessage);
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
                child: GetBuilder<ProgressTaskController>(
                  builder: (controller) {
                    return Visibility(
                      visible: controller.getProgressTaskInProgress == false,
                      replacement: Center(
                        child: const CircularProgressIndicator(),
                      ),
                      child: RefreshIndicator(
                        onRefresh: getProgressTaskList,
                        child: ListView.builder(
                            itemCount: controller.taskListModel.taskList?.length ?? 0,
                            itemBuilder: (context, index) {
                              return TaskItemCard(
                                task: controller.taskListModel.taskList![index],
                                onStatusChange: (){
                                  getProgressTaskList();

                                },
                                showProgress: (inProgress){

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
