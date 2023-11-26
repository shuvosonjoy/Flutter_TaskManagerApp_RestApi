import 'package:flutter/material.dart';

import '../widgets/profile_summery_card.dart';
import '../widgets/task_item_card.dart';
class CompletedTaskScreen extends StatefulWidget {
  const CompletedTaskScreen({super.key});

  @override
  State<CompletedTaskScreen> createState() => _CompletedTaskScreenState();
}

class _CompletedTaskScreenState extends State<CompletedTaskScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
          child: Column(
            children: [
              const ProfileSummeryCard(),

              Expanded(
                child: ListView.builder(
                    itemCount: 10,
                    itemBuilder: (context, index) {
                     // return  const TaskItemCard();
                    }),
              ),
            ],
          ),
        ));
  }
}
