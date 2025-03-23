bool validateCpf(String cpf) {
      // Remove caracteres não numéricos
      cpf = cpf.replaceAll(RegExp(r'\D'), '');

      // Verifica se tem 11 dígitos
      if (cpf.length != 11) return false;

      // Elimina CPFs com números repetidos (ex: 111.111.111-11)
      if (RegExp(r'^(.)\1*$').hasMatch(cpf)) return false;

      // Cálculo do primeiro dígito verificador
      int sum = 0;
      for (int i = 0; i < 9; i++) {
        sum += int.parse(cpf[i]) * (10 - i);
      }
      int firstVerifier = (sum * 10) % 11;
      if (firstVerifier == 10) firstVerifier = 0;
      if (firstVerifier != int.parse(cpf[9])) return false;

      // Cálculo do segundo dígito verificador
      sum = 0;
      for (int i = 0; i < 10; i++) {
        sum += int.parse(cpf[i]) * (11 - i);
      }
      int secondVerifier = (sum * 10) % 11;
      if (secondVerifier == 10) secondVerifier = 0;
      if (secondVerifier != int.parse(cpf[10])) return false;

      return true;
    }