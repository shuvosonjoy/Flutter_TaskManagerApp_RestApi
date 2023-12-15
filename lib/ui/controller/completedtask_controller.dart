import 'package:get/get.dart';
import 'package:ostad_task_manager/data/model/task_list_model.dart';
import 'package:ostad_task_manager/data/network_caller/network_caller.dart';
import 'package:ostad_task_manager/data/network_caller/network_response.dart';
import 'package:ostad_task_manager/data/utility/urls.dart';

class CompletedTaskController extends GetxController {
  bool _getCompletedTaskInProgress = false;
  TaskListModel _taskListModel = TaskListModel();

  bool get getTaskInProgress => _getCompletedTaskInProgress;
  String _snackMessage = "";

  TaskListModel get taskListModel => _taskListModel;

  String get snackMessage => _snackMessage;

  Future<bool> getCompletedTaskList() async {
    bool isSuccess = false;
    _getCompletedTaskInProgress = true;
    update();
    final NetworkResponse response =
        await NetWorkCaller().getRequest(Urls.getCompletedTask);
    if (response.isSuccess) {
      _snackMessage='completed screen';
      _taskListModel = TaskListModel.fromJson(response.jsonResponse);
      isSuccess = true;
      _snackMessage='completed screen';
    }
    _getCompletedTaskInProgress = false;
    update();
    return isSuccess;
  }
}
