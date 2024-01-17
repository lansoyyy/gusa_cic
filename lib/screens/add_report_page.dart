import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:gusa_cic/screens/home_screen.dart';
import 'package:gusa_cic/services/add_report.dart';
import 'package:gusa_cic/utils/colors.dart';
import 'package:gusa_cic/widgets/button_widget.dart';
import 'package:gusa_cic/widgets/text_widget.dart';
import 'package:gusa_cic/widgets/textfield_widget.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:gusa_cic/widgets/toast_widget.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as path;
import 'dart:io';

class AddreportScreen extends StatefulWidget {
  String type;

  AddreportScreen({super.key, required this.type});

  @override
  State<AddreportScreen> createState() => _AddreportScreenState();
}

class _AddreportScreenState extends State<AddreportScreen> {
  List<String> type2 = [
    'Complaint',
    'Incident',
    'Concern',
  ];
  String selected1 = 'Complaint';

  final descController = TextEditingController();

  late String fileName = '';

  late File imageFile;

  late String imageURL = '';

  Future<void> uploadPicture(String inputSource) async {
    final picker = ImagePicker();
    XFile pickedImage;
    try {
      pickedImage = (await picker.pickImage(
          source: inputSource == 'camera'
              ? ImageSource.camera
              : ImageSource.gallery,
          maxWidth: 1920))!;

      fileName = path.basename(pickedImage.path);
      imageFile = File(pickedImage.path);

      try {
        showDialog(
          context: context,
          barrierDismissible: false,
          builder: (BuildContext context) => const Padding(
            padding: EdgeInsets.only(left: 30, right: 30),
            child: AlertDialog(
                title: Row(
              children: [
                CircularProgressIndicator(
                  color: Colors.black,
                ),
                SizedBox(
                  width: 20,
                ),
                Text(
                  'Loading . . .',
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'QRegular'),
                ),
              ],
            )),
          ),
        );

        await firebase_storage.FirebaseStorage.instance
            .ref('Evidences/$fileName')
            .putFile(imageFile);
        imageURL = await firebase_storage.FirebaseStorage.instance
            .ref('Evidences/$fileName')
            .getDownloadURL();

        showToast('Image uploaded!');

        setState(() {});

        Navigator.of(context).pop();
      } on firebase_storage.FirebaseException catch (error) {
        if (kDebugMode) {
          print(error);
        }
      }
    } catch (err) {
      if (kDebugMode) {
        print(err);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final Stream<DocumentSnapshot> userData = FirebaseFirestore.instance
        .collection('Users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .snapshots();
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
                  const Row(
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
                  const SizedBox(
                    height: 20,
                  ),
                  Card(
                    child: Container(
                      width: double.infinity,
                      height: 520,
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
                          children: [
                            TextWidget(
                              text: 'Submit a Report',
                              fontSize: 18,
                              fontFamily: 'Bold',
                            ),
                            const SizedBox(
                              height: 20,
                            ),
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
                                      selected1 = newValue.toString();
                                    });
                                  },
                                  underline: const SizedBox(),
                                  value: selected1,
                                  items: type2.map((String item) {
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
                                  }).toList(),
                                )),
                            const SizedBox(
                              height: 10,
                            ),
                            imageURL != ''
                                ? Container(
                                    width: 250,
                                    height: 100,
                                    decoration: BoxDecoration(
                                        image: DecorationImage(
                                            image: NetworkImage(imageURL))),
                                  )
                                : const SizedBox(),
                            const SizedBox(
                              height: 10,
                            ),
                            ButtonWidget(
                              color: Colors.white,
                              width: 100,
                              height: 35,
                              fontSize: 12,
                              textColor: Colors.black,
                              label: 'Upload a photo',
                              onPressed: () {
                                uploadPicture('gallery');
                              },
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            TextFieldWidget(
                              label: 'I-type ang mga delalye dinhi...',
                              maxLine: 8,
                              height: 200,
                              controller: descController,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  StreamBuilder<DocumentSnapshot>(
                      stream: userData,
                      builder:
                          (context, AsyncSnapshot<DocumentSnapshot> snapshot) {
                        if (!snapshot.hasData) {
                          return const SizedBox();
                        } else if (snapshot.hasError) {
                          return const Center(
                              child: Text('Something went wrong'));
                        } else if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const SizedBox();
                        }
                        dynamic data = snapshot.data;
                        return Align(
                          alignment: Alignment.topRight,
                          child: ButtonWidget(
                              radius: 15,
                              width: 150,
                              height: 40,
                              color: buttonColor,
                              textColor: Colors.black,
                              label: 'Send',
                              onPressed: () {
                                addReport(
                                    '${data['lname']}, ${data['fname']} ${data['mname'][0]}.',
                                    '',
                                    imageURL,
                                    descController.text,
                                    selected1);
                                showToast('Report submitted succesfully!');
                                Navigator.of(context).pushReplacement(
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const HomeScreen()));
                              }),
                        );
                      }),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
