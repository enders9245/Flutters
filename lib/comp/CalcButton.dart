import 'package:flutter/material.dart';

class CalcButton extends StatelessWidget {
  final String? text;
  final int fillColor;
  final int textColor;
  final double textSize;
  final Function(String)? callback;

  const CalcButton({
    Key? key,
    this.text,
    this.fillColor = 0xFF1976D2,
    this.textColor = 0xFFFFFFFF,
    this.textSize = 22,
    this.callback,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final useMaterial3 = Theme.of(context).useMaterial3;

    return Container(
      margin: const EdgeInsets.all(6),
      width: 70,
      height: 70,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Color(fillColor),
          foregroundColor: Color(textColor),
          elevation: 3,
          shape: useMaterial3
              ? const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(16)),
          )
              : const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(4)),
          ),
          textStyle: TextStyle(
            fontSize: textSize,
            fontWeight: FontWeight.w600,
          ),
        ),
        onPressed: () {
          if (callback != null && text != null) callback!(text!);
        },
        child: Text(text ?? ''),
      ),
    );
  }
}
