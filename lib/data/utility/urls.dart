import 'package:ostad_task_manager/ui/widgets/task_item_card.dart';

class Urls {
  static const String _baseUrl = 'https://task.teamrabbil.com/api/v1';
  static const String registration = '$_baseUrl/registration';
  static const String login = '$_baseUrl/login';
  static const String createNewTask = '$_baseUrl/createTask';
  static const String getTaskStatusCount = '$_baseUrl/taskStatusCount';
  static  String getNewTask = '$_baseUrl/listTaskByStatus/${TaskStatus.New.name}';
  static  String getProgressTask = '$_baseUrl/listTaskByStatus/${TaskStatus.Progress.name}';
  static  String getCompletedTask = '$_baseUrl/listTaskByStatus/${TaskStatus.Completed.name}';
  static  String getCancelledTask = '$_baseUrl/listTaskByStatus/${TaskStatus.Cancelled.name}';


  static String deleteTaskUrl(String id) =>
      '$_baseUrl/deleteTask/$id';

  static  String UpdateTaskStatus(String taskId, String status) =>
      '$_baseUrl/updateTaskStatus/$taskId/$status';

  static const String updateProfile =
      '$_baseUrl/profileUpdate';

  static String recoveryEmailUrl(String Email) =>  // send OTP to email
      '$_baseUrl/RecoverVerifyEmail/$Email';

  static String verifyOTP(String Email,String OTP) =>
      '$_baseUrl/RecoverVerifyOTP/$Email/$OTP';


  static String resetPassword ='$_baseUrl/RecoverResetPass';




}