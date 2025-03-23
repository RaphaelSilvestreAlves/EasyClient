import 'package:intl/intl.dart';

String formatCurrency(double value) {
  return NumberFormat.currency(locale: 'pt_BR', symbol: 'R\$').format(value);
}

double parsedCurrency(String value) {
  String cleanValue = value.replaceAll(RegExp(r'[^0-9]'), '');

  return cleanValue.isNotEmpty ? double.parse(cleanValue) / 100 : 0.0;
}
