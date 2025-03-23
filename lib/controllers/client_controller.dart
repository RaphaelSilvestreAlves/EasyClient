import 'package:get/get.dart';
import 'package:projeto_app/models/client.dart';
import 'package:projeto_app/data/client_data.dart';

class ClientController extends GetxController {
  var clientes = <Client>[].obs;

  @override
  void onInit() {
    super.onInit();
    clientes.addAll(clientesIniciais);
  }

  void adicionarCliente(Client cliente) {
    clientes.add(cliente);
  }
}