import 'package:flutter/material.dart';
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
      leading: const CircleAvatar(
        child: Icon(Icons.person),
      ),
      title:  Text(
       fullName,
        style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700),
      ),
      subtitle:  Text(
        AuthController.user?.email??'',
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
  String get fullName{
    return  '${AuthController.user?.firstName??''} ${AuthController.user?.lastName??''}';
  }
}
