import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:projeto_app/screens/list_screen.dart';

void main() {
  group('UI Widgets Tests', () {
    Future<void> loadListScreen(WidgetTester tester) async {
      await tester.pumpWidget(GetMaterialApp(home: ListScreen()));
      await tester.pump();
    }

    testWidgets('Find an add icon on the list screen', (WidgetTester tester) async {
      await loadListScreen(tester);

      expect(find.byIcon(Icons.add), findsOneWidget);
      final icon = tester.widget(find.byIcon(Icons.add)) as Icon;
      expect(icon.color, Colors.white);
    });

    testWidgets('Find a ListView on the list screen', (WidgetTester tester) async {
      await loadListScreen(tester);

      expect(find.byType(ListView), findsOneWidget);
      expect(find.byType(Column), findsAtLeast(3));
    });

    testWidgets('Find a ListTile on the list screen', (WidgetTester tester) async {
      await loadListScreen(tester);

      expect(find.byType(ListTile), findsAtLeast(3));

      final listTile = tester.widget(find.byType(ListTile).first) as ListTile;
      expect((listTile).title, isA<Text>());
      expect((listTile).subtitle, isA<Text>());
      expect((listTile).trailing, isA<Text>());
    });

    testWidgets('Find a ListTile for João Silva on the list screen', (WidgetTester tester) async {
      await loadListScreen(tester);

      expect(find.text('João Silva'), findsOneWidget);
      expect(find.text('CPF: 123.456.789-00'), findsOneWidget);
      expect(find.text('Saldo:\nR\$100.00'), findsOneWidget);
    });

    testWidgets('Find a ListTile for Maria Oliveira on the list screen', (WidgetTester tester) async {
      await loadListScreen(tester);

      expect(find.text('Maria Oliveira'), findsOneWidget);
      expect(find.text('CPF: 987.654.321-00'), findsOneWidget);
      expect(find.text('Saldo:\nR\$200.00'), findsOneWidget);
    });

    testWidgets('Find a ListTile for Carlos Souza on the list screen', (WidgetTester tester) async {
      await loadListScreen(tester);

      expect(find.text('Carlos Souza'), findsOneWidget);
      expect(find.text('CPF: 123.321.123-44'), findsOneWidget);
      expect(find.text('Saldo:\nR\$150.00'), findsOneWidget);
    });
  });
}
