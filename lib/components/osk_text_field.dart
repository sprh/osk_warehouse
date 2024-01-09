import 'package:flutter/material.dart';

import '../theme/utils/theme_from_context.dart';

class OskTextField extends StatelessWidget {
  final String hintText;
  final String label;

  final FocusNode? focusNode;
  final TextEditingController? textEditingController;
  final TextInputType? textInputType;
  final bool obscureText;
  final bool enableSuggestions;
  final bool autocorrect;
  final void Function(String)? onChanged;

  const OskTextField({
    required this.hintText,
    required this.label,
    this.focusNode,
    this.textEditingController,
    this.textInputType,
    this.obscureText = false,
    this.autocorrect = true,
    this.enableSuggestions = true,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    final theme = context.textFiledTheme;

    return ConstrainedBox(
      constraints: BoxConstraints(maxHeight: 54),
      child: TextFormField(
        focusNode: focusNode,
        controller: textEditingController,
        keyboardType: textInputType,
        obscureText: obscureText,
        enableSuggestions: enableSuggestions,
        autocorrect: autocorrect,
        onChanged: onChanged,
        decoration: InputDecoration(
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: theme.outlineColor, width: 1.0),
            borderRadius: BorderRadius.circular(8),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: theme.outlineColor, width: 1.0),
            borderRadius: BorderRadius.circular(8),
          ),
          label: Text(label),
          floatingLabelBehavior: FloatingLabelBehavior.always,
          hintText: hintText,
          labelStyle: TextStyle(color: theme.labelTextColor, fontSize: 14),
          hintStyle: TextStyle(color: theme.hintTextColor, fontSize: 14),
          floatingLabelStyle: TextStyle(
            color: theme.labelTextColor,
            fontSize: 12,
          ),
        ),
      ),
    );
  }
}
