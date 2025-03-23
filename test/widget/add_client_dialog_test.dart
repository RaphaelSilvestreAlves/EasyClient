import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:projeto_app/controllers/client_controller.dart';
import 'package:projeto_app/widgets/add_client_dialog.dart';

void main() {
  group('AddClientDialog Widget Test', () {
    late ClientController controller;

    setUp(() {
      controller = Get.put(ClientController());
    });

    testWidgets('Should display the title and fields correctly', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        GetMaterialApp(home: Scaffold(body: AddClientDialog())),
      );

      expect(find.text('Adicionar Cliente'), findsOneWidget);
      expect(find.text('Nome'), findsOneWidget);
      expect(find.text('CPF'), findsOneWidget);
      expect(find.text('Saldo (R\$)'), findsOneWidget);
      expect(find.text('Cancelar'), findsOneWidget);
    });

    testWidgets('Should validate and show error when fields are empty', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        GetMaterialApp(home: Scaffold(body: AddClientDialog())),
      );

      // Pressiona o botão "Adicionar"
      await tester.tap(find.text('Adicionar'));
      await tester.pump(); // Aguarda a atualização do estado

      expect(find.text('Nome é obrigatório'), findsOneWidget);
      expect(find.text('CPF inválido'), findsOneWidget);
      expect(find.text('Saldo deve ser maior que 0'), findsOneWidget);
    });

    testWidgets('Should accept a valid CPF and format it correctly', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        GetMaterialApp(home: Scaffold(body: AddClientDialog())),
      );

      // Insere um CPF válido
      await tester.enterText(find.byType(TextField).at(1), '12345678909');
      await tester.pump();

      expect(find.text('123.456.789-09'), findsOneWidget);
    });

    testWidgets('Should format the value correctly as currency', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        GetMaterialApp(home: Scaffold(body: AddClientDialog())),
      );

      // Insere um valor numérico
      await tester.enterText(find.byType(TextField).at(2), '100000');
      await tester.pumpAndSettle();

      expect(find.byType(TextField).at(2), findsOneWidget);
      expect(find.text("R\$ 1.000,00"), findsOneWidget);
    });

    testWidgets(
      'Should add a client correctly when clicking "Add"',
      (WidgetTester tester) async {
        await tester.pumpWidget(
          GetMaterialApp(home: Scaffold(body: AddClientDialog())),
        );

        // Preenche os campos corretamente
        await tester.enterText(find.byType(TextField).at(0), 'Raphael');
        await tester.enterText(find.byType(TextField).at(1), '123.456.789-09');
        await tester.enterText(find.byType(TextField).at(2), '500');

        await tester.tap(find.text('Adicionar'));
        await tester.pumpAndSettle();

        // Deve existir um cliente na lista
        expect(controller.clientes.length, 4); // 4 Clientes na atual lista
        expect(
          controller.clientes.elementAt(3).name,
          'Raphael',
        ); //Cliente novo fica na posição 3 (0, 1, 2 , 3)
        expect(controller.clientes.elementAt(3).cpf, '123.456.789-09');
        expect(controller.clientes.elementAt(3).value, 5.0);
      },
    );
  });
}
