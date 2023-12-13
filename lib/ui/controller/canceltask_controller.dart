import 'package:get/get.dart';
import 'package:ostad_task_manager/data/model/task_list_model.dart';
import 'package:ostad_task_manager/data/network_caller/network_caller.dart';
import 'package:ostad_task_manager/data/network_caller/network_response.dart';
import 'package:ostad_task_manager/data/utility/urls.dart';

class CancelTaskController extends GetxController {
  bool _getCancelledTaskInProgress = false;
  TaskListModel _taskListModel = TaskListModel();
  String _snackMessage = "";

  bool get getCancelledTaskInProgress => _getCancelledTaskInProgress;

  TaskListModel get taskListModel => _taskListModel;

  String get snackMessage => _snackMessage;

  Future<bool> getCancelledTaskList() async {
    bool isSuccess = false;
    _getCancelledTaskInProgress = true;
    update();
    final NetworkResponse response =
        await NetWorkCaller().getRequest(Urls.getCancelledTask);
    if (response.isSuccess) {
      _taskListModel = TaskListModel.fromJson(response.jsonResponse);
      _snackMessage='Cancelled Screen';
      isSuccess = true;
    }
    _getCancelledTaskInProgress = false;
    update();
    return isSuccess;
  }
}
