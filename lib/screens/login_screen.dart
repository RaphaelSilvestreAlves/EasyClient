import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:projeto_app/controllers/login_controller.dart';
import 'package:projeto_app/widgets/custom_button.dart';

class LoginScreen extends StatelessWidget {
  final LoginController controller = Get.put(LoginController());

  LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Login"),
        centerTitle: true,
        backgroundColor: Colors.green,
        titleTextStyle: TextStyle(
          color: Colors.white,
          fontSize: 25,
          fontWeight: FontWeight.bold,
        ),
      ),
      body: Container(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment:
              MainAxisAlignment.start, 
          crossAxisAlignment:
              CrossAxisAlignment.center, 
          children: [
            SizedBox(height: 50),
            Icon(Icons.lock_person_outlined, size: 160),
            SizedBox(height: 70),
            Column(
              children: [
                TextField(
                  key: Key('nameLoginTextField'),
                  controller: controller.emailController,
                  decoration: InputDecoration(labelText: "E-mail"),
                  keyboardType: TextInputType.emailAddress,
                ),
                SizedBox(height: 16),
                Obx(
                  () => TextField(
                    key: Key('passwordLoginTextField'),
                    controller: controller.passwordController,
                    obscureText: !controller.senhaVisivel.value,
                    decoration: InputDecoration(
                      labelText: "Senha",
                      suffixIcon: IconButton(
                        icon: Icon(
                          controller.senhaVisivel.value
                              ? Icons.visibility
                              : Icons.visibility_off,
                        ),
                        onPressed: () {
                          controller.senhaVisivel.value =
                              !controller.senhaVisivel.value;
                        },
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 24),
                CustomButton(
                  key: Key('LoginButton'),
                  buttonColor: Colors.green,
                  icon: Icons.login_rounded,
                  text: 'Entrar',
                  textColor: Colors.white,
                  onPressed: controller.validateLogin,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
