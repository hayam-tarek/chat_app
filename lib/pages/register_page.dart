import 'dart:developer';

import 'package:chat_app/helper/constant.dart';
import 'package:chat_app/pages/chat_page.dart';
import 'package:chat_app/widgets/custom_button.dart';
import 'package:chat_app/widgets/custom_text_form_field.dart';
import 'package:chat_app/widgets/snake_bar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});
  static const String id = 'RegisterPage';

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  String emailAddress = '';

  String password = '';

  String rePassword = '';

  bool isLoading = false;

  GlobalKey<FormState> formKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      color: kFirstColor,
      // ignore: prefer_const_constructors
      progressIndicator: CircularProgressIndicator(color: kThirdColor),
      inAsyncCall: isLoading,
      child: Scaffold(
        backgroundColor: kPrimaryColor,
        body: Form(
          key: formKey,
          child: ListView(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  // crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(
                      height: 50,
                    ),
                    Image.asset(
                      'asset/images/graduation.png',
                      scale: 4,
                    ),
                    const Text(
                      'Scholar Chat',
                      style: TextStyle(
                        fontSize: 30,
                        fontFamily: "Pacifico",
                        color: Colors.black,
                      ),
                    ),
                    const SizedBox(
                      height: 70,
                    ),
                    const Padding(
                      padding: EdgeInsets.symmetric(
                        vertical: 10,
                      ),
                      child: Row(
                        children: [
                          Text(
                            'REGISTER',
                            style: TextStyle(
                              fontSize: 25,
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 5),
                      child: CustomTextFormField(
                        textInputType: TextInputType.emailAddress,
                        validator: (val) {
                          if (val == null || !val.contains('@')) {
                            return 'Please enter a valid email';
                          }
                          return null;
                        },
                        onChanged: (val) {
                          emailAddress = val;
                        },
                        hintText: 'Email',
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 5),
                      child: CustomTextFormField(
                        textInputType: TextInputType.visiblePassword,
                        obscureText: true,
                        validator: (val) {
                          if (val == null || val.length < 6) {
                            return 'Please enter a valid password';
                          }
                          return null;
                        },
                        onChanged: (val) {
                          password = val;
                        },
                        hintText: 'Password',
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 5),
                      child: CustomTextFormField(
                        textInputType: TextInputType.visiblePassword,
                        obscureText: true,
                        validator: (val) {
                          if (val == null || val != password) {
                            return ('Does\'t match');
                          }
                          return null;
                        },
                        onChanged: (val) {
                          rePassword = val;
                        },
                        hintText: 'Confirm Password',
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 5),
                      child: CustomButton(
                        onTap: () async {
                          if (formKey.currentState!.validate()) {
                            setState(() {
                              isLoading = true;
                            });
                            try {
                              await registerANewUser();
                              Navigator.pushNamed(context, ChatPage.id,
                                  arguments: emailAddress);
                            } on FirebaseAuthException catch (e) {
                              if (e.code == 'weak-password') {
                                log('The password provided is too weak.');
                                showSnakeBar(context,
                                    message:
                                        'The password provided is too weak.');
                              } else if (e.code == 'email-already-in-use') {
                                log('The account already exists for that email.');
                                showSnakeBar(context,
                                    message:
                                        'The account already exists for that email.');
                              }
                              log(e.code);
                              showSnakeBar(context,
                                  message: 'Something went wrong... try again');
                            } catch (e) {
                              log(e.toString());
                              showSnakeBar(context,
                                  message: 'There was an error.. try again');
                            }
                          }
                          setState(() {
                            isLoading = false;
                          });
                        },
                        text: 'REGISTER',
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 5),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            'already have an account? ',
                            style: TextStyle(
                              fontSize: 18,
                            ),
                          ),
                          InkWell(
                            borderRadius: BorderRadius.circular(10),
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: const Text(
                              'Login',
                              style: TextStyle(
                                color: kFirstColor,
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> registerANewUser() async {
    final UserCredential credential =
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
      email: emailAddress,
      password: password,
    );
  }
}
