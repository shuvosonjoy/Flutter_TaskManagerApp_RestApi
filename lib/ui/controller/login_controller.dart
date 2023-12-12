import 'package:get/get.dart';
import 'package:ostad_task_manager/data/model/user_model.dart';
import 'package:ostad_task_manager/data/network_caller/network_caller.dart';
import 'package:ostad_task_manager/data/network_caller/network_response.dart';
import 'package:ostad_task_manager/data/utility/urls.dart';
import 'package:ostad_task_manager/ui/controller/auth_controller.dart';

class LoginController extends GetxController {
  bool _loginInProgress = false;
  String _failedMessage = "";
  bool get loginInProgress => _loginInProgress;
  String get failureMessage => _failedMessage;


AuthController authController =Get.find<AuthController>();
  Future<bool> login(String email, String password) async {
    _loginInProgress = true;

    update();
    NetworkResponse response = await NetWorkCaller().postRequest(Urls.login,
        body: {
          'email': email,
          'password': password,
        },
        isLogin: true);
    _loginInProgress = false;
    update();
    if (response.isSuccess) {
      await authController.saveUserInformation(response.jsonResponse['token'],
          UserModel.fromJson(response.jsonResponse['data']));
      return true;
    } else {
      if (response.statusCode == 401) {

          _failedMessage ='Wrong Email/Password';

      } else {

         _failedMessage ='Login Failed, Please try again.';

      }
    }
    return false;
  }
}
