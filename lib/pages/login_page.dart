import 'dart:developer';

import 'package:chat_app/constant.dart';
import 'package:chat_app/pages/chat_page.dart';
import 'package:chat_app/pages/register_page.dart';
import 'package:chat_app/widgets/custom_button.dart';
import 'package:chat_app/widgets/custom_text_form_field.dart';
import 'package:chat_app/widgets/snake_bar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});
  static const String id = 'LoginPage';

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String emailAddress = '';

  String password = '';

  bool isLoading = false;

  GlobalKey<FormState> formKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      color: kFirstColor,
      progressIndicator: const CircularProgressIndicator(color: kThirdColor),
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
                            'LOGIN',
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
                      child: CustomButton(
                        onTap: () async {
                          if (formKey.currentState!.validate()) {
                            setState(() {
                              isLoading = true;
                            });
                            try {
                              await loginUser();
                              Navigator.pushNamed(context, ChatPage.id,
                                  arguments: emailAddress);
                            } on FirebaseAuthException catch (e) {
                              if (e.code == 'user-not-found') {
                                log('No user found for that email.');
                                showSnakeBar(context,
                                    message: 'No user found for that email.');
                              } else if (e.code == 'wrong-password') {
                                log('Wrong password provided for that user.');
                                showSnakeBar(context,
                                    message:
                                        'Wrong password provided for that user.');
                              }
                              log(e.code);
                              showSnakeBar(context,
                                  message: 'Something went wrong.. try again');
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
                        text: 'LOGIN',
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 5),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            'don\'t have an account? ',
                            style: TextStyle(
                              fontSize: 18,
                            ),
                          ),
                          InkWell(
                            borderRadius: BorderRadius.circular(10),
                            onTap: () {
                              Navigator.pushNamed(context, RegisterPage.id);
                            },
                            child: const Text(
                              'Register',
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

  Future<void> loginUser() async {
    final UserCredential credential =
        await FirebaseAuth.instance.signInWithEmailAndPassword(
      email: emailAddress,
      password: password,
    );
  }
}
