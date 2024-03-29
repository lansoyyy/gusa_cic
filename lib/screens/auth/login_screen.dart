import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gusa_cic/screens/admin/adminhome_screen.dart';
import 'package:gusa_cic/screens/auth/signup_screen.dart';
import 'package:gusa_cic/screens/home_screen.dart';
import 'package:gusa_cic/utils/colors.dart';
import 'package:gusa_cic/widgets/button_widget.dart';
import 'package:gusa_cic/widgets/text_widget.dart';
import 'package:gusa_cic/widgets/textfield_widget.dart';
import 'package:gusa_cic/widgets/toast_widget.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final passController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color(0xff4093CE),
              Color(0xff9BCEF3),
            ],
          ),
        ),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset(
                'assets/images/Ellipse 1.png',
                width: 380,
              ),
              const SizedBox(
                height: 10,
              ),
              TextWidget(
                text: 'Welcome to GRS-CIC!',
                fontSize: 24,
                fontFamily: 'Bold',
                color: Colors.white,
              ),
              const SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(30, 0, 30, 10),
                child: Card(
                  child: Container(
                    height: 350,
                    width: double.infinity,
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [
                          Color(0xff4093CE),
                          Color(0xff9BCEF3),
                        ],
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          TextFieldWidget(
                            prefixIcon: Icons.email,
                            controller: emailController,
                            label: 'Email',
                          ),
                          TextFieldWidget(
                            isObscure: true,
                            showEye: true,
                            prefixIcon: Icons.lock,
                            controller: passwordController,
                            label: 'Password',
                          ),
                          TextButton(
                            onPressed: () {
                              showDialog(
                                context: context,
                                builder: ((context) {
                                  final formKey = GlobalKey<FormState>();
                                  final TextEditingController emailController =
                                      TextEditingController();

                                  return AlertDialog(
                                    backgroundColor: primary,
                                    title: TextWidget(
                                      text: 'Forgot Password',
                                      fontSize: 14,
                                      color: Colors.white,
                                    ),
                                    content: Form(
                                      key: formKey,
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          TextFieldWidget(
                                            hint: 'Email',
                                            textCapitalization:
                                                TextCapitalization.none,
                                            inputType:
                                                TextInputType.emailAddress,
                                            label: 'Email',
                                            controller: emailController,
                                            validator: (value) {
                                              if (value == null ||
                                                  value.isEmpty) {
                                                return 'Please enter an email address';
                                              }
                                              final emailRegex = RegExp(
                                                  r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
                                              if (!emailRegex.hasMatch(value)) {
                                                return 'Please enter a valid email address';
                                              }
                                              return null;
                                            },
                                          ),
                                        ],
                                      ),
                                    ),
                                    actions: [
                                      TextButton(
                                        onPressed: (() {
                                          Navigator.pop(context);
                                        }),
                                        child: TextWidget(
                                          text: 'Cancel',
                                          fontSize: 12,
                                          color: Colors.white,
                                        ),
                                      ),
                                      TextButton(
                                        onPressed: (() async {
                                          if (formKey.currentState!
                                              .validate()) {
                                            try {
                                              Navigator.pop(context);
                                              await FirebaseAuth.instance
                                                  .sendPasswordResetEmail(
                                                      email:
                                                          emailController.text);
                                              showToast(
                                                  'Password reset link sent to ${emailController.text}');
                                            } catch (e) {
                                              String errorMessage = '';

                                              if (e is FirebaseException) {
                                                switch (e.code) {
                                                  case 'invalid-email':
                                                    errorMessage =
                                                        'The email address is invalid.';
                                                    break;
                                                  case 'user-not-found':
                                                    errorMessage =
                                                        'The user associated with the email address is not found.';
                                                    break;
                                                  default:
                                                    errorMessage =
                                                        'An error occurred while resetting the password.';
                                                }
                                              } else {
                                                errorMessage =
                                                    'An error occurred while resetting the password.';
                                              }

                                              showToast(errorMessage);
                                              Navigator.pop(context);
                                            }
                                          }
                                        }),
                                        child: TextWidget(
                                          text: 'Continue',
                                          fontSize: 14,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ],
                                  );
                                }),
                              );
                            },
                            child: TextWidget(
                              text: 'Forgot Password',
                              fontSize: 14,
                              color: Colors.white,
                              fontFamily: 'Bold',
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              TextWidget(
                                text: 'Do not have an account?',
                                fontSize: 12,
                                color: Colors.white,
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              GestureDetector(
                                onTap: () {
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (context) =>
                                          const SignupScreen()));
                                },
                                child: TextWidget(
                                  text: 'Signup',
                                  fontSize: 14,
                                  color: Colors.white,
                                  fontFamily: 'Bold',
                                ),
                              )
                            ],
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          ButtonWidget(
                            radius: 20,
                            width: 250,
                            color: buttonColor,
                            label: 'Login',
                            onPressed: () {
                              login(context);
                            },
                          ),
                          TextButton(
                            onPressed: () {
                              showDialog(
                                context: context,
                                builder: (context) {
                                  return AlertDialog(
                                    title: TextWidget(
                                      text: 'Enter Admin Account',
                                      fontSize: 18,
                                      fontFamily: 'Bold',
                                    ),
                                    content: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        TextFieldWidget(
                                            textColor: Colors.black,
                                            label: 'Email',
                                            controller: emailController),
                                        TextFieldWidget(
                                            textColor: Colors.black,
                                            label: 'Password',
                                            showEye: true,
                                            isObscure: true,
                                            controller: passwordController)
                                      ],
                                    ),
                                    actions: [
                                      TextButton(
                                        onPressed: () {
                                          login(context);
                                        },
                                        child: TextWidget(
                                          text: 'Continue',
                                          fontSize: 18,
                                          fontFamily: 'Bold',
                                          color: Colors.black,
                                        ),
                                      ),
                                    ],
                                  );
                                },
                              );
                            },
                            child: TextWidget(
                              text: 'Administrator Login',
                              fontSize: 14,
                              color: Colors.white,
                              fontFamily: 'Bold',
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  login(context) async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: emailController.text, password: passwordController.text);

      if (emailController.text == 'admin@gmail.com') {
        showToast('Logged in as admin!');
        Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => const AdminHomeScreen()));
      } else {
        showToast('Logged in succesfully!');
        Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => const HomeScreen()));
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        showToast("No user found with that email.");
      } else if (e.code == 'wrong-password') {
        showToast("Wrong password provided for that user.");
      } else if (e.code == 'invalid-email') {
        showToast("Invalid email provided.");
      } else if (e.code == 'user-disabled') {
        showToast("User account has been disabled.");
      } else {
        showToast("An error occurred: ${e.message}");
      }
    } on Exception catch (e) {
      showToast("An error occurred: $e");
    }
  }
}
