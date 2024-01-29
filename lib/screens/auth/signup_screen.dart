import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gusa_cic/screens/auth/login_screen.dart';
import 'package:gusa_cic/screens/home_screen.dart';
import 'package:gusa_cic/services/add_user.dart';
import 'package:gusa_cic/utils/colors.dart';
import 'package:gusa_cic/widgets/button_widget.dart';
import 'package:gusa_cic/widgets/text_widget.dart';
import 'package:gusa_cic/widgets/textfield_widget.dart';
import 'package:gusa_cic/widgets/toast_widget.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:intl/intl.dart';
import 'package:path/path.dart' as path;
import 'package:image_picker/image_picker.dart';
import 'package:flutter/foundation.dart';
import 'dart:io';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<SignupScreen> {
  String selectedBloodType = 'O+'; // Variable to store the selected blood type

  // List of blood types
  List<String> bloodTypes = [
    'O+',
    'O-',
    'A+',
    'A-',
    'B+',
    'B-',
    'AB+',
    'AB-',
    'Unknown',
  ];

  List<String> genders = [
    'Male',
    'Female',
    'Other',
  ];

  String selectedGender = 'Male';
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
            .ref('Users/$fileName')
            .putFile(imageFile);
        imageURL = await firebase_storage.FirebaseStorage.instance
            .ref('Users/$fileName')
            .getDownloadURL();

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

  final firstnameController = TextEditingController();
  final middlenameController = TextEditingController();
  final lastnameController = TextEditingController();
  final houseController = TextEditingController();
  final streetController = TextEditingController();
  final purokController = TextEditingController();
  final phonenumberController = TextEditingController();
  final bloodtypeController = TextEditingController();
  final genderController = TextEditingController();

  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmpasswordController = TextEditingController();

  var dateController = TextEditingController();
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
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 20, 20, 20),
                child: Card(
                  child: Container(
                    height: 700,
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
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            TextWidget(
                              text: 'Signup',
                              fontSize: 24,
                              fontFamily: 'Bold',
                              color: Colors.white,
                            ),
                            TextWidget(
                              text: 'Create your first account',
                              fontSize: 12,
                              fontFamily: 'Regular',
                              color: Colors.white,
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            imageURL == ''
                                ? GestureDetector(
                                    onTap: () {
                                      uploadPicture('camera');
                                    },
                                    child: const Icon(
                                      Icons.account_circle,
                                      size: 75,
                                    ),
                                  )
                                : CircleAvatar(
                                    maxRadius: 50,
                                    minRadius: 50,
                                    backgroundImage: NetworkImage(imageURL),
                                  ),
                            const SizedBox(
                              height: 10,
                            ),
                            TextFieldWidget(
                              prefixIcon: Icons.person,
                              controller: firstnameController,
                              label: 'First Name',
                            ),
                            TextFieldWidget(
                              prefixIcon: Icons.person,
                              controller: middlenameController,
                              label: 'Middle Name',
                            ),
                            TextFieldWidget(
                              prefixIcon: Icons.person,
                              controller: lastnameController,
                              label: 'Last Name',
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            const Text(
                              'Select Gender:',
                              style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
                            ),
                            const SizedBox(
                              height: 5,
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
                                      selectedGender = newValue.toString();
                                    });
                                  },
                                  underline: const SizedBox(),
                                  value: selectedGender,
                                  items: genders.map((String item) {
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
                            TextFieldWidget(
                              inputType: TextInputType.number,
                              prefixIcon: Icons.phone,
                              controller: phonenumberController,
                              label: 'Mobile number',
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            TextFieldWidget(
                              isRequred: false,
                              prefixIcon: Icons.location_on,
                              controller: houseController,
                              label: 'Home Number',
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            TextFieldWidget(
                              prefixIcon: Icons.location_on,
                              controller: streetController,
                              label: 'Street Name',
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            TextFieldWidget(
                              prefixIcon: Icons.location_on,
                              controller: purokController,
                              label: 'Purok',
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Center(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  RichText(
                                    text: const TextSpan(
                                      children: [
                                        TextSpan(
                                          text: 'Birthday',
                                          style: TextStyle(
                                            fontSize: 14,
                                            fontFamily: 'Bold',
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        TextSpan(
                                          text: '*',
                                          style: TextStyle(
                                            fontSize: 14,
                                            fontFamily: 'Bold',
                                            color: Colors.red,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      dateFromPicker(context);
                                    },
                                    child: SizedBox(
                                      width: 325,
                                      height: 50,
                                      child: TextFormField(
                                        enabled: false,
                                        style: TextStyle(
                                          fontFamily: 'Regular',
                                          fontSize: 14,
                                          color: primary,
                                        ),

                                        decoration: InputDecoration(
                                          fillColor: Colors.white,
                                          filled: true,
                                          prefixIcon: const Icon(
                                            Icons.calendar_month_outlined,
                                            color: Colors.grey,
                                          ),
                                          hintStyle: const TextStyle(
                                            fontFamily: 'Regular',
                                            fontSize: 14,
                                            color: Colors.grey,
                                          ),
                                          hintText: dateController.text,
                                          border: InputBorder.none,
                                          disabledBorder: OutlineInputBorder(
                                            borderSide: const BorderSide(
                                              color: Colors.grey,
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(5),
                                          ),
                                          enabledBorder: OutlineInputBorder(
                                            borderSide: const BorderSide(
                                              color: Colors.grey,
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(5),
                                          ),
                                          focusedBorder: OutlineInputBorder(
                                            borderSide: const BorderSide(
                                              color: Colors.grey,
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(5),
                                          ),
                                          errorBorder: OutlineInputBorder(
                                            borderSide: const BorderSide(
                                              color: Colors.red,
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(5),
                                          ),
                                          errorStyle: const TextStyle(
                                              fontFamily: 'Bold', fontSize: 12),
                                          focusedErrorBorder:
                                              OutlineInputBorder(
                                            borderSide: const BorderSide(
                                              color: Colors.red,
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(5),
                                          ),
                                        ),

                                        controller: dateController,
                                        // Pass the validator to the TextFormField
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            const Text(
                              'Blood Type:',
                              style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
                            ),
                            const SizedBox(
                              height: 10,
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
                                      selectedBloodType = newValue.toString();
                                    });
                                  },
                                  underline: const SizedBox(),
                                  value: selectedBloodType,
                                  items: bloodTypes.map((String item) {
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
                            TextFieldWidget(
                              prefixIcon: Icons.email,
                              controller: emailController,
                              label: 'Email',
                            ),
                            TextFieldWidget(
                              isObscure: true,
                              showEye: true,
                              prefixIcon: Icons.lock,
                              controller: passwordController,
                              label: 'Password',
                            ),
                            TextFieldWidget(
                              isObscure: true,
                              showEye: true,
                              prefixIcon: Icons.lock,
                              controller: confirmpasswordController,
                              label: 'Confirm password',
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            ButtonWidget(
                              radius: 20,
                              width: 250,
                              color: buttonColor,
                              label: 'Signup',
                              onPressed: () {
                                if (confirmpasswordController.text ==
                                    passwordController.text) {
                                  register(context);
                                } else {
                                  showToast('Password do not match!');
                                }
                              },
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                TextWidget(
                                  text: 'Already have an account?',
                                  fontSize: 12,
                                  color: Colors.white,
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                GestureDetector(
                                  onTap: () {
                                    Navigator.of(context).pushReplacement(
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                const LoginScreen()));
                                  },
                                  child: TextWidget(
                                    text: 'Login',
                                    fontSize: 14,
                                    color: Colors.white,
                                    fontFamily: 'Bold',
                                  ),
                                )
                              ],
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void dateFromPicker(BuildContext context) async {
    DateTime? pickedDate = await showDatePicker(
        builder: (context, child) {
          return Theme(
            data: Theme.of(context).copyWith(
              colorScheme: ColorScheme.light(
                primary: primary,
                onPrimary: Colors.white,
                onSurface: Colors.grey,
              ),
            ),
            child: child!,
          );
        },
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(1900),
        lastDate: DateTime.now());

    if (pickedDate != null) {
      String formattedDate = DateFormat('yyyy-MM-dd').format(pickedDate);

      setState(() {
        dateController.text = formattedDate;
      });
    } else {
      return null;
    }
  }

  register(context) async {
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: emailController.text, password: passwordController.text);

      addUser(
          firstnameController.text,
          middlenameController.text,
          lastnameController.text,
          selectedGender,
          phonenumberController.text,
          '${houseController.text}, ${streetController.text}, ${purokController.text}, ',
          selectedBloodType,
          emailController.text,
          passwordController.text,
          imageURL,
          dateController.text);

      await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: emailController.text, password: passwordController.text);

      showToast('Account created succesfully!');
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => const HomeScreen()));
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        showToast('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        showToast('The account already exists for that email.');
      } else if (e.code == 'invalid-email') {
        showToast('The email address is not valid.');
      } else {
        showToast(e.toString());
      }
    } on Exception catch (e) {
      showToast("An error occurred: $e");
    }
  }
}
