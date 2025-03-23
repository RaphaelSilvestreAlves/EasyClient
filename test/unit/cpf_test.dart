import 'package:flutter_test/flutter_test.dart';
import 'package:projeto_app/utils/validate_cpf.dart';

void main() {
  group('Unit test of CPF validation function', () {
    test('Valid CPF validation', () {
      // Test a valid CPF
      String validCpf = '123.456.789-09'; // A valid CPF
      bool result = validateCpf(validCpf);
      expect(result, true);
    });

    test('Invalid CPF with incorrect number', () {
      // Test an invalid CPF
      String invalidCpf = '123.456.789-00'; // An invalid CPF
      bool result = validateCpf(invalidCpf);
      expect(result, false);
    });

    test('Validation of CPF without format', () {
      // Test CPF without formatting, but valid as a number
      String validCpfWithoutFormat =
          '12345678909'; // Format without punctuation
      bool result = validateCpf(validCpfWithoutFormat);
      expect(
        result,
        true,
      ); // The function should be able to validate without formatting
    });

    test('Validation of empty CPF', () {
      // Test empty CPF
      String emptyCpf = '';
      bool result = validateCpf(emptyCpf);
      expect(result, false);
    });
  });
}
