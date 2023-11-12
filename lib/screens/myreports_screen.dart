import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gusa_cic/utils/colors.dart';
import 'package:gusa_cic/widgets/button_widget.dart';
import 'package:gusa_cic/widgets/text_widget.dart';

class MyreportsScreen extends StatelessWidget {
  const MyreportsScreen({super.key});

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
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const Icon(
                        Icons.account_circle,
                        color: Colors.white,
                        size: 48,
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                      TextWidget(
                        text: 'John Doe',
                        fontSize: 18,
                        fontFamily: 'Bold',
                        color: Colors.white,
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextWidget(
                    text: 'My Reports',
                    fontSize: 18,
                    fontFamily: 'Bold',
                    color: Colors.white,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Container(
                    width: double.infinity,
                    height: 500,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.white,
                    ),
                    child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: SingleChildScrollView(
                          child: SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: StreamBuilder<QuerySnapshot>(
                                stream: FirebaseFirestore.instance
                                    .collection('Reports')
                                    .where('uid',
                                        isEqualTo: FirebaseAuth
                                            .instance.currentUser!.uid)
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
                                        text: 'Reports',
                                        fontSize: 13,
                                        fontFamily: 'Bold',
                                      ),
                                    ),
                                    DataColumn(
                                      label: TextWidget(
                                          text: 'Type',
                                          fontSize: 13,
                                          fontFamily: 'Bold'),
                                    ),
                                    DataColumn(
                                      label: TextWidget(
                                          text: 'Details',
                                          fontSize: 13,
                                          fontFamily: 'Bold'),
                                    ),
                                    DataColumn(
                                      label: TextWidget(
                                        text: '',
                                        fontSize: 13,
                                      ),
                                    ),
                                  ], rows: [
                                    for (int i = 0; i < data.docs.length; i++)
                                      DataRow(cells: [
                                        DataCell(
                                          TextWidget(
                                            text: data.docs[i]['type'],
                                            fontSize: 11,
                                          ),
                                        ),
                                        DataCell(
                                          TextWidget(
                                            text: data.docs[i]['categ'],
                                            fontSize: 11,
                                          ),
                                        ),
                                        DataCell(
                                          TextWidget(
                                            text: data.docs[i]['desc'],
                                            fontSize: 11,
                                          ),
                                        ),
                                        DataCell(
                                          GestureDetector(
                                            onTap: () {
                                              showDialog(
                                                context: context,
                                                builder: (context) {
                                                  return Dialog(
                                                    backgroundColor: primary,
                                                    child: SizedBox(
                                                      height: 125,
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(10.0),
                                                        child: Column(
                                                          children: [
                                                            TextWidget(
                                                              text:
                                                                  'Are you sure you want to delete this report?',
                                                              fontSize: 14,
                                                              fontFamily:
                                                                  'Bold',
                                                              color:
                                                                  Colors.black,
                                                            ),
                                                            const SizedBox(
                                                              height: 20,
                                                            ),
                                                            Row(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .spaceEvenly,
                                                              children: [
                                                                ButtonWidget(
                                                                  color:
                                                                      buttonColor,
                                                                  width: 100,
                                                                  height: 40,
                                                                  radius: 5,
                                                                  label: 'Ok',
                                                                  onPressed:
                                                                      () async {
                                                                    await FirebaseFirestore
                                                                        .instance
                                                                        .doc(data
                                                                            .docs[i]
                                                                            .id)
                                                                        .delete();
                                                                    Navigator.pop(
                                                                        context);
                                                                  },
                                                                ),
                                                                ButtonWidget(
                                                                  color:
                                                                      buttonColor,
                                                                  width: 100,
                                                                  height: 40,
                                                                  radius: 5,
                                                                  label:
                                                                      'Cancel',
                                                                  onPressed:
                                                                      () {
                                                                    Navigator.pop(
                                                                        context);
                                                                  },
                                                                ),
                                                              ],
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                  );
                                                },
                                              );
                                            },
                                            child: const Icon(
                                              Icons.delete,
                                            ),
                                          ),
                                        ),
                                      ])
                                  ]);
                                }),
                          ),
                        )),
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
