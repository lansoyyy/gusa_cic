import 'package:flutter/material.dart';
import 'package:gusa_cic/screens/add_report_page.dart';
import 'package:gusa_cic/utils/colors.dart';
import 'package:gusa_cic/widgets/button_widget.dart';
import 'package:gusa_cic/widgets/text_widget.dart';
import 'package:gusa_cic/widgets/textfield_widget.dart';


class ResidentsScreen extends StatefulWidget {
  String? type;

  ResidentsScreen({this.type});

  @override
  State<ResidentsScreen> createState() => _AnnouncementScreenState();
}

class _AnnouncementScreenState extends State<ResidentsScreen> {


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
                          height: 500,
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
                                    TextWidget(text: 'Residents', fontSize: 24,
                                    color: Colors.black,),
                                   

                                    SizedBox(height: 400,
                                    child: ListView.builder(itemBuilder: (context, index) {
                                      return ExpansionTile(
                                        
                                        
                                        title: TextWidget(text: 'John Doe', fontSize: 14,
                                      color: Colors.white,),
                                      children: [
                                        Center(
                                          child: Icon(Icons.account_box_outlined       ,
                                          size: 75,
                                          color: Colors.white ,   ),
                                        ),
                                        SizedBox(height: 10,),
                                        TextWidget(text: 'Birthday: November 01, 2001', fontSize: 14,
                                      color: Colors.white,),
                                       TextWidget(text: 'Sex: Male', fontSize: 14,
                                      color: Colors.white,),
                                       TextWidget(text: 'Number: 09090104355', fontSize: 14,
                                      color: Colors.white,),
                                       TextWidget(text: 'Address: Nazareth, Cagayan De Oro', fontSize: 14,
                                      color: Colors.white,),
                                       TextWidget(text: 'Bloodtype: O+', fontSize: 14,
                                      color: Colors.white,),
                                       TextWidget(text: 'Email: john.doe@gmail.com', fontSize: 14,
                                      color: Colors.white,),
                                           SizedBox(height: 10,),
                                           Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                            children: [
                                              ButtonWidget(
                                                color: Colors.blue,
                                                height: 35,
                                                width: 75,
                                                fontSize: 12,
                                                label: 'View Reports', onPressed: () {

                                              },),
                                                     ButtonWidget(
                                                color: Colors.blue,
                                                height: 35,
                                                width: 75,
                                                fontSize: 12,
                                                label: 'Delete', onPressed: () {

                                              },),
                                            ],
                                           ),
                                      ],);

                                    }),),
                                        
                         
                                    
                                    
                                  ],
                                ),
                              ),
                      
                        ),
                      ),
                    ),
                    SizedBox(height: 10,),
                    
              
             
               
              
            ],
          ),
        ),
      ),
    );
  }
}