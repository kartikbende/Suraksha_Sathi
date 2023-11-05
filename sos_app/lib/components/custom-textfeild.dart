import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final String? hint_text;
  final TextEditingController? controller;
  final String? Function(String?)? validate;
  final String? Function(String?)? onsave;
  final int? maxLines;
  final bool isPassword;
  final bool enable;
  final bool? check;
  final TextInputType? keyboardtype;
  final TextInputAction? tectinputaction;
  final FocusNode? focusNode;
  final Widget? preftx;
  final Widget? suffix;

  CustomTextField(
      {this.controller,
      this.enable = true,
      this.check,
      this.focusNode,
      this.hint_text,
      this.isPassword = false,
      this.keyboardtype,
      this.maxLines,
      this.onsave,
      this.preftx,
      this.suffix,
      this.tectinputaction,
      this.validate});

  @override
  Widget build(context) {
    return TextFormField(
      enabled: enable == true ? true : enable,
      maxLines: maxLines == null ? 1 : maxLines,
      onSaved: onsave,
      focusNode: focusNode,
      textInputAction: tectinputaction,
      keyboardType: keyboardtype == null ? TextInputType.name : keyboardtype,
      controller: controller,
      validator: validate,
      obscureText: isPassword == false ? false : isPassword,
      decoration: InputDecoration(
          prefixIcon: preftx,
          suffixIcon: suffix,
          labelText: hint_text ?? "Hint Text",
          hintStyle: TextStyle(color: const Color.fromARGB(255, 245, 242, 242)),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(
                  style: BorderStyle.solid,
                  color: Theme.of(context).primaryColor)),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(
                  style: BorderStyle.solid, color: Color(0xFF909A9E))),
          focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(
                  style: BorderStyle.solid,
                  color: Theme.of(context).primaryColor)),
          errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide:
                  BorderSide(style: BorderStyle.solid, color: Colors.red))),
    );
  }
}
