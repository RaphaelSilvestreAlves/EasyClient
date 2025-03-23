import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:projeto_app/models/client.dart';
import 'package:projeto_app/screens/client_detail_screen.dart';
import 'package:projeto_app/widgets/custom_button.dart';

void main() {
  group('Client Details Screen Tests', () {
    Future<void> loadClientDetailsScreen(WidgetTester tester) async {
      // Criando um cliente fictício
      final fakeClient = Client(
        name: 'João Silva',
        cpf: '123.456.789-00',
        value: 150.75,
      );

      Get.testMode = true;

      await tester.pumpWidget(
        GetMaterialApp(home: ClientDetailsScreen(client: fakeClient)),
      );
      await tester.pump();
    }

    testWidgets('Should display client details correctly', (
      WidgetTester tester,
    ) async {
      await loadClientDetailsScreen(tester);

      expect(find.text('Detalhes do Cliente'), findsOneWidget);
      expect(find.text('Nome: João Silva'), findsOneWidget);
      expect(find.text('CPF: 123.456.789-00'), findsOneWidget);
      expect(find.text('Saldo: R\$ 150.75'), findsOneWidget);
    });

    testWidgets('Should find and tap the back button', (
      WidgetTester tester,
    ) async {
      await loadClientDetailsScreen(tester);

      expect(find.byType(CustomButton), findsOneWidget);
      final customButton = tester.widget(find.byType(CustomButton)) as CustomButton;

      expect(customButton.buttonColor, Colors.green);
      expect(customButton.icon, Icons.keyboard_backspace_rounded);
      expect(customButton.text, 'Voltar');
      expect(customButton.textColor, Colors.white);

      // Simula o clique no botão "Voltar"
      await tester.tap(find.byType(CustomButton));
      await tester.pumpAndSettle();
    });
  });
}
