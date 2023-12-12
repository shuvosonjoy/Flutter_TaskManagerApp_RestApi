import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ostad_task_manager/data/model/task_count.dart';
import 'package:ostad_task_manager/data/model/task_count_summery_list_model.dart';
import 'package:ostad_task_manager/data/model/task_list_model.dart';
import 'package:ostad_task_manager/ui/controller/new_task_controller.dart';
import 'package:ostad_task_manager/ui/controller/task_count_summery.dart';
import 'package:ostad_task_manager/ui/screens/add_new_task_screen.dart';
import '../widgets/profile_summery_card.dart';
import '../widgets/summery_card.dart';
import '../widgets/task_item_card.dart';

class NewTaskScreen extends StatefulWidget {
  const NewTaskScreen({super.key});

  @override
  State<NewTaskScreen> createState() => _NewTaskScreenState();
}

class _NewTaskScreenState extends State<NewTaskScreen> {
  bool getNewTaskInProgress = false;
  bool getTaskCountSummeryInProgress = false;
  TaskListModel taskListModel = TaskListModel();
  TaskCountSummeryListModel taskCountSummeryListModel =
      TaskCountSummeryListModel();
  ProfileSummeryCard profileSummeryCard = ProfileSummeryCard();

  @override
  void initState() {
    Get.find<NewTaskController>().getNewTaskList();
    Get.find<TaskCountController>().getTaskCountSummeryList();
    super.initState();

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final response = await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const AddNewTaskScreen(),
            ),
          );
          if (response != null && response == true) {
            Get.find<TaskCountController>().getTaskCountSummeryList();
            Get.find<NewTaskController>().getNewTaskList();
          }
        },
        child: const Icon(Icons.add),
      ),
      body: SafeArea(
        child: Column(
          children: [
            ProfileSummeryCard(),
            GetBuilder<TaskCountController>(builder: (taskCountController) {
              return Visibility(
                visible: taskCountController.getTaskCountSummeryInProgress ==
                        false &&
                    (taskCountController.taskCountSummeryListModel.taskCountList
                            ?.isNotEmpty ??
                        false),
                replacement: const LinearProgressIndicator(),
                child: SizedBox(
                  height: 120,
                  child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: taskCountController.taskCountSummeryListModel
                              .taskCountList?.length ??
                          0,
                      itemBuilder: (context, index) {
                        TaskCount taskcount = taskCountController
                            .taskCountSummeryListModel.taskCountList![index];
                        return FittedBox(
                          child: SummeryCard(
                              count: taskcount.sum.toString(),
                              title: taskcount.sId ?? ''),
                        );
                      }),
                ),
              );
            }),
            Expanded(
              child:
                  GetBuilder<NewTaskController>(builder: (newTaskController) {
                return Visibility(
                  visible: newTaskController.getNewTaskInProgress == false,
                  replacement: Center(
                    child: const CircularProgressIndicator(),
                  ),
                  child: RefreshIndicator(
                    onRefresh: () async {
                      newTaskController.getNewTaskList();
                      Get.find<TaskCountController>().getTaskCountSummeryList();
                    },
                    child: ListView.builder(
                        itemCount:
                            newTaskController.taskListModel.taskList?.length ??
                                0,
                        itemBuilder: (context, index) {
                          return TaskItemCard(
                            task: newTaskController
                                .taskListModel.taskList![index],
                            onStatusChange: () {
                              newTaskController.getNewTaskList();
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
      ),
    );
  }
}
