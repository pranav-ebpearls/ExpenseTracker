import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomButton extends StatefulWidget {
  const CustomButton({
    super.key,
    required this.buttonTitle,
    required this.onPressed,
    required this.buttonBackgroudColor,
    required this.buttonTextColor,
  });

  final Color buttonBackgroudColor;
  final Color buttonTextColor;
  final String buttonTitle;
  final Function onPressed;

  @override
  State<CustomButton> createState() => _CustomButtonState();
}

class _CustomButtonState extends State<CustomButton> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 343,
      height: 56,
      child: ElevatedButton(
        onPressed: () {
          widget.onPressed();
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: widget.buttonBackgroudColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
        ),
        child: Text(
          widget.buttonTitle,
          style: GoogleFonts.aBeeZee(
            color: widget.buttonTextColor,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
