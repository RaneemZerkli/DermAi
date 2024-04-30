import 'package:dermatologist/Authentication/signup/signupScreen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'login_controller.dart';

class LoginPage extends StatelessWidget {
  LoginPage({Key? key}) : super(key: key);
  final LoginController _loginController = Get.put(LoginController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Obx(
            () => Center(
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  height: 400,
                  width: 400,
                  child: Image.asset('assets/derma.jpg'),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: const [
                    Padding(
                      padding: EdgeInsets.only(left: 25),
                      child: Text(
                        "Log in ",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 40,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 7,),
                Row(
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(left: 25),
                      child: Text(
                        "New to DermAI? ",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Get.to(SignUpScreen());
                      },
                      child: const Text(
                        'Create an account',
                        style: TextStyle(color: Colors.teal),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10,),
                _buildEmailTextField(
                  labelText: 'E-mail',
                  onChanged: (value) => _loginController.emailController.text = value,
                ),
                const SizedBox(height: 7,),
                _buildPasswordField(
                  labelText: 'Password',
                  onChanged: (value) => _loginController.passwordController.text = value,
                ),
                const SizedBox(height: 7,),
                const SizedBox(height: 25,),
                GestureDetector(
                  onTap: _loginController.isLoading.value ? null : _loginController.login,
                  child: Container(
                    margin: const EdgeInsets.symmetric(horizontal: 25),
                    padding: const EdgeInsets.all(25),
                    decoration: BoxDecoration(
                      color: Colors.teal,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: _loginController.isLoading.value
                        ? const CircularProgressIndicator()
                        : const Center(
                      child: Text(
                        'Log in ',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),
                ),
                if (_loginController.isLoggedIn.value) const Text('Login successful!'),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildEmailTextField({
    required String labelText,
    required Function(String) onChanged,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25.0),
      child: TextField(
        onChanged: onChanged,
        keyboardType: TextInputType.emailAddress,
        decoration: InputDecoration(
          labelText: labelText,
          labelStyle: const TextStyle(color: Colors.teal),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.grey.shade400),
          ),
          focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.teal),
          ),
        ),
      ),
    );
  }

  Widget _buildPasswordField({
    required String labelText,
    required Function(String) onChanged,
  }) {
    return Obx(
          () => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25.0),
        child: TextField(
          onChanged: onChanged,
          obscureText: !_loginController.isPasswordVisible.value,
          decoration: InputDecoration(
            labelText: labelText,
            labelStyle: TextStyle(color: Colors.teal),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.grey.shade400),
            ),
            focusedBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Colors.teal),
            ),
            suffixIcon: IconButton(
              icon: Icon(
                _loginController.isPasswordVisible.value ? Icons.visibility : Icons.visibility_off,
                color: Colors.grey,
              ),
              onPressed: () => _loginController.isPasswordVisible.toggle(),
            ),
          ),
        ),
      ),
    );
  }
}
