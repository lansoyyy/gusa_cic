import 'package:flutter/material.dart';
import 'package:gusa_cic/screens/auth/login_screen.dart';
import 'package:gusa_cic/utils/colors.dart';
import 'package:gusa_cic/widgets/button_widget.dart';
import 'package:gusa_cic/widgets/text_widget.dart';

class LandingScreen extends StatelessWidget {
  const LandingScreen({super.key});

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
              SizedBox(height: 50,),
              Image.asset('assets/images/353653853_232117176242790_3682695260927349816_n-removebg-preview 1.png',
              height: 175,),
              SizedBox(height: 100,),
              Image.asset('assets/images/Welcome to Barangay Gusa Report System!.png',
              width: 250,),
              Padding(
                padding: const EdgeInsets.only(left: 20, right: 20),
                child: Divider(),
              ),
              SizedBox(height: 20,),
              Padding(
                  padding: const EdgeInsets.only(left: 20, right: 20),
                child: TextWidget(text: 'Submit your complaints, incidents, and concerns effortlessly, track their progress, and communicate with barangay officials seamlessly. Together, lets build a safer and stronger community.', fontSize: 12,
                fontFamily: 'Medium',
                color: Colors.black,),
              ),
              SizedBox(height: 50,),
              ButtonWidget(
                radius: 20,
                color: buttonColor,
                label: 'Get Started', onPressed: () {
                     Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => const LoginScreen()));

              },),

              
            ],
          ),
        ),
      
      ),
    );
  }
}