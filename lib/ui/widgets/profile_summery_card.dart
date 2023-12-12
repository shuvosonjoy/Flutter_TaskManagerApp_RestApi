import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ostad_task_manager/ui/controller/auth_controller.dart';
import 'package:ostad_task_manager/ui/screens/edit_porfile_screen.dart';
import 'package:ostad_task_manager/ui/screens/login_screen.dart';

class ProfileSummeryCard extends StatefulWidget {
  const ProfileSummeryCard({
    super.key,
    this.enableOnTap = true,
  });

  final bool enableOnTap;

  @override
  State<ProfileSummeryCard> createState() => _ProfileSummeryCardState();
}

class _ProfileSummeryCardState extends State<ProfileSummeryCard> {
  @override
  Widget build(BuildContext context) {


    return GetBuilder<AuthController>(

      builder: (authController) {
        Uint8List imageBytes = const Base64Decoder().convert(authController.user?.photo??'');
        return ListTile(
          onTap: () {
            if (widget.enableOnTap == true) {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const EditProfileScreen(),
                ),
              );
            }
          },
          leading: CircleAvatar(
            child: authController.user?.photo == null
                ? const Icon(Icons.person)
                : ClipRRect(
              borderRadius: BorderRadius.circular(30),
              child: Image.memory(
                imageBytes,
                fit: BoxFit.cover,
              ),
              //child:Icon(Icons.abc),
            ),
          ),
          title:  Text(
           fullName(authController),
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700),
          ),
          subtitle:  Text(
            authController.user?.email??'',
            style: TextStyle(color: Colors.white),
          ),
          trailing: IconButton(
            onPressed: ()async{
              await AuthController.clearAuthData();
              if(mounted) {
                setState(() {

                });
                Navigator.pushAndRemoveUntil(context,
                    MaterialPageRoute(builder: (context) => LoginScreen()), (
                        route) => false);
              } },
            icon: Icon(Icons.logout),
          ),
          tileColor: Colors.green,
        );
      }
    );
  }
  String fullName(AuthController authController){
    return  '${authController.user?.firstName??''} ${authController.user?.lastName??''}';
  }
}
