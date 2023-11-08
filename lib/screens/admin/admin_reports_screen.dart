import 'package:flutter/material.dart';
import 'package:gusa_cic/screens/add_report_page.dart';
import 'package:gusa_cic/utils/colors.dart';
import 'package:gusa_cic/widgets/button_widget.dart';
import 'package:gusa_cic/widgets/text_widget.dart';
import 'package:gusa_cic/widgets/textfield_widget.dart';

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
                              child: DataTable(columns: [
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
                                for (int i = 0; i < 50; i++)
                                  DataRow(cells: [
                                    DataCell(
                                      TextWidget(
                                        text: '${i + 1}',
                                        fontSize: 11,
                                      ),
                                    ),
                                    DataCell(
                                      TextWidget(
                                        text: 'Sample',
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
                                                    CrossAxisAlignment.start,
                                                mainAxisSize: MainAxisSize.min,
                                                children: [
                                                  TextWidget(
                                                    text: 'Reporter: John Doe',
                                                    fontSize: 18,
                                                  ),
                                                  TextWidget(
                                                    text: 'Type: Noise',
                                                    fontSize: 14,
                                                  ),
                                                  TextWidget(
                                                    text:
                                                        'Description: Lorem Ipsum',
                                                    fontSize: 14,
                                                  ),
                                                  TextWidget(
                                                    text:
                                                        'Date and Time: January 01, 2001',
                                                    fontSize: 14,
                                                  ),
                                                  const SizedBox(
                                                    height: 10,
                                                  ),
                                                  Container(
                                                    width: double.infinity,
                                                    height: 250,
                                                    color: Colors.black,
                                                  ),
                                                ],
                                              ),
                                              actions: [
                                                TextButton(
                                                  onPressed: () {
                                                    Navigator.pop(context);
                                                  },
                                                  child: TextWidget(
                                                    text: 'Close',
                                                    fontSize: 14,
                                                  ),
                                                ),
                                                TextButton(
                                                  onPressed: () {
                                                    Navigator.pop(context);
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
                                        text: 'View ${widget.type} detail',
                                        fontSize: 11,
                                      ),
                                    )),
                                  ])
                              ]),
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
