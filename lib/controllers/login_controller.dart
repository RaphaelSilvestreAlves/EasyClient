import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:projeto_app/screens/list_screen.dart';

class LoginController extends GetxController {
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var senhaVisivel = false.obs;

  void validateLogin() {
    String email = emailController.text;
    String password = passwordController.text;

    if (!validateEmail(email)) {
      showMessage("E-mail inválido!");
      return;
    }
    if (password.length < 6) {
      showMessage("A senha deve ter pelo menos 6 caracteres!");
      return;
    } else if (password.length > 32) {
      showMessage("A senha deve ter menos do que 32 caracteres!");
      return;
    }
    showMessage("Login realizado com sucesso!", success: true);
    Future.delayed(Duration(seconds: 2), () {
      Get.to(() => ListScreen());
    });
  }

  bool validateEmail(String email) {
    final regex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    return regex.hasMatch(email);
  }

  void showMessage(String message, {bool success = false}) {
    Get.snackbar(
      "Aviso",
      message,
      titleText: Text(
        "Aviso",
        style: TextStyle(
          fontSize: 16,
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
      ),
      messageText: Text(
        message,
        style: TextStyle(fontSize: 16, color: Colors.white),
      ),
      backgroundColor: success ? Colors.green : Colors.red,
      colorText: Colors.white,
      snackPosition: SnackPosition.BOTTOM,
    );
  }
}
