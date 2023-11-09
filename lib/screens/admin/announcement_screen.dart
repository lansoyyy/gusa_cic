import 'package:flutter/material.dart';
import 'package:gusa_cic/screens/add_report_page.dart';
import 'package:gusa_cic/utils/colors.dart';
import 'package:gusa_cic/widgets/button_widget.dart';
import 'package:gusa_cic/widgets/text_widget.dart';
import 'package:gusa_cic/widgets/textfield_widget.dart';


class AnnouncementScreen extends StatefulWidget {
  String? type;

  AnnouncementScreen({this.type});

  @override
  State<AnnouncementScreen> createState() => _AnnouncementScreenState();
}

class _AnnouncementScreenState extends State<AnnouncementScreen> {


  final descController = TextEditingController();
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


        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Icon(Icons.account_circle_rounded,
                  color: Colors.white,),
                  SizedBox(width: 10,),
                  TextWidget(text: 'ADMIN', fontSize: 18,
                  color: Colors.white,
                  fontFamily: 'Bold',),
                ],
              ),
              SizedBox(height: 50,),
              Padding(
                      padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                      child: Card(
                        child: Container(
                          height: 320,
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
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    TextWidget(text: 'Make ${widget.type}', fontSize: 24,
                                    color: Colors.black,),
                                    SizedBox(height: 20,),
                                        
                             TextFieldWidget(
                              label: 'Type an announcement...',
                              maxLine: 8,
                              height: 200,
                              controller: descController,),
                                    
                                    
                                  ],
                                ),
                              ),
                      
                        ),
                      ),
                    ),
                    SizedBox(height: 10,),
                    Padding(
                       padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          IconButton(onPressed: () {
                            
                          }, icon: Icon(Icons.camera,),),
                          IconButton(onPressed: () {
                            
                          }, icon: Icon(Icons.image,),),
                          Expanded(child: SizedBox()),
                          ButtonWidget(
                            radius: 15,
                            width: 150,
                            height: 40,
                            color: buttonColor,
                            textColor: Colors.black,
                            label: 'Add', onPressed: () {
                    
                          }),
                        ],
                      ),
                    ),
              
             
               
              
            ],
          ),
        ),
      ),
    );
  }
}