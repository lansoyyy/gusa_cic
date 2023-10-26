import 'package:flutter/material.dart';
import 'package:gusa_cic/utils/colors.dart';
import 'package:gusa_cic/widgets/button_widget.dart';
import 'package:gusa_cic/widgets/text_widget.dart';
import 'package:gusa_cic/widgets/textfield_widget.dart';

class AddreportScreen extends StatefulWidget {


  String type;

  AddreportScreen({
    required this.type
  });
  

  @override
  State<AddreportScreen> createState() => _AddreportScreenState();
}

class _AddreportScreenState extends State<AddreportScreen> {

    List<String> type1 = [
    'Type 1',
     'Type 2',
      'Type 3',
    
  ];
  String selected = 'Type 1';


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
        child: SingleChildScrollView(
          child: SafeArea(
            child: Padding(
             padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Icon(Icons.account_circle,
                      color:Colors.white,
                      size: 48,),
                      SizedBox(width: 20,),
                      TextWidget(text: 'John Doe', fontSize: 18,
                      fontFamily: 'Bold',
                      color: Colors.white,),
                    ],
                  ),
                  
                  SizedBox(height: 20,),
                     
                     
                      
                      Card(
                        child: Container(
                                          width: double.infinity,
                                          height: 450,
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
                          children: [
                            TextWidget(text: 'Submit ${widget.type} Report', fontSize: 18,
                            fontFamily: 'Bold',),
                            SizedBox(height: 20,),
                            Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                              border: Border.all(
                                color: Colors.black,
                              
                              ),
                              borderRadius: BorderRadius.circular(5)),
                          child: DropdownButton<String>(
                            
                            onChanged: (newValue) {
                              setState(() {
                                selected = newValue.toString();
                              });
                            },

                            underline: const SizedBox(),
                            value: selected,
                            items: type1.map((String item) {
                              return DropdownMenuItem<String>(
                                
                                value: item,
                                child: Center(
                                  child: SizedBox(
                                    width: 250,
                                    child: Padding(
                                      padding: const EdgeInsets.all(5.0),
                                      child: Text(
                                        item,
                                        style: const TextStyle(
                                            color: Colors.black,
                                            fontFamily: 'QRegular',
                                            fontSize: 14),
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            }).toList(),)),
                            SizedBox(height: 10,),
                            ButtonWidget(
                          
                              color: Colors.white,
                              width: 100,
                              height: 35,
                              fontSize: 12,
                              textColor: Colors.black,
                              label: 'Upload a photo', onPressed: () {

                            },),
                             SizedBox(height: 10,),
                             TextFieldWidget(
                              label: 'I-type ang mga delalye dinhi...',
                              maxLine: 8,
                              height: 200,
                              controller: descController,),
                          ],
                        ),
                        
                                          ),
                                         
                                        ),
                      ),
                      SizedBox(height: 20,),
                      Align(
                        alignment: Alignment.topRight,
                        child:   ButtonWidget(
                          radius: 15,
                          width: 150,
                          height: 40,
                          color: buttonColor,
                          textColor: Colors.black,
                          label: 'Send', onPressed: () {

                        }),
                      ),
                  
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}