import 'package:get/get.dart';
import 'package:ostad_task_manager/data/model/task_count_summery_list_model.dart';
import 'package:ostad_task_manager/data/network_caller/network_caller.dart';
import 'package:ostad_task_manager/data/network_caller/network_response.dart';
import 'package:ostad_task_manager/data/utility/urls.dart';

class TaskCountController extends GetxController {
  bool _getTaskCountSummeryInProgress = false;
  TaskCountSummeryListModel _taskCountSummeryListModel =
      TaskCountSummeryListModel();

  bool get getTaskCountSummeryInProgress => _getTaskCountSummeryInProgress;

  TaskCountSummeryListModel get taskCountSummeryListModel =>
      _taskCountSummeryListModel;

  Future<bool> getTaskCountSummeryList() async {
    _getTaskCountSummeryInProgress = true;
    bool isSuccess = false;
    update();
    final NetworkResponse response =
        await NetWorkCaller().getRequest(Urls.getTaskStatusCount);
    _getTaskCountSummeryInProgress = false;
    if (response.isSuccess) {
      isSuccess = true;
      _taskCountSummeryListModel =
          TaskCountSummeryListModel.fromJson(response.jsonResponse);
    }

    update();
    return isSuccess;
  }
}
