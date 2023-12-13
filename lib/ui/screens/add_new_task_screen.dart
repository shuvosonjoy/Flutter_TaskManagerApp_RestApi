import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ostad_task_manager/ui/controller/create_task_controller.dart';
import 'package:ostad_task_manager/ui/controller/new_task_controller.dart';
import 'package:ostad_task_manager/ui/controller/task_count_summery.dart';
import 'package:ostad_task_manager/ui/widgets/body_background.dart';
import 'package:ostad_task_manager/ui/widgets/snack_message.dart';
import '../widgets/profile_summery_card.dart';
import 'main_bottom_navscreen.dart';

class AddNewTaskScreen extends StatefulWidget {
  const AddNewTaskScreen({super.key});

  @override
  State<AddNewTaskScreen> createState() => _AddNewTaskScreenState();
}

class _AddNewTaskScreenState extends State<AddNewTaskScreen> {
  TextEditingController _subjectTEController = TextEditingController();
  TextEditingController _descriptionTEController = TextEditingController();
  GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  CreateTaskControler _createTaskControler = Get.find<CreateTaskControler>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            const ProfileSummeryCard(),
            Expanded(
              child: BodyBackground(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Form(
                      key: _formkey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(
                            height: 32,
                          ),
                          Text(
                            'Add New Task',
                            style: Theme.of(context).textTheme.titleLarge,
                          ),
                          const SizedBox(
                            height: 16,
                          ),
                          TextFormField(
                            controller: _subjectTEController,
                            decoration: const InputDecoration(
                              hintText: 'Subject',
                            ),
                            validator: (String? value) {
                              if (value?.trim().isEmpty ?? true) {
                                return 'Please enter your subject';
                              } else
                                return null;
                            },
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          TextFormField(
                              controller: _descriptionTEController,
                              maxLines: 8,
                              decoration: const InputDecoration(
                                hintText: 'Description',
                              ),
                              validator: (String? value) {
                                if (value?.trim().isEmpty ?? true) {
                                  return 'Please enter  Description';
                                } else
                                  return null;
                              }),
                          const SizedBox(
                            height: 8,
                          ),
                          SizedBox(
                            width: double.infinity,
                            child: GetBuilder<CreateTaskControler>(
                              builder: (createTaskController) {
                                return Visibility(
                                  visible: createTaskController.createTaskInProgress==false,
                                  replacement: Center(
                                    child: CircularProgressIndicator(),
                                  ),
                                  child: ElevatedButton(
                                    onPressed: createTask,
                                    child:
                                        const Icon(Icons.arrow_circle_right_outlined),
                                  ),
                                );
                              }
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> createTask() async{

        if(!_formkey.currentState!.validate()){
          return;
        }

          final response = await _createTaskControler.createTask(_subjectTEController.text.trim(), _descriptionTEController.text.trim());


          if(response){
            Get.offAll(const MainBottomNavScreen());
            Get.find<NewTaskController>().getNewTaskList();
            Get.find<TaskCountController>().getTaskCountSummeryList();
            _subjectTEController.clear();
            _descriptionTEController.clear();
            showSnackMessage(context, _createTaskControler.creationMessage);

          }else{
            if(mounted){
              showSnackMessage(context, _createTaskControler.failedMessage,true);
            }
          }


  }

  @override
  void dispose() {

    _subjectTEController.dispose();
    _descriptionTEController.dispose();


    super.dispose();
  }
}
