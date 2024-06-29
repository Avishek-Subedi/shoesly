import 'package:flutter/material.dart';
import 'package:shoesly_components/shoesly_componenets.dart';

class shoeslyTextField extends StatefulWidget {
  final TextEditingController controller;
  final bool isLoginScreen;
  final bool isPassword;
  final VoidCallback? onPressed;
  final FormFieldValidator<String>? validator;

  const shoeslyTextField({
    super.key,
    required this.controller,
    this.isPassword = false,
    this.onPressed,
    this.isLoginScreen = false,
    this.validator,
  });

  @override
  State<shoeslyTextField> createState() => _shoeslyTextFieldState();
}

class _shoeslyTextFieldState extends State<shoeslyTextField> {
  bool _obscureText = true;

  @override
  void initState() {
    super.initState();
    _obscureText = widget.isPassword;
  }

  @override
  Widget build(BuildContext context) {
    final Color textColor = widget.isLoginScreen ? Colors.white : Colors.black;
    final Color borderColor = widget.isLoginScreen
        ? colorScheme(context).surface
        : colorScheme(context).primary;
    final Color cursorColor = textColor;
    final Color onSecondaryColor = Theme.of(context).colorScheme.onSecondary;

    return TextFormField(
      style: Theme.of(context).textTheme.bodySmall!.copyWith(
          color: widget.isLoginScreen ? cursorColor : onSecondaryColor,
          fontSize: 18,
          fontWeight: FontWeight.normal),
      controller: widget.controller,
      validator: widget.validator,
      obscureText: _obscureText,
      onTap: widget.onPressed,
      cursorColor: cursorColor,
      decoration: InputDecoration(
        isDense: true,
        contentPadding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: borderColor,
            style: BorderStyle.solid,
          ),
          borderRadius: BorderRadius.circular(8.0),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: borderColor,
            style: BorderStyle.solid,
          ),
          borderRadius: BorderRadius.circular(8.0),
        ),
        border: OutlineInputBorder(
          borderSide: BorderSide(
            color: borderColor,
            style: BorderStyle.solid,
          ),
          borderRadius: BorderRadius.circular(8.0),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: borderColor,
            style: BorderStyle.solid,
          ),
          borderRadius: BorderRadius.circular(8.0),
        ),
        errorBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: borderColor,
            style: BorderStyle.solid,
          ),
          borderRadius: BorderRadius.circular(8.0),
        ),
        errorStyle: Theme.of(context).textTheme.bodySmall?.copyWith(
              color: onSecondaryColor,
              fontSize: 8,
            ),
        suffixIcon: widget.isPassword
            ? IconButton(
                icon: Icon(
                  _obscureText ? Icons.visibility_off : Icons.visibility,
                  color: cursorColor,
                ),
                onPressed: () {
                  setState(() {
                    _obscureText = !_obscureText;
                  });
                },
              )
            : null,
      ),
    );
  }
}
