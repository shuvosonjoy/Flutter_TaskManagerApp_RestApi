import 'package:get/get.dart';
import 'package:ostad_task_manager/data/network_caller/network_caller.dart';
import 'package:ostad_task_manager/data/network_caller/network_response.dart';
import 'package:ostad_task_manager/data/utility/urls.dart';

class PinVerificationController extends GetxController {
  bool _otpInProgress = false;
  String _snackMessage = "";

  bool get otpInProgress => _otpInProgress;

  String get snackMessage => _snackMessage;

  Future<bool> verifyOTP(String email, String otp) async {
    bool isSuccess = false;
    _otpInProgress = true;
    update();

    final NetworkResponse response =
        await NetWorkCaller().getRequest(Urls.verifyOTP(email, otp));

    _otpInProgress = false;
    update();

    if (response.isSuccess && response != null) {
      if (response.jsonResponse['status'] == 'success') {
        isSuccess = true;
      }
      else{
        _snackMessage='Invalid OTP';
      }
    } else {
      _snackMessage = 'Otp verification has been failed';
    }
    return isSuccess;
  }
}
