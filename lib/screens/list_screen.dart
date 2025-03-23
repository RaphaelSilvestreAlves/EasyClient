import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:projeto_app/controllers/client_controller.dart';
import 'package:projeto_app/screens/client_detail_screen.dart';
import 'package:projeto_app/widgets/add_client_dialog.dart';

class ListScreen extends StatelessWidget {
  final ClientController controller = Get.put(ClientController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Lista de Clientes'),
        centerTitle: true,
        backgroundColor: Colors.green,
        titleTextStyle: TextStyle(
          color: Colors.white,
          fontSize: 25,
          fontWeight: FontWeight.bold,
        ),
        iconTheme: IconThemeData(color: Colors.white),
        actions: [
          IconButton(
            icon: Icon(Icons.add, color: Colors.white),
            onPressed: () => Get.dialog(AddClientDialog()),
          ),
        ],
      ),
      body: Obx(
        () => ListView.builder(
          itemCount: controller.clientes.length,
          itemBuilder: (context, index) {
            var cliente = controller.clientes[index];
            return Column(
              children: [
                Container(
                  margin: EdgeInsets.symmetric(
                    vertical: 8,
                    horizontal: 16,
                  ), // Margem entre os itens
                  decoration: BoxDecoration(
                    color: Colors.white, 
                    borderRadius: BorderRadius.circular(
                      12,
                    ), 
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.2), 
                        spreadRadius: 2, 
                        blurRadius: 5, 
                        offset: Offset(0, 2), 
                      ),
                    ],
                  ),
                  child: ListTile(
                    title: Text(cliente.name,style: TextStyle(
                        fontSize: 16,
                      )),
                    subtitle: Text('CPF: ${cliente.cpf}', style: TextStyle(
                        fontSize: 16,
                      )),
                    trailing: Text(
                      'Saldo:\nR\$${cliente.value.toStringAsFixed(2)}',
                      style: TextStyle(
                        fontSize: 16,
                      ),
                    ),
                    onTap: () {
                      Get.snackbar(
                        'Cliente Selecionado',
                        '${cliente.name} - CPF: ${cliente.cpf} - Saldo: R\$${cliente.value.toStringAsFixed(2)}',
                        snackPosition: SnackPosition.BOTTOM,
                        backgroundColor: Colors.green,
                        colorText: Colors.white,
                      );
                      Future.delayed(Duration(milliseconds: 1500), () {
                        Get.to(() => ClientDetailsScreen(client: cliente));
                      });
                    },
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
