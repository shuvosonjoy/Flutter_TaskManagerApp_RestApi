import 'package:flutter/material.dart';

import '../../data/model/task.dart';
class TaskItemCard extends StatelessWidget {
  const TaskItemCard({
    super.key,
    required this.task
  });

  final Task task;
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal:16 ,vertical:6 ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              task.title ?? '',
              style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 18,
              ),
            ),
             Text(task.description??''),
             Text('Date: ${task.createdDate}'),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Chip(
                  label: Text(task.status??'New',style: TextStyle(color: Colors.white),),
                  backgroundColor: Colors.blue,
                ),
                Wrap(
                  children: [
                    IconButton(onPressed: (){}, icon: const Icon(Icons.delete_forever_outlined)),
                    IconButton(onPressed: (){}, icon: const Icon(Icons.edit)),
                  ],
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}