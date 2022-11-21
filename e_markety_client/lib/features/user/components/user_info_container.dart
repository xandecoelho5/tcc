import 'package:e_markety_client/shared/theme/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class UserInfoContainer extends StatefulWidget {
  const UserInfoContainer({
    Key? key,
    required this.icon,
    this.text,
    this.label,
    this.onSaved,
    this.onChanged,
    this.onFieldSubmitted,
    this.onValidate,
    this.inputFormatters,
  }) : super(key: key);

  final String? text;
  final IconData icon;
  final String? label;
  final Function(String?)? onSaved;
  final Function(String?)? onChanged;
  final Function(String?)? onFieldSubmitted;
  final String? Function(String?)? onValidate;
  final List<TextInputFormatter>? inputFormatters;

  @override
  State<UserInfoContainer> createState() => _UserInfoContainerState();
}

class _UserInfoContainerState extends State<UserInfoContainer> {
  final _controller = TextEditingController();
  bool _isObscure = true;

  @override
  void initState() {
    super.initState();
    final text = widget.text ?? '';
    if (widget.inputFormatters != null) {
      _controller.value = widget.inputFormatters![0].formatEditUpdate(
        TextEditingValue.empty,
        TextEditingValue(text: text),
      );
    } else {
      _controller.text = text;
    }
  }

  @override
  Widget build(BuildContext context) {
    final border = OutlineInputBorder(
      borderRadius: BorderRadius.circular(20),
      borderSide: BorderSide(color: Colors.grey.shade400),
    );
    final isObscure = widget.icon == Icons.lock;

    return TextFormField(
      controller: _controller,
      onSaved: widget.onSaved,
      onChanged: widget.onChanged,
      validator: widget.onValidate,
      inputFormatters: widget.inputFormatters,
      obscureText: _isObscure && isObscure,
      onFieldSubmitted: widget.onFieldSubmitted,
      decoration: InputDecoration(
        labelText: widget.label,
        isDense: true,
        prefixIcon: Icon(widget.icon, color: kPrimaryColor, size: 28),
        suffixIcon: isObscure
            ? GestureDetector(
                onTap: () => setState(() => _isObscure = !_isObscure),
                child: Padding(
                  padding: const EdgeInsets.only(right: 24),
                  child: Icon(
                    _isObscure ? Icons.visibility_off : Icons.visibility,
                    color: Colors.grey.shade400,
                  ),
                ),
              )
            : null,
        contentPadding: const EdgeInsets.symmetric(vertical: 14),
        prefixIconConstraints: const BoxConstraints(minWidth: 50),
        enabledBorder: border,
        focusedBorder: border,
        errorBorder: border.copyWith(
          borderSide: BorderSide(color: Colors.red.shade700),
        ),
        focusedErrorBorder: border.copyWith(
          borderSide: BorderSide(color: Colors.red.shade700),
        ),
        labelStyle: TextStyle(color: Colors.grey.shade500),
        floatingLabelStyle: const TextStyle(color: kPrimaryColor),
      ),
      style: kLabelLarge.copyWith(color: Colors.grey.shade700),
    );
  }
}
