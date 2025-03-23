import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:projeto_app/screens/login_screen.dart';
import 'package:projeto_app/widgets/custom_button.dart';

void main() {
  group('UI Widgets tests', () {
    Future<void> loadLoginScreen(WidgetTester tester) async {
      // Envolvendo o LoginScreen com GetMaterialApp para que o GetX funcione corretamente
      await tester.pumpWidget(GetMaterialApp(home: LoginScreen()));
      // Aguardando o frame
      await tester.pump();
    }

    testWidgets('Find a lock person icon on login screen', (
      WidgetTester tester,
    ) async {
      await loadLoginScreen(tester);
      expect(find.byIcon(Icons.lock_person_outlined), findsOneWidget);
    });

    testWidgets('Find a TextField of name on login screen', (
      WidgetTester tester,
    ) async {
      await loadLoginScreen(tester);
      expect(find.byKey(Key('nameLoginTextField')), findsOneWidget);
      expect(
        tester.widget(find.byKey(Key('nameLoginTextField'))),
        isA<TextField>(),
      );
      final textField =
          tester.widget(find.byKey(Key('nameLoginTextField'))) as TextField;

      expect((textField.decoration as InputDecoration).labelText, 'E-mail');
      expect((textField.keyboardType), TextInputType.emailAddress);
    });

    testWidgets('Find a TextField of password on login screen', (
      WidgetTester tester,
    ) async {
      await loadLoginScreen(tester);
      expect(find.byKey(Key('passwordLoginTextField')), findsOneWidget);
      expect(
        tester.widget(find.byKey(Key('passwordLoginTextField'))),
        isA<TextField>(),
      );
      final textField =
          tester.widget(find.byKey(Key('passwordLoginTextField'))) as TextField;

      expect((textField.decoration as InputDecoration).labelText, 'Senha');
      expect(
        (textField.decoration as InputDecoration).suffixIcon,
        isA<IconButton>(),
      );
    });

    testWidgets('Find a CustomButton on login screen', (
      WidgetTester tester,
    ) async {
      await loadLoginScreen(tester);
      expect(find.byKey(Key('LoginButton')), findsOneWidget);
      expect(
        tester.widget(find.byKey(Key('LoginButton'))),
        isA<CustomButton>(),
      );

      final customButton =
          tester.widget(find.byKey(Key('LoginButton'))) as CustomButton;
      expect((customButton.text), 'Entrar');
      expect((customButton.buttonColor), Colors.green);
      expect((customButton.icon), Icons.login_rounded);
      expect((customButton.textColor), Colors.white);
    });
  });
}
