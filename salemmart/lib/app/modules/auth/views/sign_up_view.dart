import 'package:flutter/material.dart';
import 'package:flutter_vendure_stor/app/constants/widgetConstant.dart';
import 'package:flutter_vendure_stor/app/data/mutation/mutation.dart';
import 'package:flutter_vendure_stor/app/modules/auth/controllers/auth_controller.dart';
import 'package:get/get.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import '../../../constants/colorConstant.dart';
import '../../../constants/validation.dart';

class SignUpView extends GetView<AuthController> {
  SignUpView({Key? key}) : super(key: key);

  final _formKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      children: [
        Container(
          width: Get.width,
          height: Get.height,
          decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage("assets/images/back.jpg"),
                  fit: BoxFit.fill)),
        ),
        Container(
          width: Get.width,
          height: Get.height,
          color: ColorConstant.primeryColor.withOpacity(0.6),
        ),
        Positioned(
          width: Get.width,
          height: Get.height,
          child: ListView(children: [
            const Text(
              "SalemMart",
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: ColorConstant.backgroundColor,
                  fontSize: 36,
                  letterSpacing: 7),
            ),
            const SizedBox(
              height: 40,
            ),
            Container(
              width: Get.width,
              padding: const EdgeInsets.all(30),
              child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Sign Up",
                        style: TextStyle(
                            color: ColorConstant.backgroundColor,
                            fontWeight: FontWeight.w400,
                            fontSize: 20),
                      ),
                      const SizedBox(height: 30),
                      TextFormField(
                        controller: firstNameController,
                        cursorColor: ColorConstant.backgroundColor,
                        style: const TextStyle(
                            color: ColorConstant.backgroundColor),
                        keyboardType: TextInputType.text,
                        validator: (value) {
                          if (!Validation.validateName(value!)) {
                            return "please provide valid name";
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          filled: false,
                          hintText: "first name",
                          hintStyle: TextStyle(
                              color: ColorConstant.backgroundColor
                                  .withOpacity(0.9)),
                          prefixIcon: const Icon(
                            Icons.person,
                            color: ColorConstant.backgroundColor,
                          ),
                          border: textUnderlineInputBorder(),
                          focusedBorder: textUnderlineInputBorder(),
                          disabledBorder: textUnderlineInputBorder(),
                          enabledBorder: textUnderlineInputBorder(),
                          errorBorder: const UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.red)),
                        ),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      TextFormField(
                        controller: lastNameController,
                        cursorColor: ColorConstant.backgroundColor,
                        style: const TextStyle(
                            color: ColorConstant.backgroundColor),
                        keyboardType: TextInputType.text,
                        validator: (value) {
                          if (!Validation.validateName(value!)) {
                            return "please provide valid name";
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          filled: false,
                          hintText: "last name",
                          hintStyle: TextStyle(
                              color: ColorConstant.backgroundColor
                                  .withOpacity(0.9)),
                          prefixIcon: const Icon(
                            Icons.person,
                            color: ColorConstant.backgroundColor,
                          ),
                          border: textUnderlineInputBorder(),
                          focusedBorder: textUnderlineInputBorder(),
                          disabledBorder: textUnderlineInputBorder(),
                          enabledBorder: textUnderlineInputBorder(),
                          errorBorder: const UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.red)),
                        ),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      TextFormField(
                        controller: emailController,
                        cursorColor: ColorConstant.backgroundColor,
                        style: const TextStyle(
                            color: ColorConstant.backgroundColor),
                        keyboardType: TextInputType.emailAddress,
                        validator: (value) {
                          if (!Validation.validateEmail(value!)) {
                            return "please provide valid email";
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          filled: false,
                          hintText: "email",
                          hintStyle: TextStyle(
                              color: ColorConstant.backgroundColor
                                  .withOpacity(0.9)),
                          prefixIcon: const Icon(
                            Icons.email,
                            color: ColorConstant.backgroundColor,
                          ),
                          border: textUnderlineInputBorder(),
                          focusedBorder: textUnderlineInputBorder(),
                          disabledBorder: textUnderlineInputBorder(),
                          enabledBorder: textUnderlineInputBorder(),
                          errorBorder: const UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.red)),
                        ),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      TextFormField(
                        controller: phoneController,
                        cursorColor: ColorConstant.backgroundColor,
                        style: const TextStyle(
                            color: ColorConstant.backgroundColor),
                        keyboardType: TextInputType.phone,
                        validator: (value) {
                          if (!Validation.phoneNumberValidation(value!)) {
                            return "please provide valid phone";
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          filled: false,
                          hintText: "phone",
                          hintStyle: TextStyle(
                              color: ColorConstant.backgroundColor
                                  .withOpacity(0.9)),
                          prefixIcon: const Icon(
                            Icons.phone,
                            color: ColorConstant.backgroundColor,
                          ),
                          border: textUnderlineInputBorder(),
                          focusedBorder: textUnderlineInputBorder(),
                          disabledBorder: textUnderlineInputBorder(),
                          enabledBorder: textUnderlineInputBorder(),
                          errorBorder: const UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.red)),
                        ),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      Obx(
                        () => TextFormField(
                          controller: passwordController,
                          obscureText: controller.showPassword.value,
                          cursorColor: ColorConstant.backgroundColor,
                          style: const TextStyle(
                              color: ColorConstant.backgroundColor),
                          keyboardType: TextInputType.text,
                          validator: (value) {
                            if (!Validation.validatePassword(value!)) {
                              return "please provide valid pssword";
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                            filled: false,
                            hintText: "password",
                            hintStyle: TextStyle(
                                color: ColorConstant.backgroundColor
                                    .withOpacity(0.9)),
                            prefixIcon: const Icon(
                              Icons.lock,
                              color: ColorConstant.backgroundColor,
                            ),
                            suffixIcon: controller.showPassword.value
                                ? IconButton(
                                    onPressed: () =>
                                        controller.showPassword.value = false,
                                    icon: const Icon(
                                      Icons.visibility_off,
                                      color: ColorConstant.backgroundColor,
                                    ))
                                : IconButton(
                                    onPressed: () =>
                                        controller.showPassword.value = true,
                                    icon: const Icon(
                                      Icons.visibility,
                                      color: ColorConstant.backgroundColor,
                                    )),
                            border: textUnderlineInputBorder(),
                            focusedBorder: textUnderlineInputBorder(),
                            disabledBorder: textUnderlineInputBorder(),
                            enabledBorder: textUnderlineInputBorder(),
                            errorBorder: const UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.red)),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 50,
                      ),
                      Mutation(
                        options: MutationOptions(
                          document: gql(MutationAPp.signup),
                          onError: (error) {},
                          onCompleted: (data) {
                            controller.cheekSignup(data!);
                          },
                        ),
                        builder: (runMutation, result) {
                          if (result!.isLoading) {
                            controller.isSignUp.value = true;
                          }
                          return Obx(() => SizedBox(
                                width: Get.width,
                                child: controller.isSignUp.value == true
                                    ? WidgetConstant.LoginLoading
                                    : ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                            backgroundColor:
                                                ColorConstant.backgroundColor,
                                            padding: const EdgeInsets.all(15),
                                            elevation: 0),
                                        onPressed: () {
                                          _formKey.currentState!.save();
                                          if (_formKey.currentState!
                                              .validate()) {
                                            runMutation({
                                              "input": {
                                                "firstName":
                                                    firstNameController.text,
                                                "lastName":
                                                    lastNameController.text,
                                                "emailAddress":
                                                    emailController.text,
                                                "phoneNumber":
                                                    phoneController.text,
                                                "password":
                                                    passwordController.text
                                              }
                                            });
                                          }

                                          //Get.toNamed(Routes.HOME);
                                        },
                                        child: const Text(
                                          "Sign Up",
                                          style: TextStyle(
                                              color:
                                                  ColorConstant.primeryColor),
                                        )),
                              ));
                        },
                      )
                    ],
                  )),
            ),
            Container(
                margin: const EdgeInsets.only(bottom: 40),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Already have an account ",
                      style: TextStyle(
                          color:
                              ColorConstant.backgroundColor.withOpacity(0.8)),
                    ),
                    InkWell(
                        onTap: () => Get.back(),
                        child: const Text(
                          "SIGN IN",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: ColorConstant.backgroundColor),
                        )),
                  ],
                )),
          ]),
        )
      ],
    ));
  }

  UnderlineInputBorder textUnderlineInputBorder() {
    return const UnderlineInputBorder(
        borderSide: BorderSide(color: ColorConstant.backgroundColor));
  }
}
