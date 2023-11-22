import 'package:flutter/material.dart';
import 'package:ostad_task_manager/ui/screens/add_new_task_screen.dart';
import '../widgets/profile_summery_card.dart';
import '../widgets/summery_card.dart';
import '../widgets/task_item_card.dart';

class NewTaskScreen extends StatefulWidget {
  const NewTaskScreen({super.key});

  @override
  State<NewTaskScreen> createState() => _NewTaskScreenState();
}

class _NewTaskScreenState extends State<NewTaskScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const AddNewTaskScreen(),
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
      body: SafeArea(
        child: Column(
          children: [
            const ProfileSummeryCard(),
            const SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Padding(
                padding: EdgeInsets.only(left: 16, right: 16),
                child: Row(
                  children: [
                    SummeryCard(
                      count: '92',
                      title: 'New',
                    ),
                    SummeryCard(
                      count: '92',
                      title: 'In Progress',
                    ),
                    SummeryCard(
                      count: '92',
                      title: 'Completed',
                    ),
                    SummeryCard(
                      count: '92',
                      title: 'Cancelled',
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              child: ListView.builder(
                  itemCount: 10,
                  itemBuilder: (context, index) {
                    return const TaskItemCard();
                  }),
            ),
          ],
        ),
      ),
    );
  }
}
