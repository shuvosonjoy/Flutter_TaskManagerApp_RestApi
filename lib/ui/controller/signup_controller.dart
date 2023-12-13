import 'package:get/get.dart';
import 'package:ostad_task_manager/data/network_caller/network_caller.dart';
import 'package:ostad_task_manager/data/network_caller/network_response.dart';
import 'package:ostad_task_manager/data/utility/urls.dart';

class SignUpController extends GetxController{
  bool _signUpInProgress = false;
  String _successMessage ="";
  String _failureMessage ="";
  bool get signUpInProgress => _signUpInProgress;
  String get successMessage =>_successMessage;
  String get failureMessage => _failureMessage;


  Future<bool> signUp(String email, String firstname, String lastname,String mobile,String password) async {
    bool isSuccess=false;
      _signUpInProgress = true;
      update();

      final NetworkResponse response =
      await NetWorkCaller().postRequest(Urls.registration, body: {
        "email": email,
        "firstName": firstname,
        "lastName": lastname,
        "mobile": mobile,
        "password":password,
      });
      _signUpInProgress = false;
     update();
      if (response.isSuccess) {

        _successMessage = "Account Created Successfully, Please Login";

        isSuccess =true;
        }
      else{
        _failureMessage ='Account Creation failed, Please try again';
      }
      update();
      return isSuccess;

    }
  }
