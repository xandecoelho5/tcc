import 'package:e_markety_client/shared/extensions/string_extension.dart';

class Password {
  final String currentPassword;
  final String newPassword;
  final String confirmPassword;

  Password({
    this.currentPassword = '',
    this.newPassword = '',
    this.confirmPassword = '',
  });

  bool get isValid =>
      currentPassword.isNotBlank &&
      newPassword.isNotBlank &&
      confirmPassword.isNotBlank;

  Password copyWith({
    String? currentPassword,
    String? newPassword,
    String? confirmPassword,
  }) {
    return Password(
      currentPassword: currentPassword ?? this.currentPassword,
      newPassword: newPassword ?? this.newPassword,
      confirmPassword: confirmPassword ?? this.confirmPassword,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'senhaAtual': currentPassword,
      'novaSenha': newPassword,
    };
  }
}
