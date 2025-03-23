import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:projeto_app/controllers/client_controller.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:projeto_app/models/client.dart';
import 'package:projeto_app/utils/validate_cpf.dart';
import 'package:projeto_app/utils/value_formatter.dart';
import 'package:projeto_app/widgets/custom_button.dart';

class AddClientDialog extends StatelessWidget {
  final ClientController controller = Get.find();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController cpfController = TextEditingController();
  final TextEditingController valueController = TextEditingController();

  final cpfFormatter = MaskTextInputFormatter(mask: '###.###.###-##');
  final RxString cpfError = ''.obs;
  final RxString nameError = ''.obs;
  final RxString valueError = ''.obs;
  final RxBool isFormSubmitted = false.obs;

  AddClientDialog() {
    nameController.addListener(() {
      if (isFormSubmitted.value) {
        nameError.value =
            nameController.text.trim().isEmpty ? "Nome é obrigatório" : "";
      }
    });

    cpfController.addListener(() {
      if (isFormSubmitted.value) {
        cpfError.value = validateCpf(cpfController.text) ? "" : "CPF inválido";
      }
    });

    valueController.addListener(() {
      double parsedValue = parsedCurrency(valueController.text);
      String formattedValue = formatCurrency(parsedValue);

      valueController.value = TextEditingValue(
        text: formattedValue,
        selection: TextSelection.collapsed(offset: formattedValue.length),
      );

      if (isFormSubmitted.value) {
        valueError.value = parsedValue <= 0 ? "Valor deve ser maior que 0" : "";
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      contentPadding: EdgeInsets.zero,  // Remove o padding padrão do AlertDialog
      titlePadding: EdgeInsets.zero,   // Remove o padding do título
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(16.0)), // Bordas arredondadas
      ),
      title: Container(
        decoration: BoxDecoration(
          color: Colors.green, // Cor da faixa
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(16.0), // Arredonda o topo esquerdo
            topRight: Radius.circular(16.0), // Arredonda o topo direito
          ),
        ),
        width: double.infinity, // Faz o container ocupar toda a largura
        padding: EdgeInsets.symmetric(vertical: 15, horizontal: 16), // Padding interno da faixa
        alignment: Alignment.center,  // Centraliza o título
        child: Text(
          'Adicionar Cliente',
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      content: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Obx(
              () => TextField(
                controller: nameController,
                decoration: InputDecoration(
                  labelText: 'Nome',
                  errorText:
                      isFormSubmitted.value && nameError.value.isNotEmpty
                          ? nameError.value
                          : null,
                ),
              ),
            ),
            Obx(
              () => TextField(
                controller: cpfController,
                inputFormatters: [cpfFormatter],
                decoration: InputDecoration(
                  labelText: 'CPF',
                  errorText:
                      isFormSubmitted.value && cpfError.value.isNotEmpty
                          ? cpfError.value
                          : null,
                ),
              ),
            ),
            Obx(
              () => TextField(
                controller: valueController,
                keyboardType: TextInputType.number,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                decoration: InputDecoration(
                  labelText: 'Saldo (R\$)',
                  errorText:
                      isFormSubmitted.value && valueError.value.isNotEmpty
                          ? valueError.value
                          : null,
                ),
              ),
            ),
          ],
        ),
      ),
      actions: [
        CustomButton(
          text: 'Adicionar',
          icon: Icons.add_circle_outline,
          buttonColor: Colors.green,
          textColor: Colors.white,
          onPressed: () {
            String nome = nameController.text.trim();
            String cpf = cpfController.text.trim();
            double value = parsedCurrency(valueController.text);

            isFormSubmitted.value = true;

            nameError.value = nome.isEmpty ? 'Nome é obrigatório' : '';
            cpfError.value = !validateCpf(cpf) ? 'CPF inválido' : '';
            valueError.value = value <= 0 ? 'Saldo deve ser maior que 0' : '';

            if (nameError.value.isNotEmpty ||
                cpfError.value.isNotEmpty ||
                valueError.value.isNotEmpty) {
              return;
            }

            controller.adicionarCliente(
              Client(name: nome, cpf: cpf, value: value),
            );
            Get.back();
          },
        ),
        CustomButton(
          text: 'Cancelar',
          icon: Icons.cancel_outlined,
          buttonColor: Colors.red,
          textColor: Colors.white,
          onPressed: () => Get.back(),
        ),
      ],
    );
  }
}
