import 'package:flutter/material.dart';
import 'package:gusa_cic/screens/auth/login_screen.dart';
import 'package:gusa_cic/utils/colors.dart';
import 'package:gusa_cic/widgets/button_widget.dart';
import 'package:gusa_cic/widgets/text_widget.dart';
import 'package:gusa_cic/widgets/textfield_widget.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<SignupScreen> {
    final firstnameController = TextEditingController();
      final middlenameController = TextEditingController();
        final lastnameController = TextEditingController();
          final addressController = TextEditingController();
            final phonenumberController = TextEditingController();
              final bloodtypeController = TextEditingController();
                final genderController = TextEditingController();

  final emailController = TextEditingController();
  final passwordController = TextEditingController();
    final confirmpasswordController = TextEditingController();
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
        
            
           
                    Padding(
                      padding: const EdgeInsets.fromLTRB(20, 20, 20, 20),
                      child: Card(
                        child: Container(
                          height: 600,
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
                                child: SingleChildScrollView(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                         TextWidget(text: 'Signup', fontSize: 24,
                                              fontFamily: 'Bold',
                                              color: Colors.white,),
                                               TextWidget(text: 'Create your first account', fontSize: 12,
                                              fontFamily: 'Regular',
                                              color: Colors.white,),
                                                    SizedBox(height: 10,),
                                                    Icon(Icons.account_circle,
                                                    size: 75,),
                                                      SizedBox(height: 10,),
                                                       TextFieldWidget(
                                        prefixIcon: Icons.person,
                                        
                                        controller: firstnameController
                                      ,label: 'First Name',),
                                       TextFieldWidget(
                                        prefixIcon: Icons.person,
                                        
                                        controller: middlenameController
                                      ,label: 'Middle Name',),
                                       TextFieldWidget(
                                        prefixIcon: Icons.person,
                                        
                                        controller: lastnameController
                                      ,label: 'Last Name',),
                                          TextFieldWidget(
                                        prefixIcon: Icons.group,
                                        
                                        controller: genderController
                                      ,label: 'Gender',),
                                          TextFieldWidget(
                                        prefixIcon: Icons.phone,
                                        
                                        controller: phonenumberController
                                      ,label: 'Mobile number',),
                                          TextFieldWidget(
                                        prefixIcon: Icons.location_on,
                                        
                                        controller: addressController
                                      ,label: 'Home Address',),
                                        TextFieldWidget(
                                        prefixIcon: Icons.bloodtype,
                                        
                                        controller: addressController
                                      ,label: 'Blood Type',),
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
                                           TextFieldWidget(
                                        isObscure: true,
                                        showEye: true,
                                        prefixIcon: Icons.lock,
                                        
                                        controller: confirmpasswordController
                                      ,label: 'Confirm password',),
                                      
                                   
                                     
                                   SizedBox(height: 20,),
                                
                                              ButtonWidget(
                                                radius: 20,
                                                width: 250,
                                                color: buttonColor,
                                                label: 'Signup', onPressed: () {
                                                     Navigator.of(context).push(MaterialPageRoute(
                                                          builder: (context) => const LoginScreen()));
                                
                                              },),
                                                          SizedBox(height: 10,),
                                        Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      
                                      children: [
                                        TextWidget(text: 'Already have an account?', fontSize: 12,
                                        color: Colors.white,),
                                        SizedBox(width: 10,),
                                      GestureDetector(
                                        onTap: () {
                                           Navigator.of(context).pushReplacement(MaterialPageRoute(
                          builder: (context) => const LoginScreen()));
                                          
                                        },
                                        child: TextWidget(text: 'Login', fontSize: 14,
                                        color: Colors.white,
                                        fontFamily: 'Bold',),
                                      )
                                      ],
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
      
      ),
    );
  }
}