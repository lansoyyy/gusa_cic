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
                const SizedBox(
                  height: 5,
                  child: Divider(
                    color: Colors.black,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Image.asset(
                  'assets/images/image 26.png',
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
                      height: 325,
                      child: SingleChildScrollView(
                        child: SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: StreamBuilder<QuerySnapshot>(
                              stream: FirebaseFirestore.instance
                                  .collection('Reports')
                                  .orderBy('dateTime', descending: true)
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
                                return DataTable(
                                    headingRowColor: MaterialStateProperty.all(
                                        Colors.blue[300]),
                                    border: TableBorder.all(color: Colors.grey),
                                    columns: [
                                      DataColumn(
                                        label: TextWidget(
                                          text: 'Reporter',
                                          fontSize: 13,
                                          fontFamily: 'Bold',
                                        ),
                                      ),
                                      DataColumn(
                                        label: TextWidget(
                                            text: 'Report',
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
                                    ],
                                    rows: [
                                      for (int i = 0; i < data.docs.length; i++)
                                        DataRow(cells: [
                                          DataCell(
                                            GestureDetector(
                                              onTap: () {
                                                showpersondetail(context,
                                                    data.docs[i]['uid']);
                                              },
                                              child: TextWidget(
                                                text: data.docs[i]['reporter'],
                                                fontSize: 11,
                                              ),
                                            ),
                                          ),
                                          DataCell(
                                            TextWidget(
                                              text: data.docs[i]['categ'],
                                              fontSize: 11,
                                            ),
                                          ),
                                          DataCell(
                                            GestureDetector(
                                              onTap: () {
                                                showreportdetails(
                                                    context, data.docs[i]);
                                              },
                                              child: TextWidget(
                                                text: 'View Report',
                                                fontSize: 11,
                                              ),
                                            ),
                                          ),
                                          DataCell(
                                            Row(
                                              children: [
                                                ButtonWidget(
                                                  radius: 0,
                                                  width: 75,
                                                  height: 30,
                                                  fontSize: 11,
                                                  color: data.docs[i]
                                                              ['status'] ==
                                                          'Pending'
                                                      ? Colors.grey
                                                      : data.docs[i]
                                                                  ['status'] ==
                                                              'Ongoing'
                                                          ? Colors.yellow
                                                          : Colors.green,
                                                  label: data.docs[i]['status'],
                                                  onPressed: () {
                                                    showDialog(
                                                      context: context,
                                                      builder: (context) {
                                                        return Dialog(
                                                          backgroundColor:
                                                              primary,
                                                          child: SizedBox(
                                                            height: 250,
                                                            child: Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                          .all(
                                                                      10.0),
                                                              child: Column(
                                                                children: [
                                                                  TextWidget(
                                                                    text:
                                                                        'Mark as:',
                                                                    fontSize:
                                                                        14,
                                                                    fontFamily:
                                                                        'Bold',
                                                                    color: Colors
                                                                        .black,
                                                                  ),
                                                                  const SizedBox(
                                                                    height: 20,
                                                                  ),
                                                                  Column(
                                                                    children: [
                                                                      data.docs[i]['status'] ==
                                                                              'Pending'
                                                                          ? const SizedBox()
                                                                          : ButtonWidget(
                                                                              color: buttonColor,
                                                                              width: 100,
                                                                              height: 40,
                                                                              radius: 5,
                                                                              label: 'Pending',
                                                                              onPressed: () async {
                                                                                await FirebaseFirestore.instance.collection('Reports').doc(data.docs[i].id).update({
                                                                                  'status': 'Pending'
                                                                                });
                                                                                Navigator.pop(context);
                                                                              },
                                                                            ),
                                                                      const SizedBox(
                                                                        height:
                                                                            10,
                                                                      ),
                                                                      data.docs[i]['status'] ==
                                                                              'Ongoing'
                                                                          ? const SizedBox()
                                                                          : ButtonWidget(
                                                                              color: buttonColor,
                                                                              width: 100,
                                                                              height: 40,
                                                                              radius: 5,
                                                                              label: 'Ongoing',
                                                                              onPressed: () async {
                                                                                await FirebaseFirestore.instance.collection('Reports').doc(data.docs[i].id).update({
                                                                                  'status': 'Ongoing'
                                                                                });
                                                                                Navigator.pop(context);
                                                                              },
                                                                            ),
                                                                      const SizedBox(
                                                                        height:
                                                                            10,
                                                                      ),
                                                                      data.docs[i]['status'] ==
                                                                              'Resolved'
                                                                          ? const SizedBox()
                                                                          : ButtonWidget(
                                                                              color: buttonColor,
                                                                              width: 100,
                                                                              height: 40,
                                                                              radius: 5,
                                                                              label: 'Resolved',
                                                                              onPressed: () async {
                                                                                await FirebaseFirestore.instance.collection('Reports').doc(data.docs[i].id).update({
                                                                                  'status': 'Resolved'
                                                                                });
                                                                                Navigator.pop(context);
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
                                                ),
                                                // GestureDetector(
                                                //   onTap: () {
                                                //     showDialog(
                                                //       context: context,
                                                //       builder: (context) {
                                                //         return Dialog(
                                                //           backgroundColor:
                                                //               primary,
                                                //           child: SizedBox(
                                                //             height: 125,
                                                //             child: Padding(
                                                //               padding:
                                                //                   const EdgeInsets
                                                //                       .all(
                                                //                       10.0),
                                                //               child: Column(
                                                //                 children: [
                                                //                   TextWidget(
                                                //                     text:
                                                //                         'Are you sure you want to delete this report?',
                                                //                     fontSize:
                                                //                         14,
                                                //                     fontFamily:
                                                //                         'Bold',
                                                //                     color: Colors
                                                //                         .black,
                                                //                   ),
                                                //                   const SizedBox(
                                                //                     height: 20,
                                                //                   ),
                                                //                   Row(
                                                //                     mainAxisAlignment:
                                                //                         MainAxisAlignment
                                                //                             .spaceEvenly,
                                                //                     children: [
                                                //                       ButtonWidget(
                                                //                         color:
                                                //                             buttonColor,
                                                //                         width:
                                                //                             100,
                                                //                         height:
                                                //                             40,
                                                //                         radius:
                                                //                             5,
                                                //                         label:
                                                //                             'Ok',
                                                //                         onPressed:
                                                //                             () async {
                                                //                           await FirebaseFirestore
                                                //                               .instance
                                                //                               .doc(data.docs[i].id)
                                                //                               .delete();
                                                //                           Navigator.pop(
                                                //                               context);
                                                //                         },
                                                //                       ),
                                                //                       ButtonWidget(
                                                //                         color:
                                                //                             buttonColor,
                                                //                         width:
                                                //                             100,
                                                //                         height:
                                                //                             40,
                                                //                         radius:
                                                //                             5,
                                                //                         label:
                                                //                             'Cancel',
                                                //                         onPressed:
                                                //                             () {
                                                //                           Navigator.pop(
                                                //                               context);
                                                //                         },
                                                //                       ),
                                                //                     ],
                                                //                   ),
                                                //                 ],
                                                //               ),
                                                //             ),
                                                //           ),
                                                //         );
                                                //       },
                                                //     );
                                                //   },
                                                //   child: const Icon(
                                                //     Icons.delete,
                                                //   ),
                                                // ),
                                              ],
                                            ),
                                          ),
                                        ])
                                    ]);
                              }),
                        ),
                      )),
                ),
                const SizedBox(
                  height: 50,
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

  showpersondetail(context, String id) {
    final Stream<DocumentSnapshot> userData =
        FirebaseFirestore.instance.collection('Users').doc(id).snapshots();
    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          child: StreamBuilder<DocumentSnapshot>(
              stream: userData,
              builder: (context, AsyncSnapshot<DocumentSnapshot> snapshot) {
                if (!snapshot.hasData) {
                  return const SizedBox();
                } else if (snapshot.hasError) {
                  return const Center(child: Text('Something went wrong'));
                } else if (snapshot.connectionState ==
                    ConnectionState.waiting) {
                  return const SizedBox();
                }
                dynamic data = snapshot.data;
                return SizedBox(
                  height: 300,
                  width: 300,
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TextWidget(
                          text: "RESIDENT'S DETAILS",
                          fontSize: 18,
                          color: Colors.black,
                          fontFamily: 'Bold',
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        CircleAvatar(
                          minRadius: 35,
                          maxRadius: 35,
                          backgroundImage: NetworkImage(data['profilePicture']),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        TextWidget(
                          text: 'Name: ${data['fname']}  ${data['lname']}',
                          fontSize: 14,
                          fontFamily: 'Medium',
                          color: Colors.black,
                        ),
                        // const SizedBox(
                        //   height: 5,
                        // ),
                        // TextWidget(
                        //   text: 'Birthday: ${data['bday'] ?? ''}',
                        //   fontSize: 14,
                        //   fontFamily: 'Medium',
                        //   color: Colors.black,
                        // ),
                        const SizedBox(
                          height: 5,
                        ),
                        TextWidget(
                          text: 'Gender: ${data['gender']}',
                          fontSize: 14,
                          fontFamily: 'Medium',
                          color: Colors.black,
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        TextWidget(
                          text: 'Address: ${data['address']}',
                          fontSize: 14,
                          fontFamily: 'Medium',
                          color: Colors.black,
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        TextWidget(
                          text: 'Contact Number: ${data['mobilenumber']}',
                          fontSize: 14,
                          fontFamily: 'Medium',
                          color: Colors.black,
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        TextWidget(
                          text: 'Bloodtype: ${data['bloodtype']}',
                          fontSize: 14,
                          fontFamily: 'Medium',
                          color: Colors.black,
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        TextWidget(
                          text: 'Email: ${data['email']}',
                          fontSize: 14,
                          fontFamily: 'Medium',
                          color: Colors.black,
                        ),
                      ],
                    ),
                  ),
                );
              }),
        );
      },
    );
  }

  showreportdetails(context, data) {
    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          child: SizedBox(
            height: 400,
            width: 300,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextWidget(
                      text: 'Reporter: ${data['reporter']}',
                      fontSize: 14,
                      fontFamily: 'Medium',
                      color: Colors.black,
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    TextWidget(
                      text: 'Report: ${data['categ']}',
                      fontSize: 14,
                      fontFamily: 'Medium',
                      color: Colors.black,
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    TextWidget(
                      text:
                          'Date and Time: ${DateFormat.yMMMd().add_jm().format(data['dateTime'].toDate())}',
                      fontSize: 14,
                      fontFamily: 'Medium',
                      color: Colors.black,
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    TextWidget(
                      text: 'Details: ${data['desc']}',
                      fontSize: 14,
                      fontFamily: 'Medium',
                      color: Colors.black,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Container(
                      width: 250,
                      height: 250,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: NetworkImage(
                            data['img'],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
