import 'package:get/get.dart';
import 'package:ostad_task_manager/data/model/task_list_model.dart';
import 'package:ostad_task_manager/data/network_caller/network_caller.dart';
import 'package:ostad_task_manager/data/network_caller/network_response.dart';
import 'package:ostad_task_manager/data/utility/urls.dart';

class ProgressTaskController extends GetxController {
  bool _getProgressTaskInProgress = false;
  TaskListModel _taskListModel = TaskListModel();
  String _snackMessage = "";

  String get snackMessage => _snackMessage;

  bool get getProgressTaskInProgress => _getProgressTaskInProgress;

  TaskListModel get taskListModel => _taskListModel;

  Future<bool> getProgressTaskList() async {
    bool isSuccess = false;
    _getProgressTaskInProgress = true;
    update();

    final NetworkResponse response =
        await NetWorkCaller().getRequest(Urls.getProgressTask);
    if (response.isSuccess) {
      _taskListModel = TaskListModel.fromJson(response.jsonResponse);
      isSuccess = true;
      _snackMessage = 'Progress Screen';
    }
    _getProgressTaskInProgress = false;
    update();
    return isSuccess;
  }
}
