import 'package:flutter/material.dart';
import 'package:learn_europe/constants/colors.dart';

class InputField extends StatefulWidget {
  const InputField({
    super.key,
    required this.controller,
    required this.title,
    this.hint,
    this.prefixIcon,
    this.suffixIcon,
    this.suffixAction,
    this.maxLength,
    this.hideInput = false,
    this.editable = true,
    this.textInputType,
  });

  final TextEditingController controller;
  final String title;
  final String? hint;
  final IconData? prefixIcon;
  final IconData? suffixIcon;
  final VoidCallback? suffixAction;
  final int? maxLength;
  final bool hideInput;
  final bool editable;
  final TextInputType? textInputType;

  @override
  InputFieldState createState() => InputFieldState();
}

class InputFieldState extends State<InputField> {
  bool isFocused = false;

  @override
  Widget build(BuildContext context) {
    return Focus(
      onFocusChange: (hasFocus) {
        setState(() {
          isFocused = hasFocus;
        });
      },
      child: TextFormField(
        controller: widget.controller,
        decoration: InputDecoration(
          labelText: widget.title,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          hintText: widget.hint,
          prefixIcon: widget.prefixIcon != null
              ? Icon(
                  widget.prefixIcon,
                  color: isFocused
                      ? MediaQuery.of(context).platformBrightness == Brightness.light
                          ? AppColors.primaryColorLight
                          : AppColors.primaryColorDark
                      : null,
                )
              : const SizedBox.shrink(),
          suffixIcon: widget.suffixIcon != null
              ? IconButton(
                  icon: Icon(widget.suffixIcon),
                  color: isFocused
                      ? MediaQuery.of(context).platformBrightness == Brightness.light
                          ? AppColors.primaryColorLight
                          : AppColors.primaryColorDark
                      : null,
                  onPressed: () => widget.suffixAction != null ? widget.suffixAction!() : null,
                )
              : const SizedBox.shrink(),
        ),
        autocorrect: false,
        keyboardType: widget.textInputType,
        maxLines: 1,
        maxLength: widget.maxLength,
        obscureText: widget.hideInput,
        obscuringCharacter: '*',
        enabled: widget.editable,
      ),
    );
  }
}
