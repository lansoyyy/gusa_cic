import 'package:flutter/material.dart';
import 'package:gusa_cic/screens/admin/adminhome_screen.dart';
import 'package:gusa_cic/screens/auth/signup_screen.dart';
import 'package:gusa_cic/screens/home_screen.dart';
import 'package:gusa_cic/utils/colors.dart';
import 'package:gusa_cic/widgets/button_widget.dart';
import 'package:gusa_cic/widgets/text_widget.dart';
import 'package:gusa_cic/widgets/textfield_widget.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: BoxDecoration(
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
              Image.asset('assets/images/Ellipse 1.png',
              width: 380,),
              SizedBox(height: 10,),
              TextWidget(text: 'Welcome to GRS-CIC!', fontSize: 24,
              fontFamily: 'Bold',
              color: Colors.white,),
                    SizedBox(height: 10,),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(30, 0, 30, 10),
                      child: Card(
                        child: Container(
                          height: 350,
                              width: double.infinity,
                              decoration: BoxDecoration(
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
                                      
                                      controller: emailController
                                    ,label: 'Email',),
                                     TextFieldWidget(
                                      isObscure: true,
                                      showEye: true,
                                      prefixIcon: Icons.lock,
                                      
                                      controller: passwordController
                                    ,label: 'Password',),
                                    
                                    TextButton(onPressed: () {}, child: TextWidget(text: 'Forgot Password', fontSize: 14,
                                    color: Colors.white,
                                    fontFamily: 'Bold',),),
                                   
                                   Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    
                                    children: [
                                      TextWidget(text: 'Do not have an account?', fontSize: 12,
                                      color: Colors.white,),
                                      SizedBox(width: 10,),
                                    GestureDetector(
                                      onTap: () {
                                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => const SignupScreen()));
                                        
                                      },
                                      child: TextWidget(text: 'Signup', fontSize: 14,
                                      color: Colors.white,
                                      fontFamily: 'Bold',),
                                    )
                                    ],
                                   ),
                                   SizedBox(height: 20,),
              ButtonWidget(
                radius: 20,
                width: 250,
                color: buttonColor,
                label: 'Login', onPressed: () {
                     Navigator.of(context).pushReplacement(MaterialPageRoute(
                          builder: (context) => const HomeScreen()));

              },),
               TextButton(onPressed: () {
                       Navigator.of(context).pushReplacement(MaterialPageRoute(
                          builder: (context) => const AdminHomeScreen()));
               }, child: TextWidget(text: 'Administrator Login', fontSize: 14,
                                    color: Colors.white,
                                    fontFamily: 'Bold',),),
                                    
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
}