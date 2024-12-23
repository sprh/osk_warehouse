import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../theme/utils/theme_from_context.dart';
import '../icon/osk_icon_button.dart';
import '../icon/osk_icons.dart';

class OskTextField extends StatefulWidget {
  final String hintText;
  final String label;
  final String? initialText;

  final FocusNode? focusNode;
  final TextEditingController? textEditingController;
  final TextInputType? textInputType;
  final bool enableSuggestions;
  final bool autocorrect;
  final void Function(String)? onChanged;
  final VoidCallback? onEditingComplete;
  final bool showobscureTextIcon;
  final List<TextInputFormatter>? inputFormatters;
  final bool readOnly;

  final EdgeInsets? padding;
  final BoxConstraints? constraints;

  const OskTextField({
    required this.hintText,
    required this.label,
    this.initialText,
    this.focusNode,
    this.textEditingController,
    this.textInputType,
    this.showobscureTextIcon = false,
    this.autocorrect = true,
    this.enableSuggestions = true,
    this.onChanged,
    this.onEditingComplete,
    this.inputFormatters,
    this.readOnly = false,
    this.padding,
    this.constraints,
    super.key,
  });

  @override
  State<StatefulWidget> createState() => _OskTextFieldState();
}

class _OskTextFieldState extends State<OskTextField> {
  late bool obscureText = widget.showobscureTextIcon;

  @override
  Widget build(BuildContext context) {
    final theme = context.textFiledTheme;

    return Padding(
      padding: widget.padding ?? const EdgeInsets.symmetric(horizontal: 16),
      child: ConstrainedBox(
        constraints: widget.constraints ?? const BoxConstraints(),
        child: TextFormField(
          readOnly: widget.readOnly,
          focusNode: widget.focusNode,
          controller: widget.textEditingController,
          initialValue: widget.initialText,
          keyboardType: widget.textInputType,
          obscureText: obscureText,
          enableSuggestions: widget.enableSuggestions,
          autocorrect: widget.autocorrect,
          onChanged: widget.onChanged,
          inputFormatters: widget.inputFormatters,
          maxLines: obscureText ? 1 : null,
          style: TextStyle(color: theme.textColor, fontSize: 16),
          onEditingComplete: widget.onEditingComplete,
          decoration: InputDecoration(
            suffixIcon: widget.showobscureTextIcon
                ? OskIconButton(
                    icon: obscureText
                        ? OskIcon.show(color: theme.labelTextColor)
                        : OskIcon.hide(color: theme.labelTextColor),
                    onTap: () => setState(() => obscureText = !obscureText),
                  )
                : null,
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: theme.outlineColor),
              borderRadius: BorderRadius.circular(8),
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: theme.outlineColor),
              borderRadius: BorderRadius.circular(8),
            ),
            label: Text(widget.label),
            floatingLabelBehavior: FloatingLabelBehavior.always,
            hintText: widget.hintText,
            labelStyle: TextStyle(color: theme.labelTextColor, fontSize: 14),
            hintStyle: TextStyle(color: theme.hintTextColor, fontSize: 14),
            floatingLabelStyle: TextStyle(
              color: theme.labelTextColor,
              fontSize: 12,
            ),
          ),
        ),
      ),
    );
  }
}
