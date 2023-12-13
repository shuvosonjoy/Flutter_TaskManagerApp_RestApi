import 'package:get/get.dart';
import 'package:ostad_task_manager/data/network_caller/network_caller.dart';
import 'package:ostad_task_manager/data/network_caller/network_response.dart';
import 'package:ostad_task_manager/data/utility/urls.dart';

class ForgotPasswordController extends GetxController {

  bool _forgetPasswordInProgress = false;
  String _snackMessage = "";

  bool get forgetPasswordInProgress => _forgetPasswordInProgress;
  String get snackMessage => _snackMessage;

  Future<bool> forgetPassword(String email) async {

    bool isSuccess = false;

    _forgetPasswordInProgress = true;
    update();

    final NetworkResponse response =
        await NetWorkCaller().getRequest(Urls.recoveryEmailUrl(email));

    _forgetPasswordInProgress = false;
    update();

    if (response.isSuccess) {
      _snackMessage = 'OTP sent to email address';
      isSuccess = true;
    } else {
      _snackMessage = 'OTP sent failed. Try again!';
    }

    return isSuccess;
  }
}
