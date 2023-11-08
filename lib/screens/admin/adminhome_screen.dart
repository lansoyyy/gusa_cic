import 'package:flutter/material.dart';
import 'package:gusa_cic/screens/add_report_page.dart';
import 'package:gusa_cic/screens/admin/admin_reports_screen.dart';
import 'package:gusa_cic/screens/admin/announcement_screen.dart';
import 'package:gusa_cic/screens/admin/residents_screen.dart';
import 'package:gusa_cic/utils/colors.dart';
import 'package:gusa_cic/widgets/text_widget.dart';

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
                    text: 'January 01, 2023',
                    fontSize: 16,
                    color: Colors.white,
                    fontFamily: 'Bold',
                  ),
                ],
              ),
              const Divider(
                color: Colors.white,
              ),
              const SizedBox(
                height: 50,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  for (int i = 0; i < 2; i++)
                    Padding(
                      padding: const EdgeInsets.only(left: 5, right: 5),
                      child: GestureDetector(
                        onTap: () {
                          if (i == 0) {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => AnnouncementScreen(
                                      type: i == 0
                                          ? 'Announcements'
                                          : i == 1
                                              ? 'Residents'
                                              : 'Concern',
                                    )));
                          } else {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => ResidentsScreen(
                                      type: i == 0
                                          ? 'Announcements'
                                          : i == 1
                                              ? 'Residents'
                                              : 'Concern',
                                    )));
                          }
                        },
                        child: Container(
                          height: 175,
                          width: 100,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.only(left: 10, right: 10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const SizedBox(
                                  height: 10,
                                ),
                                Center(
                                  child: Container(
                                    height: 90,
                                    width: 75,
                                    decoration: BoxDecoration(
                                      color: buttonColor,
                                      borderRadius: BorderRadius.circular(5),
                                    ),
                                    child: Center(
                                      child: Icon(
                                        i == 0
                                            ? Icons.announcement
                                            : i == 1
                                                ? Icons.group
                                                : Icons.diversity_1,
                                        color: Colors.black,
                                        size: 48,
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                TextWidget(
                                  text: i == 0
                                      ? 'Announcements'
                                      : i == 1
                                          ? 'Residents'
                                          : 'Concern',
                                  fontSize: 12,
                                  color: Colors.black,
                                ),
                                TextWidget(
                                  text: '1',
                                  fontSize: 12,
                                  color: Colors.black,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  for (int i = 0; i < 3; i++)
                    Padding(
                      padding: const EdgeInsets.only(left: 5, right: 5),
                      child: GestureDetector(
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => AdminReportsScreen(
                                    type: i == 0
                                        ? 'Compliants'
                                        : i == 1
                                            ? 'Incident'
                                            : 'Concern',
                                  )));
                        },
                        child: Container(
                          height: 175,
                          width: 100,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.only(left: 10, right: 10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const SizedBox(
                                  height: 10,
                                ),
                                Center(
                                  child: Container(
                                    height: 90,
                                    width: 75,
                                    decoration: BoxDecoration(
                                      color: buttonColor,
                                      borderRadius: BorderRadius.circular(5),
                                    ),
                                    child: Center(
                                      child: Icon(
                                        i == 0
                                            ? Icons.report
                                            : i == 1
                                                ? Icons.list
                                                : Icons.diversity_1,
                                        color: Colors.black,
                                        size: 48,
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                TextWidget(
                                  text: i == 0
                                      ? 'Compliants'
                                      : i == 1
                                          ? 'Incident'
                                          : 'Concern',
                                  fontSize: 12,
                                  color: Colors.black,
                                ),
                                TextWidget(
                                  text: '1',
                                  fontSize: 12,
                                  color: Colors.black,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
