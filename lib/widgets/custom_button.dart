import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final IconData icon;
  final Color buttonColor;
  final Color textColor;
  final VoidCallback onPressed;

  // Construtor para receber os parâmetros personalizados
  const CustomButton({
    super.key,
    required this.text,
    required this.icon,
    required this.buttonColor,
    required this.textColor,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: buttonColor, // Cor do botão
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8), // Raio de borda
        ),
      ),
      onPressed: onPressed,
      child: Row(
        mainAxisSize:
            MainAxisSize.min, // O botão vai ocupar apenas o espaço necessário
        children: [
          Icon(
            icon,
            color: textColor, // Cor do ícone
          ),
          SizedBox(width: 8), // Espaçamento entre o ícone e o texto
          Text(
            text,
            style: TextStyle(
              color: textColor, // Cor do texto
              fontSize: 16,
            ),
          ),
        ],
      ),
    );
  }
}
