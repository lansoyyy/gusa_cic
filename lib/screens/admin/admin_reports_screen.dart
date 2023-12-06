import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:gusa_cic/widgets/text_widget.dart';
import 'package:intl/intl.dart';

class AdminReportsScreen extends StatefulWidget {
  String? type;

  AdminReportsScreen({super.key, this.type});

  @override
  State<AdminReportsScreen> createState() => _AnnouncementScreenState();
}

class _AnnouncementScreenState extends State<AdminReportsScreen> {
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
                    decoration: const BoxDecoration(color: Colors.white),
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          TextWidget(
                            text: widget.type!,
                            fontSize: 24,
                            color: Colors.black,
                          ),
                          SizedBox(
                            height: 400,
                            child: SingleChildScrollView(
                              child: StreamBuilder<QuerySnapshot>(
                                  stream: FirebaseFirestore.instance
                                      .collection('Reports')
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
                                          text: '',
                                          fontSize: 13,
                                          fontFamily: 'Bold',
                                        ),
                                      ),
                                      DataColumn(
                                        label: TextWidget(
                                          text: 'Reporter',
                                          fontSize: 13,
                                          fontFamily: 'Bold',
                                        ),
                                      ),
                                      DataColumn(
                                        label: TextWidget(
                                            text: 'Details',
                                            fontSize: 13,
                                            fontFamily: 'Bold'),
                                      ),
                                    ], rows: [
                                      for (int i = 0; i < data.docs.length; i++)
                                        DataRow(cells: [
                                          DataCell(
                                            TextWidget(
                                              text: '${i + 1}',
                                              fontSize: 11,
                                            ),
                                          ),
                                          DataCell(
                                            TextWidget(
                                              text: data.docs[i]['reporter'],
                                              fontSize: 11,
                                            ),
                                          ),
                                          DataCell(TextButton(
                                            onPressed: () {
                                              showDialog(
                                                context: context,
                                                builder: (context) {
                                                  return AlertDialog(
                                                    content: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      mainAxisSize:
                                                          MainAxisSize.min,
                                                      children: [
                                                        TextWidget(
                                                          text:
                                                              'Reporter: ${data.docs[i]['reporter']}',
                                                          fontSize: 18,
                                                        ),
                                                        TextWidget(
                                                          text:
                                                              'Type: ${data.docs[i]['type']}',
                                                          fontSize: 14,
                                                        ),
                                                        TextWidget(
                                                          text:
                                                              'Description: ${data.docs[i]['desc']}',
                                                          fontSize: 14,
                                                        ),
                                                        TextWidget(
                                                          text:
                                                              'Date and Time: ${DateFormat.yMMMd().add_jm().format(data.docs[i]['dateTime'].toDate())}',
                                                          fontSize: 14,
                                                        ),
                                                        const SizedBox(
                                                          height: 10,
                                                        ),
                                                        Container(
                                                          width:
                                                              double.infinity,
                                                          height: 250,
                                                          color: Colors.black,
                                                        ),
                                                      ],
                                                    ),
                                                    actions: [
                                                      TextButton(
                                                        onPressed: () {
                                                          Navigator.pop(
                                                              context);
                                                        },
                                                        child: TextWidget(
                                                          text: 'Close',
                                                          fontSize: 14,
                                                        ),
                                                      ),
                                                      TextButton(
                                                        onPressed: () async {
                                                          await FirebaseFirestore
                                                              .instance
                                                              .doc(data
                                                                  .docs[i].id)
                                                              .delete();
                                                          Navigator.pop(
                                                              context);
                                                        },
                                                        child: TextWidget(
                                                          text: 'Delete',
                                                          fontSize: 14,
                                                        ),
                                                      )
                                                    ],
                                                  );
                                                },
                                              );
                                            },
                                            child: TextWidget(
                                              text:
                                                  'View ${widget.type} detail',
                                              fontSize: 11,
                                            ),
                                          )),
                                        ])
                                    ]);
                                  }),
                            ),
                          ),
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
