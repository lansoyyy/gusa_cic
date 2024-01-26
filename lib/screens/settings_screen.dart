import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gusa_cic/widgets/text_widget.dart';
import 'package:gusa_cic/widgets/toast_widget.dart';

import '../utils/colors.dart';
import '../widgets/button_widget.dart';
import '../widgets/textfield_widget.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool isChecked1 = false;
  bool isChecked2 = false;
  bool isChecked3 = false;

  final currentPassword = TextEditingController();

  final newPassword = TextEditingController();

  final newConfirmPassword = TextEditingController();

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
          padding: const EdgeInsets.fromLTRB(30, 20, 50, 20),
          child: SafeArea(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: const Icon(
                        Icons.arrow_back,
                        color: Colors.white,
                      ),
                    ),
                    TextWidget(
                      text: 'Change Password',
                      fontSize: 18,
                      fontFamily: 'Bold',
                      color: Colors.white,
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                TextFieldWidget(
                  isObscure: true,
                  showEye: true,
                  prefixIcon: Icons.lock,
                  controller: currentPassword,
                  label: 'Old Password',
                ),
                const SizedBox(
                  height: 20,
                ),
                TextFieldWidget(
                  isObscure: true,
                  showEye: true,
                  prefixIcon: Icons.lock,
                  controller: newPassword,
                  label: 'New Password',
                ),
                const SizedBox(
                  height: 20,
                ),
                TextFieldWidget(
                  isObscure: true,
                  showEye: true,
                  prefixIcon: Icons.lock,
                  controller: newConfirmPassword,
                  label: 'Confirm password',
                ),
                const SizedBox(
                  height: 50,
                ),
                Center(
                  child: ButtonWidget(
                    radius: 20,
                    width: 250,
                    color: buttonColor,
                    label: 'Change Password',
                    onPressed: () {
                      if (newConfirmPassword.text == newPassword.text) {
                        changePassword(
                            currentPassword.text, newPassword.text, context);
                      } else {
                        showToast('Password do not match!');
                      }
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  static Future<String?> changePassword(
      String oldPassword, String newPassword, context) async {
    User user = FirebaseAuth.instance.currentUser!;
    AuthCredential credential =
        EmailAuthProvider.credential(email: user.email!, password: oldPassword);

    Map<String, String?> codeResponses = {
      // Re-auth responses
      "user-mismatch": null,
      "user-not-found": null,
      "invalid-credential": null,
      "invalid-email": null,
      "wrong-password": null,
      "invalid-verification-code": null,
      "invalid-verification-id": null,
      // Update password error codes
      "weak-password": null,
      "requires-recent-login": null
    };

    try {
      await user.reauthenticateWithCredential(credential);
      await user.updatePassword(newPassword);
      showToast('password has been changed!');
      Navigator.pop(context);
      return null;
    } on FirebaseAuthException catch (error) {
      showToast('password hasnt been changed');
      return codeResponses[error.code] ?? "Unknown";
    }
  }
}
