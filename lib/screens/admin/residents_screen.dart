import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:gusa_cic/screens/admin/view_reports_screen.dart';
import 'package:gusa_cic/widgets/text_widget.dart';

import '../../widgets/button_widget.dart';

class ResidentsScreen extends StatefulWidget {
  String? type;

  ResidentsScreen({super.key, this.type});

  @override
  State<ResidentsScreen> createState() => _AnnouncementScreenState();
}

class _AnnouncementScreenState extends State<ResidentsScreen> {
  final descController = TextEditingController();
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
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const Icon(
                    Icons.account_circle_rounded,
                    color: Colors.white,
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  TextWidget(
                    text: 'ADMIN',
                    fontSize: 18,
                    color: Colors.white,
                    fontFamily: 'Bold',
                  ),
                ],
              ),
              const SizedBox(
                height: 50,
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                child: Card(
                  child: Container(
                    height: 500,
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
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          TextWidget(
                            text: 'Residents',
                            fontSize: 24,
                            color: Colors.black,
                          ),
                          StreamBuilder<QuerySnapshot>(
                              stream: FirebaseFirestore.instance
                                  .collection('Users')
                                  .snapshots(),
                              builder: (BuildContext context,
                                  AsyncSnapshot<QuerySnapshot> snapshot) {
                                if (snapshot.hasError) {
                                  print(snapshot.error);
                                  return const Center(child: Text('Error'));
                                }
                                if (snapshot.connectionState ==
                                    ConnectionState.waiting) {
                                  return const Padding(
                                    padding: EdgeInsets.only(top: 50),
                                    child: Center(
                                      child: CircularProgressIndicator(
                                        color: Colors.black,
                                      ),
                                    ),
                                  );
                                }

                                final data = snapshot.requireData;
                                return DataTable(columns: [
                                  DataColumn(
                                    label: TextWidget(
                                      text: 'Name',
                                      fontSize: 16,
                                      fontFamily: 'Bold',
                                    ),
                                  ),
                                  DataColumn(
                                    label: TextWidget(
                                      text: 'View Reports',
                                      fontSize: 16,
                                      fontFamily: 'Bold',
                                    ),
                                  ),
                                ], rows: [
                                  for (int i = 0; i < data.docs.length; i++)
                                    DataRow(cells: [
                                      DataCell(
                                        TextWidget(
                                          text:
                                              '${data.docs[i]['fname']} ${data.docs[i]['mname'][0]}. ${data.docs[i]['lname']}',
                                          fontSize: 14,
                                        ),
                                      ),
                                      DataCell(
                                        ButtonWidget(
                                          color: Colors.blue,
                                          height: 30,
                                          width: 100,
                                          fontSize: 10,
                                          label: 'View Reports',
                                          onPressed: () {
                                            Navigator.of(context).push(
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        ViewReportsScreen(
                                                          id: data.docs[i].id,
                                                        )));
                                          },
                                        ),
                                      ),
                                    ])
                                ]);
                              })
                          // StreamBuilder<QuerySnapshot>(
                          //     stream: FirebaseFirestore.instance
                          //         .collection('Users')
                          //         .snapshots(),
                          //     builder: (BuildContext context,
                          //         AsyncSnapshot<QuerySnapshot> snapshot) {
                          //       if (snapshot.hasError) {
                          //         print(snapshot.error);
                          //         return const Center(child: Text('Error'));
                          //       }
                          //       if (snapshot.connectionState ==
                          //           ConnectionState.waiting) {
                          //         return const Padding(
                          //           padding: EdgeInsets.only(top: 50),
                          //           child: Center(
                          //             child: CircularProgressIndicator(
                          //               color: Colors.black,
                          //             ),
                          //           ),
                          //         );
                          //       }

                          //       final data = snapshot.requireData;
                          //       return SizedBox(
                          //         height: 400,
                          //         child: ListView.builder(
                          //             itemCount: data.docs.length,
                          //             itemBuilder: (context, index) {
                          //               return ExpansionTile(
                          //                 title: TextWidget(
                          //                   text:
                          //                       '${data.docs[index]['fname']} ${data.docs[index]['mname'][0]}. ${data.docs[index]['lname']}',
                          //                   fontSize: 14,
                          //                   color: Colors.white,
                          //                 ),
                          //                 children: [
                          //                   const Center(
                          //                     child: Icon(
                          //                       Icons.account_box_outlined,
                          //                       size: 75,
                          //                       color: Colors.white,
                          //                     ),
                          //                   ),
                          //                   const SizedBox(
                          //                     height: 10,
                          //                   ),
                          //                   TextWidget(
                          //                     text:
                          //                         'Sex: ${data.docs[index]['gender']}',
                          //                     fontSize: 14,
                          //                     color: Colors.white,
                          //                   ),
                          //                   TextWidget(
                          //                     text:
                          //                         'Number: ${data.docs[index]['mobilenumber']}',
                          //                     fontSize: 14,
                          //                     color: Colors.white,
                          //                   ),
                          //                   TextWidget(
                          //                     text:
                          //                         'Address: ${data.docs[index]['address']}',
                          //                     fontSize: 14,
                          //                     color: Colors.white,
                          //                   ),
                          //                   TextWidget(
                          //                     text:
                          //                         'Bloodtype: ${data.docs[index]['bloodtype']}',
                          //                     fontSize: 14,
                          //                     color: Colors.white,
                          //                   ),
                          //                   TextWidget(
                          //                     text:
                          //                         'Email: ${data.docs[index]['email']}',
                          //                     fontSize: 14,
                          //                     color: Colors.white,
                          //                   ),
                          //                   const SizedBox(
                          //                     height: 10,
                          //                   ),
                          //                   ButtonWidget(
                          //                     color: Colors.blue,
                          //                     height: 35,
                          //                     width: 75,
                          //                     fontSize: 12,
                          //                     label: 'View Reports',
                          //                     onPressed: () {
                          //                       Navigator.of(context).push(
                          //                           MaterialPageRoute(
                          //                               builder: (context) =>
                          //                                   ViewReportsScreen(
                          //                                     id: data
                          //                                         .docs[index]
                          //                                         .id,
                          //                                   )));
                          //                     },
                          //                   ),
                          //                 ],
                          //               );
                          //             }),
                          //       );
                          //     }),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
