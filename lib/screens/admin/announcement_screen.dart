import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:gusa_cic/screens/admin/adminhome_screen.dart';
import 'package:gusa_cic/utils/colors.dart';
import 'package:gusa_cic/widgets/button_widget.dart';
import 'package:gusa_cic/widgets/text_widget.dart';
import 'package:gusa_cic/widgets/textfield_widget.dart';
import 'package:gusa_cic/widgets/toast_widget.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as path;
import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

class AnnouncementScreen extends StatefulWidget {
  String? type;

  AnnouncementScreen({super.key, this.type});

  @override
  State<AnnouncementScreen> createState() => _AnnouncementScreenState();
}

class _AnnouncementScreenState extends State<AnnouncementScreen> {
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
                    height: 375,
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
                            text: 'Make Announcements',
                            fontSize: 24,
                            color: Colors.black,
                          ),
                          const SizedBox(
                            height: 20,
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
                            label: 'Type an announcement...',
                            maxLine: 8,
                            height: 200,
                            controller: descController,
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
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(),
                    const Expanded(child: SizedBox()),
                    ButtonWidget(
                        radius: 15,
                        width: 150,
                        height: 40,
                        color: buttonColor,
                        textColor: Colors.black,
                        label: 'Add',
                        onPressed: () async {
                          await FirebaseFirestore.instance
                              .collection('Announcements')
                              .doc('SeHMRpK0GktE0iM3dPGD')
                              .update({
                            'desc': descController.text,
                            'img': imageURL
                          });

                          // addAnnoucements(descController.text, imageURL);
                          showToast('Annoucement updated succesfully!');
                          Navigator.of(context).pushReplacement(
                              MaterialPageRoute(
                                  builder: (context) =>
                                      const AdminHomeScreen()));
                        }),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
