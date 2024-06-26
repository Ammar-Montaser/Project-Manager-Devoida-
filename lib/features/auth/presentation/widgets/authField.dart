// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:project_manager/core/app_pallete.dart';

class authField extends StatefulWidget {
  String hintText;
  String labelText;
  Icon prefixIcon;
  final TextEditingController controller;
  bool isObscureText;
  bool isPassword;

  // VoidCallback? func;

  authField({
    Key? key,
    required this.hintText,
    required this.labelText,
    required this.prefixIcon,
    required this.controller,
    required this.isObscureText,
    required this.isPassword,
  }) : super(key: key);

  @override
  State<authField> createState() => _authFieldState();
}

class _authFieldState extends State<authField> {
  @override
  Widget build(BuildContext context) {
    void tooglePassword() {
      setState(() {
        this.widget.isObscureText = !this.widget.isObscureText;
      });
    }

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: Material(
        elevation: 20,
        shadowColor: Color.fromARGB(255, 183, 209, 255),
        borderRadius: BorderRadius.circular(15),
        child: TextFormField(
          obscureText: widget.isObscureText,
          style: Theme.of(context).textTheme.bodyMedium,
          controller: widget.controller,
          keyboardType: widget.isObscureText
              ? TextInputType.visiblePassword
              : TextInputType.emailAddress,
          decoration: InputDecoration(
            labelText: widget.labelText,
            hintText: widget.hintText,
            prefixIcon: widget.prefixIcon,
            suffixIcon: widget.isPassword
                ? IconButton(
                    onPressed: tooglePassword,
                    icon: Icon(
                      Icons.remove_red_eye,
                      color: LightTheme.brandingColor,
                    ))
                : null,
          ),
        ),
      ),
    );
  }
}
