import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:gusa_cic/widgets/text_widget.dart';

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
                padding: const EdgeInsets.fromLTRB(30, 0, 20, 0),
                child: TextWidget(
                  text: 'Residents',
                  fontSize: 24,
                  color: Colors.white,
                  fontFamily: 'Bold',
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                child: Container(
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Card(
                      child: SizedBox(
                          height: 500,
                          child: SingleChildScrollView(
                            child: SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: StreamBuilder<QuerySnapshot>(
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
                                    return DataTable(
                                        headingRowColor:
                                            MaterialStateProperty.all(
                                                Colors.blue[300]),
                                        border:
                                            TableBorder.all(color: Colors.grey),
                                        columns: [
                                          DataColumn(
                                            label: TextWidget(
                                              text: '',
                                              fontSize: 13,
                                              fontFamily: 'Bold',
                                            ),
                                          ),
                                          DataColumn(
                                            label: TextWidget(
                                                text: 'Name',
                                                fontSize: 13,
                                                fontFamily: 'Bold'),
                                          ),
                                          DataColumn(
                                            label: TextWidget(
                                                text: 'Details',
                                                fontSize: 13,
                                                fontFamily: 'Bold'),
                                          ),
                                        ],
                                        rows: [
                                          for (int i = 0;
                                              i < data.docs.length;
                                              i++)
                                            DataRow(cells: [
                                              DataCell(
                                                TextWidget(
                                                  text: '${i + 1}',
                                                  fontSize: 11,
                                                ),
                                              ),
                                              DataCell(
                                                TextWidget(
                                                  text: data.docs[i]['fname'] +
                                                      ' ' +
                                                      data.docs[i]['lname'],
                                                  fontSize: 11,
                                                ),
                                              ),
                                              DataCell(
                                                GestureDetector(
                                                  onTap: () {
                                                    showpersondetail(context,
                                                        data.docs[i].id);
                                                  },
                                                  child: TextWidget(
                                                    text: 'View Details',
                                                    fontSize: 11,
                                                  ),
                                                ),
                                              ),
                                            ])
                                        ]);
                                  }),
                            ),
                          )),
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
}
