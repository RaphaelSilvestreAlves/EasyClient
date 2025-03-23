import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:projeto_app/models/client.dart';
import 'package:projeto_app/widgets/custom_button.dart';

class ClientDetailsScreen extends StatelessWidget {
  final Client client;

  ClientDetailsScreen({required this.client}); // Construtor atualizado

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Detalhes do Cliente'),
        centerTitle: true,
        backgroundColor: Colors.green,
        titleTextStyle: TextStyle(
          color: Colors.white,
          fontSize: 25,
          fontWeight: FontWeight.bold,
        ),
        leading: Builder(
          builder: (BuildContext context) {
            return Container(); // Isso remove o botão de voltar
          },
        ),
      ),

      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Nome: ${client.name}',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text('CPF: ${client.cpf}', style: TextStyle(fontSize: 16)),
            SizedBox(height: 10),
            Text(
              'Saldo: R\$ ${client.value.toStringAsFixed(2)}',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 20),
            CustomButton(
              key: Key('BackButtonDetailScreen'),
              buttonColor: Colors.green,
              icon: Icons.keyboard_backspace_rounded,
              text: 'Voltar',
              textColor: Colors.white,
              onPressed: () => Get.back(),
            ),
          ],
        ),
      ),
    );
  }
}
