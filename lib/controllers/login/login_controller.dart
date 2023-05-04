import 'package:afisha_admin_panel/repo/login_repo.dart';
import 'package:afisha_admin_panel/utils/failure.dart';
import 'package:afisha_admin_panel/utils/states.dart';
import 'package:either_dart/either.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class LoginController extends GetxController {
  TextEditingController passwordEditController = TextEditingController();
  TextEditingController loginEditingController = TextEditingController();
  final String secureId = 'secure_id';
  final String id = 'secure_id';
  bool isObSecured = true;
  States state = States.initial;

  LoginRepo repo;

  LoginController({required this.repo});

  void onConfirmPressed() async {
    if (passwordEditController.text.isNotEmpty &&
        loginEditingController.text.isNotEmpty &&
        state != States.loading &&
        state != States.loaded) {
      updateUI(States.loading);
      await repo
          .confirmUser(passwordEditController.text.toString(),
              loginEditingController.text.toString())
          .fold((left) {
        if (left is NetworkFailure) {
          updateUI(States.networkError);
        } else {
          updateUI(States.error);
        }
      }, (right) {
        updateUI(States.loaded);
      });
    } else {
      updateUI(States.empty);
    }
  }

  void onSecurePressed() {
    isObSecured = !isObSecured;
    update([secureId]);
  }

  updateUI(States states) {
    state = states;
    update([id]);
  }
}
