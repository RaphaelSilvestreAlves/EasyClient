import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:projeto_app/controllers/login_controller.dart';

void main() {
  setUp(() {
    Get.testMode = true;
  });

  // Teste para validar o e-mail
  test('Validate email', () {
    final controller = LoginController();
    controller.emailController.text = "test@domain.com";

    expect(controller.validateEmail(controller.emailController.text), true);

    controller.emailController.text = "email-invalido";
    expect(controller.validateEmail(controller.emailController.text), false);
  });

  // Teste para validar a senha
  test('Validate password', () {
    final controller = LoginController();
    controller.passwordController.text = "123456";

    // A senha tem que ter no mínimo 6 caracteres
    expect(controller.passwordController.text.length >= 6, true);
    expect(controller.passwordController.text.length <= 32, true);

    controller.passwordController.text = "123"; // Senha menor que 6 caracteres
    expect(controller.passwordController.text.length >= 6, false);
    
    controller.passwordController.text = "a" * 33; // Senha maior que 32 caracteres
    expect(controller.passwordController.text.length <= 32, false);
  });
}
