class Strings {
  Strings._();

  static const String obrigatorio = 'Campo obrigatório';
  static const String emailInvalido = 'Informe um email válido';
  static const String valorMinimo = 'Este valor deve ser maior que 0';
  static const String valorEntre =
      'Este valor deve ser maior ou igual a 0 e menor ou igual a 999';
  static const String valorEntrePercentual = 'Valor deve ser entre 0 e 100';
  static const String senhaMinimo = 'Deve ter pelo menos 6 caracteres';
  static const String senhaDiferente = 'As senhas não são iguais';
  static const String token = 'authToken';
  static const String ambosHorariosObrigatorios =
      'Ambos os horários são obrigatórios';
  static const String horarioAberturaMaiorQueFechamento =
      'Horário de abertura deve ser menor que horário de fechamento';
  static const String horarioInvalido = 'Horário inválido';

  // errors
  static const String noneOpenPedido =
      'Não existe um pedido em aberto para este usuário';
  static const String usuarioInvalido = 'Usuário inválido ou não autorizado';
  static const String naoPossivelAdicionarItem =
      'Não é possível adicionar ao carrinho enquanto houver algum pedido em andamento';
}
