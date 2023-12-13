import 'package:get/get.dart';
import 'package:ostad_task_manager/data/network_caller/network_caller.dart';
import 'package:ostad_task_manager/data/network_caller/network_response.dart';
import 'package:ostad_task_manager/data/utility/urls.dart';

class ResetPasswordController extends GetxController{

  bool _resetPasswordInProgress = false;
  String _snackMessage="";


  bool get resetPasswordInProgress => _resetPasswordInProgress;
  String get snackMessage =>_snackMessage;


  Future<bool> resetPassword(String email,String otp,String password) async {
    bool isSuccess =false;
    _resetPasswordInProgress = true;

    update();

    final NetworkResponse response = await NetWorkCaller().postRequest(Urls.resetPassword, body:{
      "email":email,
      "OTP": otp,
      "password": password,
    });
    _resetPasswordInProgress = false;

    if (response.isSuccess) {
     _snackMessage='Password reset Successful';
     isSuccess= true;
    } else {
      _snackMessage = 'Password reset failed';
    }
    update();
    return isSuccess;
  }
}