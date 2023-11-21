import 'package:flutter/material.dart';
import 'package:ostad_task_manager/ui/screens/edit_porfile_screen.dart';

class ProfileSummeryCard extends StatelessWidget {
  const ProfileSummeryCard({
    super.key,
    this.enableOnTap = true,
  });

  final bool enableOnTap;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {
        if (enableOnTap == true) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const EditProfileScreen(),
            ),
          );
        }
      },
      leading: CircleAvatar(
        child: Icon(Icons.person),
      ),
      title: Text(
        'Rabbil Hasan',
        style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700),
      ),
      subtitle: Text(
        'rabbil@gmail.com',
        style: TextStyle(color: Colors.white),
      ),
      trailing: enableOnTap?Icon(Icons.arrow_forward):null,
      tileColor: Colors.green,
    );
  }
}
