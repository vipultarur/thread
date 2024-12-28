import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:form_validator/form_validator.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:thread/controllers/auth_controller.dart';
import 'package:thread/widets/auth_input.dart';

import '../../routes/routes_names.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final GlobalKey<FormState> _form=GlobalKey<FormState>();
  // Controllers for Username and Password fields
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final AuthController authController=Get.put(AuthController());
  // submit method
  void submit(){
    if (_form.currentState!.validate())
    {
      authController.login(emailController.text, passwordController.text);
    }
  }
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Form(
              key: _form,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Profile Picture Placeholder
                  Image.asset(
                    "lib/assets/images/logo.png",
                    width: 60,
                    height: 60,
                  ),
                  const SizedBox(height: 20),
                  // Welcome Text
                  const Text(
                    "Welcome Back To Threads",
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    "Please login to continue",
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey,
                    ),
                  ),
                  const SizedBox(height: 30),
                  // Username Field
                  AuthInput(
                    validatorCallback: ValidationBuilder().minLength(3).maxLength(50).required().build(),
                    labelText: 'Email',
                    icon: Icons.person,
                    controller: emailController,
                  ),
                  const SizedBox(height: 20),
                  // Password Field
                  AuthInput(
                    validatorCallback: ValidationBuilder().required().build(),
                    labelText: 'Password',
                    isPassword: true,
                    icon: Icons.key,
                    controller: passwordController,
                  ),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        TextButton(
                          onPressed: () {
                            // Handle forgot password
                          },
                          child: const Text("Forgot Password?"),
                        ),
                      ],),
                  const SizedBox(height: 5),
                  // Login Button
                  ElevatedButton(
                    onPressed:submit,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(
                          vertical: 15, horizontal: 40),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: const Text(
                      "Login",
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(height: 3),
                  // Forgot Password
                  Text.rich(
                    TextSpan(
                      children: [
                        TextSpan(text: "Sign Up",
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,

                          ),
                          recognizer: TapGestureRecognizer()
                            ..onTap=()=>Get.toNamed(RoutesNames.register)
                        )
                      ],
                      text:"Don't have an account ?")),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
