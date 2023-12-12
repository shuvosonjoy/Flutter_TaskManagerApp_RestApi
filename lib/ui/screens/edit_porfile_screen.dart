import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:ostad_task_manager/data/model/user_model.dart';
import 'package:ostad_task_manager/data/network_caller/network_caller.dart';
import 'package:ostad_task_manager/data/network_caller/network_response.dart';
import 'package:ostad_task_manager/ui/controller/auth_controller.dart';
import 'package:ostad_task_manager/ui/controller/new_task_controller.dart';
import 'package:ostad_task_manager/ui/widgets/body_background.dart';
import 'package:ostad_task_manager/ui/widgets/profile_summery_card.dart';
import 'package:ostad_task_manager/ui/widgets/snack_message.dart';
import '../../data/utility/urls.dart';
import 'main_bottom_navscreen.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _mobileController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String? photoBase64;
  ProfileSummeryCard profileSummeryCard = ProfileSummeryCard();

  bool updateProfileInProgress = false;
  AuthController authController =Get.find<AuthController>();

  XFile? photo;

  @override
  void initState() {
    super.initState();

    _emailController.text = authController.user?.email ?? '';
    _firstNameController.text = authController.user?.firstName ?? '';
    _lastNameController.text = authController.user?.lastName ?? '';
    _mobileController.text = authController.user?.mobile ?? '';
  //  profileSummeryCard;
  //  updateProfile();
  //   if(mounted){
  //     setState(() {
  //     }
  //    );
  //   }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            const ProfileSummeryCard(
              enableOnTap: false,
            ),
            Expanded(
              child: BodyBackground(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(
                            height: 32,
                          ),
                          Text(
                            'Update Profile',
                            style: Theme.of(context).textTheme.titleLarge,
                          ),
                          const SizedBox(
                            height: 16,
                          ),
                           photoPickerField(),
                          const SizedBox(
                            height: 8,
                          ),
                          TextFormField(
                            controller: _emailController,
                            decoration: const InputDecoration(
                              hintText: 'Email',
                            ),
                            validator: (String? value) {
                              if (value?.trim().isEmpty ?? true) {
                                return 'Eneter an email';
                              }

                              bool emailValid = RegExp(
                                      r'^.+@[a-zA-Z]+\.{1}[a-zA-Z]+(\.{0,1}[a-zA-Z]+)$')
                                  .hasMatch(value!);
                              if (emailValid == false) {
                                return 'Enter valid Email';
                              }

                              return null;
                            },
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          TextFormField(
                            controller: _firstNameController,
                            decoration: const InputDecoration(
                              hintText: 'First Name',
                            ),
                            validator: (String? value) {
                              if (value?.trim().isEmpty ?? true) {
                                return 'Eneter your First Name';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          TextFormField(
                            controller: _lastNameController,
                            decoration: const InputDecoration(
                              hintText: 'Last Name',
                            ),
                            validator: (String? value) {
                              if (value?.trim().isEmpty ?? true) {
                                return 'Eneter your Last Name';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          TextFormField(
                            controller: _mobileController,
                            decoration: const InputDecoration(
                              hintText: 'Mobile',
                            ),
                            validator: (String? value) {
                              if (value?.trim().isEmpty ?? true) {
                                return 'Eneter valid Phone Number';
                              }

                              bool validPhone =
                                  RegExp(r'^01[3-9][0-9]{8}$').hasMatch(value!);

                              /// 11 digit and start with 019,017,018 etc
                              if (validPhone == false) {
                                return 'Enter valid Phone Number';
                              }

                              return null;
                            },
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          TextFormField(
                            controller: _passwordController,
                            decoration: const InputDecoration(
                              hintText: 'Password (Optional)',
                            ),
                            validator: (String? value) {
                              if (value!.length < 6 && value.length > 0) {
                                return 'Enter Password more than 6 letters';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(
                            height: 16,
                          ),
                          SizedBox(
                            width: double.infinity,
                            child: Visibility(
                              visible: updateProfileInProgress == false,
                              replacement:
                                  Center(child: CircularProgressIndicator()),
                              child: ElevatedButton(
                                onPressed: () {
                                  if (_formKey.currentState!.validate()) {
                                    updateProfile();


                                    if(mounted){
                                      setState(() {
                                      //  profileSummeryCard;

                                      });
                                    }
                                  }
                                },
                                child: const Icon(
                                    Icons.arrow_circle_right_outlined),
                              ),
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

  Future<void> updateProfile() async {
    updateProfileInProgress = true;
    if (mounted) {
      setState(() {});
    }
    Map<String, dynamic> inputsData = {
      "email": _emailController.text.trim(),
      "firstName": _firstNameController.text.trim(),
      "lastName": _lastNameController.text.trim(),
      "mobile": _mobileController.text.trim(),
    };

    if (_passwordController.text.isNotEmpty) {
      inputsData['password'] = _passwordController.text;
    }
    if(photo!=null){
      List<int> imageBytes= await photo!.readAsBytes();
      photoBase64 = base64Encode(imageBytes);
      inputsData['photo']= photoBase64;
    }
    final NetworkResponse response =
        await NetWorkCaller().postRequest(Urls.updateProfile, body: inputsData);

    updateProfileInProgress = false;
    if (mounted) {
      setState(() {});
    }

    if (response.isSuccess) {
      Get.find<NewTaskController>().getNewTaskList();
      authController.updateUserInformation(UserModel(
        email: _emailController.text.trim(),
        firstName: _firstNameController.text.trim(),
        lastName: _lastNameController.text.trim(),
        mobile: _mobileController.text.trim(),
        photo: photoBase64??authController.user?.photo??'',

      ));
      if (mounted) {
        showSnackMessage(context, 'Update Profile success');
        Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => const MainBottomNavScreen()), (route) => false);

      }
    } else {
      if (mounted) {
        showSnackMessage(context, 'Update Profile failed. try again',true);
      }
    }
  }


  Container photoPickerField() {

    return Container(
      height: 50,
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(8),),
      child: Row(
        children: [
          Expanded(
            flex: 1,
            child: Container(
              height: 50,
              decoration: const BoxDecoration(
                  color: Colors.grey,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(8),
                    bottomLeft: Radius.circular(8),
                  )),
              alignment: Alignment.center,
              child: const Text(
                'Photo',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: InkWell(
              onTap: () async {
                final XFile? image = await ImagePicker()
                    .pickImage(source: ImageSource.camera, imageQuality: 50);
                if (image != null) {
                  photo = image;
                  if (mounted) {
                    setState(() {});
                  }
                }
              },
              child: Container(
                padding: const EdgeInsets.only(left: 16),
                child: Visibility(
                  visible: photo == null,
                  replacement: Text(photo?.name??''),
                  child: const Text('Select a photo'),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }


}



