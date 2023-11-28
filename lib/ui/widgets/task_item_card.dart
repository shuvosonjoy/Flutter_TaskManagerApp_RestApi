import 'package:flutter/material.dart';
import 'package:ostad_task_manager/data/network_caller/network_caller.dart';
import 'package:ostad_task_manager/data/utility/urls.dart';
import '../../data/model/task.dart';

enum TaskStatus { New, Progress, Completed, Cancelled }

class TaskItemCard extends StatefulWidget {
  const TaskItemCard({super.key, required this.task,required this.onStatusChange, required this.showProgress});

  final Task task;
  final VoidCallback onStatusChange;
  final Function(bool) showProgress;

  @override
  State<TaskItemCard> createState() => _TaskItemCardState();
}

class _TaskItemCardState extends State<TaskItemCard> {


  Future<void> updateTaskStatus(String status) async {
    widget.showProgress(true);
    final response = await NetWorkCaller().getRequest(Urls.UpdateTaskStatus(widget.task.sId??'', status));
    if(response.isSuccess){
      widget.onStatusChange();
    }
    widget.showProgress(false);


  }



  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.task.title ?? '',
              style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 18,
              ),
            ),
            Text(widget.task.description ?? ''),
            Text('Date: ${widget.task.createdDate}'),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Chip(
                  label: Text(
                    widget.task.status ?? 'New',
                    style: TextStyle(color: Colors.white),
                  ),
                  backgroundColor: Colors.blue,
                ),
                Wrap(
                  children: [
                    // IconButton(
                    //     onPressed: () {},
                    //     icon: const Icon(Icons.delete_forever_outlined)),
                    IconButton(
                        onPressed: () {
                          showUpdateStatusModal();
                        },
                        icon: const Icon(Icons.edit)),
                  ],
                )
              ],
            ),
          ],
        ),
      ),
    );
  }

  void showUpdateStatusModal() {
    List<ListTile> items = TaskStatus.values
        .map((e) => ListTile(
              title: Text('${e.name}'),
              onTap: () {
                updateTaskStatus(e.name);
                Navigator.pop(context);
              },
            ))
        .toList();
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('Update Status'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: items,
            ),
            actions: [
              ButtonBar(
                children: [
                  TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Text(
                        'Cancel',
                        style: TextStyle(
                          color: Colors.grey,
                        ),
                      )),
                ],
              )
            ],
          );
        });
  }
}
