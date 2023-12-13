import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:ostad_task_manager/ui/controller/auth_controller.dart';
import 'package:ostad_task_manager/ui/screens/login_screen.dart';
import 'package:ostad_task_manager/ui/screens/main_bottom_navscreen.dart';
import 'package:ostad_task_manager/ui/widgets/body_background.dart';


class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  AuthController authController =Get.find<AuthController>();
  @override
  void initState() {
    super.initState();
    goToLogin();
  }

  void goToLogin() async{
 final bool isLoggedIn = await authController.checkAuthState();

    Future.delayed(const Duration(seconds: 2)).then((value) {
      Get.offAll(isLoggedIn ?const MainBottomNavScreen(): const LoginScreen());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body:BodyBackground(
          child:  Center(
            child: Image.asset(
              'assets/images/logo.png',
              height: 300,width: 300,
            ),
          ),
        )
    );
  }
}
