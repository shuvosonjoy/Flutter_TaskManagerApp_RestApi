import 'package:flutter/material.dart';
import 'package:ostad_task_manager/ui/screens/cancelled_task_screen.dart';
import 'package:ostad_task_manager/ui/screens/completed_task_screen.dart';
import 'package:ostad_task_manager/ui/screens/new_task_screen.dart';
import 'package:ostad_task_manager/ui/screens/progress_task_screen.dart';
class MainBottomNavScreen extends StatefulWidget {
  const MainBottomNavScreen({super.key});

  @override
  State<MainBottomNavScreen> createState() => _MainBottomNavScreenState();
}

class _MainBottomNavScreenState extends State<MainBottomNavScreen> {
  int _selectedIndex=0;
  List<Widget>_screens=[
    NewTaskScreen(),
    ProgressTaskScreen(),
    CompletedTaskScreen(),
    CancelledTaskScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(

        currentIndex: _selectedIndex,
        onTap: (index){
          _selectedIndex=index;

          setState(() {

          });
        },

        selectedItemColor: Colors.green,
        unselectedItemColor: Colors.grey,
        showUnselectedLabels: true,

        items: [
          BottomNavigationBarItem(icon: Icon(Icons.abc),label: 'New'),
          BottomNavigationBarItem(icon: Icon(Icons.change_circle_outlined),label: 'Incompleted'),
          BottomNavigationBarItem(icon: Icon(Icons.done),label: 'Completed'),
          BottomNavigationBarItem(icon: Icon(Icons.close),label: 'Cancelled'),
        ],
      ),
    );
  }
}
