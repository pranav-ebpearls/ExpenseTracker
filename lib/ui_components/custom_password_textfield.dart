import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomPasswordTextfield extends StatefulWidget {
  const CustomPasswordTextfield({
    super.key,
    required this.controller,
    required this.onValidatePassword,
  });

  final TextEditingController controller;
  final Function(String value) onValidatePassword;

  @override
  State<CustomPasswordTextfield> createState() =>
      _CustomPasswordTextfieldState();
}

class _CustomPasswordTextfieldState extends State<CustomPasswordTextfield> {
  bool passwordVisible = false;
  bool isPasswordValid = false;

  @override
  Widget build(BuildContext context) {
    return TextField(
      obscureText: passwordVisible,
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
                  : isPasswordValid
                      ? Colors.green
                      : Colors.red),
        ),
        label: Text(
          'Password',
          style: GoogleFonts.aBeeZee(
            color: Colors.grey,
            fontSize: 14,
            fontWeight: FontWeight.normal,
          ),
        ),
        helperText: 'Password must contain special character',
        helperStyle: const TextStyle(color: Colors.grey),
        suffixIcon: IconButton(
          onPressed: () {
            setState(() {
              passwordVisible = !passwordVisible;
            });
          },
          icon: Icon(
            passwordVisible ? Icons.visibility : Icons.visibility_off,
          ),
        ),
      ),
      keyboardType: TextInputType.visiblePassword,
      textInputAction: TextInputAction.done,
      onChanged: (value) {
        if (value.isEmpty) {
          setState(() {
            isPasswordValid = true;
          });
        } else {
          final isValid = widget.onValidatePassword(value);
          if (isValid) {
            setState(() {
              isPasswordValid = true;
            });
          } else {
            setState(() {
              isPasswordValid = false;
            });
          }
        }
      },
    );
  }
}
