import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:gusa_cic/screens/admin/residents_screen.dart';
import 'package:gusa_cic/utils/colors.dart';
import 'package:gusa_cic/widgets/button_widget.dart';
import 'package:gusa_cic/widgets/text_widget.dart';
import 'package:intl/intl.dart';

import '../auth/login_screen.dart';
import 'admin_reports_screen.dart';
import 'announcement_screen.dart';

class AdminHomeScreen extends StatelessWidget {
  const AdminHomeScreen({super.key});

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
          child: SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
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
                  height: 30,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextWidget(
                      text: 'GUSA - CIC',
                      fontSize: 16,
                      color: Colors.white,
                      fontFamily: 'Bold',
                    ),
                    TextWidget(
                      text: DateFormat.yMMMd().format(DateTime.now()),
                      fontSize: 16,
                      color: Colors.white,
                      fontFamily: 'Bold',
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                const Divider(
                  color: Colors.white,
                ),
                const SizedBox(
                  height: 10,
                ),
                TextWidget(
                  text: 'Reports',
                  fontSize: 18,
                  fontFamily: 'Bold',
                  color: Colors.white,
                ),
                const SizedBox(
                  height: 10,
                ),
                Card(
                  child: SizedBox(
                      height: 335,
                      child: SingleChildScrollView(
                        child: SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
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
                                                          const EdgeInsets.all(
                                                              10.0),
                                                      child: Column(
                                                        children: [
                                                          TextWidget(
                                                            text:
                                                                'Are you sure you want to delete this report?',
                                                            fontSize: 14,
                                                            fontFamily: 'Bold',
                                                            color: Colors.black,
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
                                                                          .docs[
                                                                              i]
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
                                                                label: 'Cancel',
                                                                onPressed: () {
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
                const SizedBox(
                  height: 100,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          IconButton(
                            onPressed: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => AdminReportsScreen(
                                        type: 'Concern',
                                      )));
                            },
                            icon: const Icon(
                              Icons.report,
                              size: 45,
                            ),
                          ),
                          IconButton(
                            onPressed: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => AnnouncementScreen()));
                            },
                            icon: const Icon(
                              Icons.announcement,
                              size: 45,
                            ),
                          ),
                          IconButton(
                            onPressed: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => ResidentsScreen()));
                            },
                            icon: const Icon(
                              Icons.group,
                              size: 45,
                            ),
                          ),
                          IconButton(
                            onPressed: () {
                              showDialog(
                                  context: context,
                                  builder: (context) => AlertDialog(
                                        title: const Text(
                                          'Logout Confirmation',
                                          style: TextStyle(
                                              fontFamily: 'Bold',
                                              fontWeight: FontWeight.bold),
                                        ),
                                        content: const Text(
                                          'Are you sure you want to Logout?',
                                          style:
                                              TextStyle(fontFamily: 'Regular'),
                                        ),
                                        actions: <Widget>[
                                          MaterialButton(
                                            onPressed: () =>
                                                Navigator.of(context).pop(true),
                                            child: const Text(
                                              'Close',
                                              style: TextStyle(
                                                  fontFamily: 'Regular',
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ),
                                          MaterialButton(
                                            onPressed: () async {
                                              Navigator.of(context).pushReplacement(
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          const LoginScreen()));
                                            },
                                            child: const Text(
                                              'Continue',
                                              style: TextStyle(
                                                  fontFamily: 'Regular',
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ),
                                        ],
                                      ));
                            },
                            icon: const Icon(
                              Icons.logout,
                              size: 45,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
