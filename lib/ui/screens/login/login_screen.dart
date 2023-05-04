import 'package:afisha_admin_panel/controllers/login/login_controller.dart';
import 'package:afisha_admin_panel/services/routes/app_routes.dart';
import 'package:afisha_admin_panel/ui/widgets/progres_indicator.dart';
import 'package:afisha_admin_panel/utils/size_config.dart';
import 'package:afisha_admin_panel/utils/states.dart';
import 'package:afisha_admin_panel/values/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});

  final controller = Get.find<LoginController>();

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    return Scaffold(
      backgroundColor: AppColors.white,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: SizeConfig.calculateVertical(250),
              ),
              const Padding(
                padding: EdgeInsets.only(left: 18.0),
                child: Text(
                  'LOGIN',
                  style: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 32,
                      color: AppColors.red),
                ),
              ),
              SizedBox(
                height: SizeConfig.calculateVertical(30),
              ),
              getLogIn(),
              SizedBox(
                height: SizeConfig.calculateVertical(50),
              ),
              getPassword(),
              GetBuilder(
                  init: controller,
                  id: controller.id,
                  builder: (context) {
                    return Padding(
                      padding: const EdgeInsets.only(left: 18.0, top: 8),
                      child: SizedBox(
                        height: SizeConfig.calculateVertical(42),
                        child: controller.state == States.networkError
                            ? getError('no internet connection')
                            : controller.state == States.error
                                ? getError('problem occurred')
                                : controller.state == States.empty
                                    ? getError('password or login is empty')
                                    : const SizedBox(),
                      ),
                    );
                  }),
              getButton()
            ],
          ),
        ),
      ),
    );
  }

  getLogIn() {
    return Padding(
      padding: EdgeInsets.only(
          left: SizeConfig.calculateHorizontal(16),
          right: SizeConfig.calculateVertical(16)),
      child: Container(
        alignment: Alignment.center,
        width: double.infinity,
        decoration: BoxDecoration(
            border: Border.all(color: AppColors.black),
            borderRadius: const BorderRadius.all(Radius.circular(5)),
            color: AppColors.white),
        child: Padding(
          padding: const EdgeInsets.only(
            left: 16.0,
          ),
          child: GetBuilder(
              id: controller.secureId,
              init: controller,
              builder: (context) {
                return Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        controller: controller.loginEditingController,
                        maxLength: 17,
                        maxLines: 1,
                        cursorColor: AppColors.black,
                        //inputFormatters: [
                          // MaskTextInputFormatter(
                          //   mask: '+998 ## ### ## ##',
                          //   filter: {"#": RegExp(r'[0-9]')},
                          //   type: MaskAutoCompletionType.lazy,
                          // )
                       // ],
                        decoration: const InputDecoration(
                          hintText: 'login',
                          hintStyle: TextStyle(color: Colors.grey),
                          border: InputBorder.none,
                          counter: Offstage(),
                        ),
                        keyboardType: TextInputType.text,
                      ),
                    ),
                  ],
                );
              }),
        ),
      ),
    );
  }

  getPassword() {
    return Padding(
      padding: EdgeInsets.only(
          left: SizeConfig.calculateHorizontal(16),
          right: SizeConfig.calculateVertical(16)),
      child: Container(
        alignment: Alignment.center,
        width: double.infinity,
        decoration: BoxDecoration(
            border: Border.all(color: AppColors.black),
            borderRadius: const BorderRadius.all(Radius.circular(5)),
            color: AppColors.white),
        child: Padding(
          padding: const EdgeInsets.only(
            left: 16.0,
          ),
          child: GetBuilder(
              id: controller.secureId,
              init: controller,
              builder: (context) {
                return Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        controller: controller.passwordEditController,
                        // maxLength: 10,
                        maxLines: 1,
                        obscureText: controller.isObSecured,
                        cursorColor: AppColors.black,
                        decoration: const InputDecoration(
                          hintText: 'password',
                          hintStyle: TextStyle(color: Colors.grey),
                          border: InputBorder.none,
                          counter: Offstage(),
                        ),
                        keyboardType: TextInputType.text,
                      ),
                    ),
                    GestureDetector(
                      onTap: controller.onSecurePressed,
                      child: Padding(
                        padding: const EdgeInsets.only(right: 8.0),
                        child: SizedBox(
                          width: 36,
                          child: Icon(
                            controller.isObSecured
                                ? Icons.visibility_off
                                : Icons.visibility,
                            color: AppColors.red,
                          ),
                        ),
                      ),
                    )
                  ],
                );
              }),
        ),
      ),
    );
  }

  getButton() {
    return GetBuilder(
        init: controller,
        id: controller.id,
        builder: (context) {
          transact();
          return Padding(
            padding: const EdgeInsets.only(left: 18.0, right: 16),
            child: InkWell(
              onTap: controller.onConfirmPressed,
              child: Container(
                alignment: Alignment.center,
                height: SizeConfig.calculateVertical(56),
                width: double.infinity,
                decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(5)),
                    color: AppColors.red),
                child: controller.state == States.loading
                    ? const CustomProgressIndicator()
                    : Text(
                        controller.state == States.loaded
                            ? 'Confirmed'
                            : 'Confirm',
                        style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: AppColors.white),
                      ),
              ),
            ),
          );
        });
  }

  void transact() {
    if (controller.state == States.loaded) {
      Future.delayed(const Duration(seconds: 2)).then((value) {
        Get.offAndToNamed(AppRoutes.main);
      });
    }
  }

  getError(String s) {
    return Text(
      s,
      style: const TextStyle(
          fontWeight: FontWeight.w400, fontSize: 14, color: AppColors.red),
    );
  }
}
