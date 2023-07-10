import 'package:flutter/material.dart';

class MyTextField extends StatelessWidget {
  const MyTextField({
    Key? key,
    this.prefixIcon,
    this.suffixIcon,
    this.type,
    this.controller,
    this.onTap,
    this.onSubmit,
    this.validator,
    this.label,
    this.onChange,
    this.readOnly=false,
  }) : super(key: key);
  final void Function()? onTap;
  final void Function(String)? onChange;
  final void Function(String)? onSubmit;
  final TextEditingController? controller;
  final TextInputType? type;
  final Widget? label;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final bool readOnly;
  final String? Function(String?)? validator;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: validator,
      decoration: InputDecoration(
        label: label,
        border: const OutlineInputBorder(),
        suffixIcon: suffixIcon,
        prefixIcon: prefixIcon,
      ),
      readOnly: readOnly,
      onTap: onTap,
      onChanged: onChange,
      controller: controller,
      onFieldSubmitted: onSubmit,
      keyboardType: type,
    );
  }
}

