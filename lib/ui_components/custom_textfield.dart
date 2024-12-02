import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomTextfield extends StatefulWidget {
  const CustomTextfield({
    super.key,
    required this.placeholderText,
    required this.controller,
    required this.onValidation,
  });

  final String placeholderText;
  final TextEditingController controller;
  final bool Function(String value) onValidation;

  @override
  State<CustomTextfield> createState() => _CustomTextfieldState();
}

class _CustomTextfieldState extends State<CustomTextfield> {
  bool isValid = false;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: widget.controller,
      // maxLength: 50,
      decoration: InputDecoration(
        border: const OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(17),
          ),
        ),
        enabledBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(17),
          ),
          borderSide: BorderSide(color: Color.fromRGBO(197, 197, 197, 1)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: const BorderRadius.all(
            Radius.circular(17),
          ),
          borderSide: BorderSide(
              color: widget.controller.text.isEmpty
                  ? const Color.fromRGBO(197, 197, 197, 1)
                  : isValid
                      ? Colors.green
                      : Colors.red),
        ),
        label: Text(
          widget.placeholderText,
          style: GoogleFonts.aBeeZee(
            color: Colors.grey,
            fontSize: 14,
            fontWeight: FontWeight.normal,
          ),
        ),
      ),
      onChanged: (value) {
        if (value.isEmpty) {
          setState(
            () {
              isValid = true;
            },
          );
        } else {
          final isValidated = widget.onValidation(value);
          if (isValidated) {
            setState(
              () {
                isValid = true;
              },
            );
          } else {
            setState(
              () {
                isValid = false;
              },
            );
          }
        }
      },
    );
  }
}
