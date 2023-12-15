import 'dart:convert';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:ostad_task_manager/data/model/user_model.dart';
import 'package:ostad_task_manager/data/network_caller/network_caller.dart';
import 'package:ostad_task_manager/data/network_caller/network_response.dart';
import 'package:ostad_task_manager/data/utility/urls.dart';
import 'package:ostad_task_manager/ui/controller/auth_controller.dart';
import 'package:ostad_task_manager/ui/controller/new_task_controller.dart';
import 'task_count_summery.dart';

class EditProfileController extends GetxController {
  String? photoBase64;
  bool _updateProfileInProgress = false;
  String _snackMessage = "";

  String get snackMessage => _snackMessage;

  bool get updateProfileInProgress => _updateProfileInProgress;

  Future<bool> updateProfile(String email, String firstName, String lastName,
      String mobile, String password, XFile? photo) async {
    bool isSuccess=false;
    _updateProfileInProgress = true;
    update();
    Map<String, dynamic> inputsData = {
      "email": email,
      "firstName": firstName,
      "lastName": lastName,
      "mobile": mobile,
    };

    if (password.isNotEmpty) {
      inputsData['password'] = password;
    }
    if (photo != null) {
      List<int> imageBytes = await photo!.readAsBytes();
      photoBase64 = base64Encode(imageBytes);
      inputsData['photo'] = photoBase64;
    }
    final NetworkResponse response =
        await NetWorkCaller().postRequest(Urls.updateProfile, body: inputsData);

    _updateProfileInProgress = false;

    if (response.isSuccess) {
      Get.find<NewTaskController>().getNewTaskList();
      Get.find<TaskCountController>().getTaskCountSummeryList();
      Get.find<AuthController>().updateUserInformation(UserModel(
          email: email,
          firstName: firstName,
          lastName: lastName,
          mobile: mobile,
          photo: photoBase64 ?? Get.find<AuthController>().user?.photo ?? ''));

      _snackMessage = 'Update Profile success';
     isSuccess = true;
    } else {
      _snackMessage = 'Update Profile failed. try again';
    }
    update();
    return isSuccess;
  }
}
