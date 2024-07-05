// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:project_manager/core/app_pallete.dart';

class projectField extends StatefulWidget {
  String hintText;
  String labelText;
  Icon prefixIcon;
  bool isDate;
  final TextEditingController controller;

  // VoidCallback? func;

  projectField({
    Key? key,
    required this.hintText,
    required this.labelText,
    required this.prefixIcon,
    required this.controller,
    required this.isDate,
  }) : super(key: key);

  DateTime selectedDate = DateTime.now();

  @override
  State<projectField> createState() => _authFieldState();
}

class _authFieldState extends State<projectField> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: GestureDetector(
        onTap: widget.isDate ? () => _selectDate(context) : () => () {},
        child: widget.isDate
            ? AbsorbPointer(
                child: Material(
                  elevation: 2,
                  shadowColor: Color.fromARGB(255, 183, 209, 255),
                  borderRadius: BorderRadius.circular(15),
                  child: TextFormField(
                    style: Theme.of(context).textTheme.bodyMedium,
                    controller: widget.controller,
                    keyboardType: widget.isDate
                        ? TextInputType.datetime
                        : TextInputType.text,
                    decoration: InputDecoration(
                      labelText: widget.labelText,
                      hintText: widget.hintText,
                      prefixIcon: widget.prefixIcon,
                    ),
                  ),
                ),
              )
            : Material(
                elevation: 2,
                shadowColor: Color.fromARGB(255, 183, 209, 255),
                borderRadius: BorderRadius.circular(15),
                child: TextFormField(
                  style: Theme.of(context).textTheme.bodyMedium,
                  controller: widget.controller,
                  keyboardType: widget.isDate
                      ? TextInputType.datetime
                      : TextInputType.text,
                  decoration: InputDecoration(
                    labelText: widget.labelText,
                    hintText: widget.hintText,
                    prefixIcon: widget.prefixIcon,
                  ),
                ),
              ),
      ),
    );
  }

  void _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: widget.selectedDate,
      firstDate: DateTime(1901, 1),
      lastDate: DateTime(2100),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.light(
              primary:
                  Color.fromARGB(255, 104, 181, 245), // header background color
              onPrimary:
                  const Color.fromARGB(255, 255, 255, 255), // header text color
              onSurface: Colors.black87, // body text color
            ),
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                foregroundColor: Colors.red, // button text color
              ),
            ),
            textTheme: TextTheme(
              bodyText1: TextStyle(),
              bodyText2: TextStyle(),
            ),
          ),
          child: child!,
        );
      },
    );
    if (picked != null)
      setState(() {
        widget.selectedDate = picked;
        widget.controller.value =
            TextEditingValue(text: DateFormat.yMMMd().format(picked));
      });
  }
}
