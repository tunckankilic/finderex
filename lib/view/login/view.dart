import 'package:finderex/common/extensions/context_extension.dart';
import 'package:finderex/view/login/controller.dart';
import 'package:finderex/widgets/confirm_button.dart';
import 'package:finderex/widgets/field_builder_auto.dart';
import 'package:finderex/widgets/top_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class Login extends GetView<LoginController> {
  Login({super.key});
  @override
  final LoginController controller = Get.put(LoginController());
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Image.asset(
          "images/login.png",
          fit: BoxFit.cover,
        ),
        Scaffold(
          backgroundColor: Colors.transparent,
          body: GestureDetector(
            onTap: () {
              FocusScope.of(context).requestFocus(FocusNode());
              SystemChannels.textInput.invokeMethod('TextInput.hide');
            },
            child: Form(
              key: controller.formKey,
              autovalidateMode: AutovalidateMode.disabled,
              child: SafeArea(
                child: CustomScrollView(
                  slivers: [
                    SliverToBoxAdapter(
                      child: Column(
                        children: [
                          Padding(
                            padding: context.paddingNormalHorizontal +
                                context.paddingNormalVertical,
                            child: const TopBar(),
                          ),
                          SizedBox(height: context.normalValue),
                          FieldBuilderAuto(
                            controller: controller.emailAddress.textController,
                            validator: controller.emailAddress.validate,
                            text: 'Email Address',
                            hint: 'Enter your email address',
                            hintColor: Colors.white,
                            margin: context.paddingMediumHorizontal,
                            autovalidateMode: true,
                            style: const TextStyle(
                                fontSize: 11, color: Colors.white),
                            titleStyle: const TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                                color: Colors.white),
                            keyboardType: TextInputType.emailAddress,
                            fillColor: Colors.transparent,
                            borderColor: Colors.grey[600]!.withOpacity(0.5),
                          ),
                          SizedBox(
                            height: context.normalValue,
                          ),
                          FieldBuilderAuto(
                            controller: controller.password.textController,
                            validator: controller.password.validate,
                            obscureVisibility: true,
                            obscureIconColor: Colors.grey,
                            text: 'Password',
                            hint: 'Enter your password',
                            hintColor: Colors.white,
                            margin: context.paddingMediumHorizontal,
                            autovalidateMode: true,
                            style: const TextStyle(
                                fontSize: 12, color: Colors.white),
                            titleStyle: const TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                                color: Colors.white),
                            fillColor: Colors.transparent,
                            borderColor: Colors.grey[600]!.withOpacity(0.5),
                            keyboardType: TextInputType.visiblePassword,
                          ),
                          /*Todo
                              GestureDetector(
                                onTap: () {
                                  //controller.onForgotPassword(context);
                                },
                                child: Container(
                                  color: Colors.transparent,
                                  padding: context.paddingNormal,
                                  alignment: Alignment.centerLeft,
                                  child: RichText(
                                    text: TextSpan(children: [
                                      TextSpan(
                                        text: 'Forgot password?',
                                        style:TextStyle(fontSize: 12)
                                            .primaryColor,
                                      ),
                                    ]),
                                  ),
                                ),
                              ),*/
                          SizedBox(height: context.mediumValue),
                          ConfirmButton(
                            onClick: () => controller.loginUser(
                                countryId: 225,
                                userName:
                                    controller.emailAddress.textController.text,
                                password:
                                    controller.password.textController.text,
                                rememberMe: true),
                            margin: context.paddingMediumHorizontal,
                            height: context.normalValue + context.mediumValue,
                            width: MediaQuery.of(context).size.width,
                            text: 'Log in',
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
