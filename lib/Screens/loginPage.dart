import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:live_streaming/Controllers/userController.dart';
import 'package:lottie/lottie.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  UserController userController = Get.find();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            height: size.height,
            width: size.width,
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height * 0.35,
                    child: LottieBuilder.asset(
                      "assets/golive_animations.json",
                    ),
                  ),
                  const SizedBox(height: 80),
                  TextFormField(
                    controller: userController.userIdController,
                    validator: (value) {
                      if (value!.isEmpty || value.length < 6) {
                        return "Incorrect User ID";
                      }
                      return null;
                    },
                    decoration: const InputDecoration(
                      labelText:
                          'Enter 6 Digit ID to Join or Start a Live Stream',
                      border: OutlineInputBorder(
                        borderSide: BorderSide(width: 1),
                        borderRadius: BorderRadius.all(
                          Radius.circular(10),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  TextFormField(
                    controller: userController.passwordController,
                    obscureText: true,
                    validator: (value) {
                      if (value!.isEmpty ||
                          value.length < 4 ||
                          value != "1234") {
                        return "Incorrect Password";
                      }
                      return null;
                    },
                    decoration: const InputDecoration(
                      labelText: 'Enter Password',
                      border: OutlineInputBorder(
                        borderSide: BorderSide(width: 1),
                        borderRadius: BorderRadius.all(
                          Radius.circular(10),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 30),
                  MaterialButton(
                    splashColor: Colors.transparent,
                    highlightColor: Colors.green,
                    onPressed: () {
                      _formKey.currentState!.validate();
                      if (_formKey.currentState!.validate()) {
                        userController.loginUser();
                      }
                    },
                    color: Colors.black,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5),
                    ),
                    padding: const EdgeInsets.symmetric(
                        vertical: 15, horizontal: 30),
                    minWidth: double.infinity,
                    child: const Text(
                      "Sign In",
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
