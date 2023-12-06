import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:gusa_cic/screens/profile_screen.dart';
import 'package:gusa_cic/screens/settings_screen.dart';
import 'package:gusa_cic/widgets/text_widget.dart';
import 'package:intl/intl.dart';

import 'add_report_page.dart';
import 'auth/login_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
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
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => const ProfileScreen()));
                    },
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Icon(
                          Icons.account_circle,
                          color: Colors.white,
                          size: 48,
                        ),
                        SizedBox(
                          width: 20,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Container(
                    width: double.infinity,
                    height: 100,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.black26,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 5, right: 5),
                      child: Center(
                        child: TextWidget(
                          text:
                              'Welcome to the Baranagay Gusa Report System: where incidents, complaints, and concerns find their voice! Together, lets build a safer and stronger community.',
                          fontSize: 12,
                          color: Colors.white,
                          fontFamily: 'Medium',
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextWidget(
                    text: 'Good Day!',
                    fontSize: 18,
                    fontFamily: 'Bold',
                    color: Colors.white,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TextWidget(
                        text: 'Announcements',
                        fontSize: 12,
                        color: Colors.white,
                        fontFamily: 'Bold',
                      ),
                      TextWidget(
                        text: DateFormat.yMMMd().format(DateTime.now()),
                        fontSize: 12,
                        color: Colors.white,
                        fontFamily: 'Medium',
                      ),
                    ],
                  ),
                  const Divider(
                    color: Colors.black,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  StreamBuilder<QuerySnapshot>(
                      stream: FirebaseFirestore.instance
                          .collection('Announcements')
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
                        return Column(
                          children: [
                            for (int i = 0; i < data.docs.length; i++)
                              TextWidget(
                                text: '- ${data.docs[i]['desc']}',
                                fontSize: 12,
                                color: Colors.black,
                                fontFamily: 'Medium',
                              ),
                          ],
                        );
                      }),
                  const SizedBox(
                    height: 300,
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
                                    builder: (context) =>
                                        const SettingsScreen()));
                              },
                              icon: const Icon(
                                Icons.settings,
                                size: 45,
                              ),
                            ),
                            IconButton(
                              onPressed: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => AddreportScreen(
                                          type: 'Concern',
                                        )));
                              },
                              icon: const Icon(
                                Icons.edit_document,
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
                                            style: TextStyle(
                                                fontFamily: 'Regular'),
                                          ),
                                          actions: <Widget>[
                                            MaterialButton(
                                              onPressed: () =>
                                                  Navigator.of(context)
                                                      .pop(true),
                                              child: const Text(
                                                'Close',
                                                style: TextStyle(
                                                    fontFamily: 'Regular',
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ),
                                            MaterialButton(
                                              onPressed: () async {
                                                // await FirebaseAuth.instance.signOut();
                                                Navigator.of(context)
                                                    .pushReplacement(
                                                        MaterialPageRoute(
                                                            builder: (context) =>
                                                                const LoginScreen()));
                                              },
                                              child: const Text(
                                                'Continue',
                                                style: TextStyle(
                                                    fontFamily: 'Regular',
                                                    fontWeight:
                                                        FontWeight.bold),
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
                  // Container(
                  //   width: double.infinity,
                  //   height: 250,
                  //   decoration: BoxDecoration(
                  //     borderRadius: BorderRadius.circular(10),
                  //     color: Colors.black26,
                  //   ),
                  //   child: Padding(
                  //     padding: const EdgeInsets.all(20.0),
                  //     child: Column(
                  //       children: [
                  //         Row(
                  //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //           children: [
                  //             ButtonWidget(
                  //               radius: 0,
                  //               color: buttonColor,
                  //               width: 100,
                  //               fontSize: 14,
                  //               height: 40,
                  //               label: 'Select a report',
                  //               onPressed: () {},
                  //             ),
                  //             TextButton(
                  //               onPressed: () {
                  //                 Navigator.of(context).push(MaterialPageRoute(
                  //                     builder: (context) =>
                  //                         const MyreportsScreen()));
                  //               },
                  //               child: TextWidget(
                  //                 text: 'My reports',
                  //                 fontSize: 14,
                  //                 color: Colors.white,
                  //                 fontFamily: 'Medium',
                  //               ),
                  //             ),
                  //           ],
                  //         ),
                  //         const SizedBox(
                  //           height: 10,
                  //         ),
                  //         Row(
                  //           mainAxisAlignment: MainAxisAlignment.start,
                  //           children: [
                  //             for (int i = 0; i < 3; i++)
                  //               Padding(
                  //                 padding:
                  //                     const EdgeInsets.only(left: 5, right: 5),
                  //                 child: GestureDetector(
                  //                   onTap: () {
                  //                     Navigator.of(context).push(
                  //                         MaterialPageRoute(
                  //                             builder: (context) =>
                  //                                 AddreportScreen(
                  //                                   type: i == 0
                  //                                       ? 'Compliants'
                  //                                       : i == 1
                  //                                           ? 'Incident'
                  //                                           : 'Concern',
                  //                                 )));
                  //                   },
                  //                   child: Container(
                  //                     height: 150,
                  //                     width: 85,
                  //                     decoration: BoxDecoration(
                  //                       color: Colors.white,
                  //                       borderRadius: BorderRadius.circular(10),
                  //                     ),
                  //                     child: Padding(
                  //                       padding: const EdgeInsets.only(
                  //                           left: 10, right: 10),
                  //                       child: Column(
                  //                         crossAxisAlignment:
                  //                             CrossAxisAlignment.start,
                  //                         children: [
                  //                           const SizedBox(
                  //                             height: 10,
                  //                           ),
                  //                           Center(
                  //                             child: Container(
                  //                               height: 90,
                  //                               width: 75,
                  //                               decoration: BoxDecoration(
                  //                                 color: buttonColor,
                  //                                 borderRadius:
                  //                                     BorderRadius.circular(5),
                  //                               ),
                  //                               child: Center(
                  //                                 child: Icon(
                  //                                   i == 0
                  //                                       ? Icons.report
                  //                                       : i == 1
                  //                                           ? Icons.list
                  //                                           : Icons.diversity_1,
                  //                                   color: Colors.black,
                  //                                   size: 48,
                  //                                 ),
                  //                               ),
                  //                             ),
                  //                           ),
                  //                           const SizedBox(
                  //                             height: 5,
                  //                           ),
                  //                           TextWidget(
                  //                             text: i == 0
                  //                                 ? 'Compliants'
                  //                                 : i == 1
                  //                                     ? 'Incident'
                  //                                     : 'Concern',
                  //                             fontSize: 12,
                  //                             color: Colors.black,
                  //                           ),
                  //                           TextWidget(
                  //                             text: '1',
                  //                             fontSize: 12,
                  //                             color: Colors.black,
                  //                           ),
                  //                         ],
                  //                       ),
                  //                     ),
                  //                   ),
                  //                 ),
                  //               ),
                  //           ],
                  //         ),
                  //       ],
                  //     ),
                  //   ),
                  // ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
