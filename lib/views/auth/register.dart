import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:form_validator/form_validator.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:thread/controllers/auth_controller.dart';
import 'package:thread/utils/helper.dart';

import '../../routes/routes_names.dart';
import '../../widets/auth_input.dart';


class Register extends StatefulWidget
{
  const Register({Key? key}) : super(key: key);
  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final GlobalKey<FormState> _form=GlobalKey<FormState>();
  // Controllers for Username and Password fields
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController cpasswordController = TextEditingController();
  final AuthController controller=Get.put(AuthController());


  // submit method
  void submit(){
    if (_form.currentState!.validate())
      {
        controller.register(usernameController.text,emailController.text,passwordController.text);
      }
  }
 @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    usernameController.dispose();
    cpasswordController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(10.0),
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
                    "Welcome to Threads",
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    "Welcome to the thread world",
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey,
                    ),
                  ),
                  const SizedBox(height: 30),
                  // Username Field
                  AuthInput(
                    validatorCallback: ValidationBuilder().minLength(3).maxLength(50).required().build(),
                    labelText: 'Username',
                    icon: Icons.person,
                    controller: usernameController,
                  ),
                  const SizedBox(height: 20),
                  // email field
                  AuthInput(
                    validatorCallback: ValidationBuilder().email().maxLength(50).required().build(),
                    labelText: 'Email',
                    icon: Icons.email,
                    controller: emailController,
                  ),
                  const SizedBox(height: 20),
                  // password field
                  AuthInput(
                    validatorCallback: ValidationBuilder().minLength(8).maxLength(20).required().build(),
                    labelText: 'Password',
                    icon: Icons.lock,
                    controller: passwordController,
                  ),
                  const SizedBox(height: 20),
                  // Conform Password Field
                  AuthInput(
                    validatorCallback: (arg){
                      if(passwordController.text != arg){
                        return "Confirm password not matched";
                      }
                      return null;
                    },
                    labelText: 'Conform Password',
                    isPassword: true,
                    icon: Icons.lock,
                    controller: cpasswordController,
                  ),
                  const SizedBox(height: 10),
                  // Register Button
                  ElevatedButton(
                    onPressed: submit,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(
                          vertical: 15, horizontal: 40),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),

                    ),
                    child: const Text(
                      "Register",
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(height: 3),
                  // Sign In Text
                  Text.rich(
                    TextSpan(
                      text: "Already have an account ? ",
                      children: [
                        TextSpan(
                          text: "Sign In",
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () => Get.toNamed(RoutesNames.login),
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
    );
  }

}
