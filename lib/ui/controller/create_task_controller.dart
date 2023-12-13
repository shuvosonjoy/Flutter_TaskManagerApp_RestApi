
import 'package:get/get.dart';
import 'package:ostad_task_manager/data/network_caller/network_caller.dart';
import 'package:ostad_task_manager/data/network_caller/network_response.dart';
import 'package:ostad_task_manager/data/utility/urls.dart';


class CreateTaskControler extends GetxController {
  bool _createTaskInProgress = false;
  String _creationMessage = "";
  String _failedMessage = "";

  bool get createTaskInProgress => _createTaskInProgress;

  String get creationMessage => _creationMessage;

  String get failedMessage => _failedMessage;

  Future<bool> createTask(String title, String description) async {
    bool isSuccess = false;
    _createTaskInProgress = true;
    update();
    final NetworkResponse response = await NetWorkCaller().postRequest(
        Urls.createNewTask,
        body: {"title": title, "description": description, "status": "New"});
    _createTaskInProgress = false;
    update();
    if (response.isSuccess) {

      title = "";
      description = "";
      _creationMessage = "New Task Created";

      isSuccess = true;

    } else {
      _failedMessage = "Create New Task failed, Please Try again";
    }
    return isSuccess;
  }
}
