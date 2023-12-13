import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ostad_task_manager/ui/controller/auth_controller.dart';
import 'package:ostad_task_manager/ui/controller/create_task_controller.dart';
import 'package:ostad_task_manager/ui/controller/forgotpassword_controller.dart';
import 'package:ostad_task_manager/ui/controller/login_controller.dart';
import 'package:ostad_task_manager/ui/controller/new_task_controller.dart';
import 'package:ostad_task_manager/ui/controller/signup_controller.dart';
import 'package:ostad_task_manager/ui/controller/task_count_summery.dart';
import 'package:ostad_task_manager/ui/screens/splash_screen.dart';

import 'ui/controller/pinverification_controller.dart';
import 'ui/controller/resetpassword_controller.dart';

class TaskManagerApp extends StatelessWidget {
  const TaskManagerApp({super.key});
  static GlobalKey<NavigatorState>navigationKey=GlobalKey<NavigatorState>();

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      initialBinding: ControllerBinder(),
      navigatorKey: navigationKey,
      home: const SplashScreen(),
      theme: ThemeData(
        inputDecorationTheme: const InputDecorationTheme(
          fillColor: Colors.white,
          filled: true,
          border: OutlineInputBorder(
            borderSide: BorderSide.none,
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide.none,
          ),
        ),
        textTheme: const TextTheme(
          titleLarge: TextStyle(
            fontSize: 32,
            fontWeight: FontWeight.w600,
          ),
        ),
        primaryColor: Colors.green,
        primarySwatch: Colors.green,
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.symmetric(vertical: 12),

          ),

        )
      ),
    );
  }
}


class ControllerBinder extends Bindings{
  @override
  void dependencies() {
    Get.put(AuthController());
    Get.put(LoginController());
    Get.put(NewTaskController());
    Get.put(TaskCountController());
    Get.put(CreateTaskControler());
    Get.put(SignUpController());
    Get.put(ResetPasswordController());
    Get.put(PinVerificationController());
    Get.put(ForgotPasswordController());

  }
}