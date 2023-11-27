import 'package:flutter/material.dart';
import 'package:ostad_task_manager/data/model/task_count.dart';
import 'package:ostad_task_manager/data/model/task_count_summery_list_model.dart';
import 'package:ostad_task_manager/data/model/task_list_model.dart';
import 'package:ostad_task_manager/data/network_caller/network_caller.dart';
import 'package:ostad_task_manager/data/network_caller/network_response.dart';
import 'package:ostad_task_manager/ui/screens/add_new_task_screen.dart';
import '../../data/utility/urls.dart';
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

  Future<void> getTaskCountSummeryList() async {
    getTaskCountSummeryInProgress = true;
    if (mounted) {
      setState(() {});
      final NetworkResponse response =
          await NetWorkCaller().getRequest(Urls.getTaskStatusCount);
      if (response.isSuccess) {
        taskCountSummeryListModel =
            TaskCountSummeryListModel.fromJson(response.jsonResponse);
      }
      getTaskCountSummeryInProgress = false;
      if (mounted) {
        setState(() {});
      }
    }
  }

  Future<void> getNewTask() async {
    getNewTaskInProgress = true;
    if (mounted) {
      setState(() {});
      final NetworkResponse response =
          await NetWorkCaller().getRequest(Urls.getNewTask);
      if (response.isSuccess) {
        taskListModel = TaskListModel.fromJson(response.jsonResponse);
      }
      getNewTaskInProgress = false;
      if (mounted) {
        setState(() {});
      }
    }
  }

  @override
  void initState() {
    super.initState();
    getTaskCountSummeryList();
    getNewTask();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const AddNewTaskScreen(),
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
      body: SafeArea(
        child: Column(
          children: [
            const ProfileSummeryCard(),
            Visibility(
              visible: getTaskCountSummeryInProgress == false &&
                  (taskCountSummeryListModel.taskCountList?.isNotEmpty ??
                      false),
              replacement: const LinearProgressIndicator(),
              child: SizedBox(
                height: 120,
                child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount:
                        taskCountSummeryListModel.taskCountList?.length ?? 0,
                    itemBuilder: (context, index) {
                      TaskCount taskcount =
                          taskCountSummeryListModel.taskCountList![index];
                      return FittedBox(
                        child: SummeryCard(
                            count: taskcount.sum.toString(),
                            title: taskcount.sId ?? ''),
                      );
                    }),
              ),
            ),
            Expanded(
              child: Visibility(
                visible: getNewTaskInProgress == false,
                replacement: Center(
                  child: const CircularProgressIndicator(),
                ),
                child: ListView.builder(
                    itemCount: taskListModel.taskList?.length ?? 0,
                    itemBuilder: (context, index) {
                      return TaskItemCard(
                        task: taskListModel.taskList![index],
                      );
                    }),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
