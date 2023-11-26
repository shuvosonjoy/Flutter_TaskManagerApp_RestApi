import 'package:flutter/material.dart';
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
  TaskListModel taskListModel = TaskListModel();

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
            const SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Padding(
                padding: EdgeInsets.only(left: 16, right: 16),
                child: Row(
                  children: [
                    SummeryCard(
                      count: '92',
                      title: 'New',
                    ),
                    SummeryCard(
                      count: '92',
                      title: 'In Progress',
                    ),
                    SummeryCard(
                      count: '92',
                      title: 'Completed',
                    ),
                    SummeryCard(
                      count: '92',
                      title: 'Cancelled',
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              child: Visibility(
                visible: getNewTaskInProgress==false,
                replacement: Center(
                  child: const CircularProgressIndicator(),
                ),
                child: ListView.builder(
                    itemCount: taskListModel.taskList?.length??0,
                    itemBuilder: (context, index) {
                      return  TaskItemCard(
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
