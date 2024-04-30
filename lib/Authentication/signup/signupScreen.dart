import 'package:dermatologist/Authentication/signup/signupController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../login/loginScreen.dart';


class SignUpScreen extends StatelessWidget {
  final SignupController _signupController = Get.put(SignupController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Form(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const Center(
                    child: Text("Sign Up",
                      style: TextStyle(color: Colors.black,fontSize: 40,fontWeight: FontWeight.bold),
                    ),
                  ),
                  const SizedBox(height: 20,),

                  TextFormField(

                    onChanged: (value) => _signupController.firstNameController.text = value,
                    decoration: InputDecoration(
                      labelText: 'First Name',
                      labelStyle: const TextStyle(color: Colors.grey),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey.shade400),
                      ),
                      focusedBorder: const OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.teal),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16.0),
                  TextFormField(

                    onChanged: (value) => _signupController.lastNameController.text = value,
                    decoration: InputDecoration(
                      labelText: 'Last Name',
                      labelStyle: const TextStyle(color: Colors.grey),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey.shade400),
                      ),
                      focusedBorder: const OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.teal),
                      ),
                    ),


                  ),
                  const SizedBox(height: 16.0),
                  TextFormField(

                    onChanged: (value) => _signupController.emailController.text = value,
                    decoration: InputDecoration(
                      labelText: 'E-mail',
                      labelStyle: const TextStyle(color: Colors.grey),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey.shade400),
                      ),
                      focusedBorder: const OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.teal),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16.0),
                  Obx(
                      ()=> TextFormField(
                      onChanged: (value) => _signupController.passwordController.text = value,
                      obscureText: !_signupController.isPasswordVisible.value,
                      decoration: InputDecoration(
                        labelText: 'Password',
                        suffixIcon: GestureDetector(
                          onTap: () {
                            _signupController.togglePasswordVisibility();
                          },
                          child: Icon(
                            _signupController.isPasswordVisible.value ? Icons.visibility : Icons.visibility_off,color: Colors.grey,
                          ),
                        ),
                        labelStyle: const TextStyle(color: Colors.grey),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey.shade400),
                        ),
                        focusedBorder: const OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.teal),
                        ),


                      ),

                    ),
                  ),
                  const SizedBox(height: 16.0),
                  Obx(
                   ()=> TextFormField(

                      onChanged: (value) => _signupController.confirmPasswordController.text = value,
                      obscureText:   !_signupController.isConfirmPasswordVisible.value,
                      decoration: InputDecoration(
                        labelText: 'Confirm Password',
                        suffixIcon: GestureDetector(
                          onTap: () {
                            _signupController.toggleConfirmPasswordVisibility();
                          },
                          child: Icon(
                            _signupController.isConfirmPasswordVisible.value ? Icons.visibility : Icons.visibility_off,color: Colors.grey,
                          ),
                        ),
                        labelStyle: const TextStyle(color: Colors.grey),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey.shade400),
                        ),
                        focusedBorder: const OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.teal),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 32.0),
                  GestureDetector(
                    onTap : _signupController.signUp,
                    child: Container(

                      padding:  const EdgeInsets.all(25),
                      decoration:  BoxDecoration(color: Colors.teal,borderRadius: BorderRadius.circular(8)),

                      child: const Center(child: Text('Sign Up ',style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 16))),
                    ),
                  ),
                  Row(mainAxisAlignment: MainAxisAlignment.center,
                    children:  [
                      const Text("Already have an account? ",style: TextStyle(color: Colors.black,fontSize: 16),),
                      GestureDetector(
                        onTap:  (){
                          Get.off(LoginPage());
                        },
                        child: const Text('Login here',style: TextStyle(color: Colors.teal),
                        ),
                      ),

                    ],
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
