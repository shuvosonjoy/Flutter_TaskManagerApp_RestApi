import 'package:flutter/material.dart';
import 'package:ostad_task_manager/data/network_caller/network_caller.dart';
import 'package:ostad_task_manager/ui/widgets/body_background.dart';

import 'package:ostad_task_manager/data/network_caller/network_response.dart';
import 'package:ostad_task_manager/ui/widgets/snack_message.dart';

import '../../data/utility/urls.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  TextEditingController _emailController = TextEditingController();
  TextEditingController _firstNameController = TextEditingController();
  TextEditingController _lastNameController = TextEditingController();
  TextEditingController _mobileController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();


  bool _signUpInprogress = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BodyBackground(
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: SingleChildScrollView(
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(
                        height: 99,
                      ),
                      Text(
                        "Join With Us",
                        style: Theme
                            .of(context)
                            .textTheme
                            .titleLarge,
                      ),
                      const SizedBox(
                        height: 24,
                      ),
                      TextFormField(
                        controller: _emailController,
                        keyboardType: TextInputType.emailAddress,
                        decoration: const InputDecoration(
                          hintText: 'Email',
                        ),
                        validator: (String? value) {
                          if (value
                              ?.trim()
                              .isEmpty ?? true) {
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
                        height: 16,
                      ),
                      TextFormField(
                        controller: _firstNameController,
                        decoration: const InputDecoration(
                          hintText: 'First Name',
                        ),
                        validator: (String? value) {
                          if (value
                              ?.trim()
                              .isEmpty ?? true) {
                            return 'Eneter your First Name';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      TextFormField(
                        controller: _lastNameController,
                        decoration: const InputDecoration(
                          hintText: 'Last Name',
                        ),
                        validator: (String? value) {
                          if (value
                              ?.trim()
                              .isEmpty ?? true) {
                            return 'Eneter your Last Name';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      TextFormField(
                        controller: _mobileController,
                        keyboardType: TextInputType.phone,
                        decoration: const InputDecoration(
                          hintText: 'Mobile',
                        ),
                        validator: (String? value) {
                          if (value
                              ?.trim()
                              .isEmpty ?? true) {
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
                        height: 16,
                      ),
                      TextFormField(
                        controller: _passwordController,
                        obscureText: true,
                        decoration: const InputDecoration(
                          hintText: 'Passwords',
                        ),
                        validator: (String? value) {
                          if (value?.isEmpty ?? true) {
                            return 'Eneter a Password';
                          }
                          if (value!.length < 6) {
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
                          visible: _signUpInprogress == false,
                          replacement: const Center(
                            child: CircularProgressIndicator(),
                          ),
                          child: ElevatedButton(
                            onPressed: _signUp,
                            child: const Icon(
                                Icons.arrow_circle_right_outlined),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 48,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            "Have an account?",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: Colors.black54,
                            ),
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: const Text(
                              'Sign In',
                              style: TextStyle(
                                fontSize: 16,
                              ),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
          )),
    );
  }


  Future<void> _signUp() async {
    _signUpInprogress = true;
    if (mounted) {
      setState(() {

      });
    }
    if (_formKey.currentState!.validate()) {
      final NetworkResponse response = await NetWorkCaller()
          .postRequest(Urls.registration, body: {
        "email": _emailController.text.trim(),
        "firstName": _firstNameController.text.trim(),
        "lastName": _lastNameController.text.trim(),
        "mobile": _mobileController.text.trim(),
        "password": _passwordController.text,

      });
      _signUpInprogress = false;
      if (mounted) {
        setState(() {

        });
      }

      if (response.isSuccess) {
        _clearTextFields();
        if (mounted) {
          showSnackMessage(
              context, 'Account Created Successfully, Please Login');
        }
        else {
          showSnackMessage(
              context, 'Account Creation failed, Please try again', true);
        }
      }
    }
  }



  void _clearTextFields() {
    _emailController.clear();
    _firstNameController.clear();
    _lastNameController.clear();
    _mobileController.clear();
    _passwordController.clear();
  }

  @override
  void dispose() {

    _emailController.dispose();
    _firstNameController.dispose();
    _lastNameController.dispose();
    _mobileController.dispose();
    _passwordController.dispose();

    super.dispose();
  }
}
