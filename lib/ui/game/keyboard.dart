import 'package:flutter/material.dart';

class CustomKeyboard extends StatelessWidget {
  final bool changeKeyboard;
  final Color colorBackground;
  final Color colorCell;
  final Function(String) onKeyPressed;

  const CustomKeyboard({
    required this.changeKeyboard,
    required this.onKeyPressed,
    required this.colorBackground,
    required this.colorCell,
  });

  @override
  Widget build(BuildContext context) {
    final keyboardLayout = changeKeyboard
        ? const [
            ["À", "Á", "Â", "Ã", "È", "É", "Ê", "Ì", "Í", "Î"],
            ["Ò", "Ó", "Ô", "Õ", "Ù", "Ú", "Û", "Ñ", "Ý"],
            ["SHIFT", "BACKSPACE"],
          ]
        : const [
            ["Q", "W", "E", "R", "T", "Y", "U", "I", "O", "P"],
            ["A", "S", "D", "F", "G", "H", "J", "K", "L", "Ç"],
            ["Z", "X", "C", "V", "B", "N", "M"],
            ["SHIFT", "BACKSPACE"],
          ];

    return Container(
      decoration: BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(16.0),
          topRight: Radius.circular(16.0),
        ),
      ),
      child: Column(
        children: keyboardLayout.map((row) {
          return Row(
            children: row.map((key) {
              return Expanded(
                child: GestureDetector(
                  onTap: () {
                    onKeyPressed(key);
                  },
                  child: Container(
                    height: 50,
                    color: Colors.transparent,
                    child: Center(
                      child:  key == "SHIFT"
                          ? Icon(Icons.arrow_upward, color: colorCell,) // Ícone para SHIFT
                          : key == "BACKSPACE"
                          ? Icon(Icons.backspace,color: colorCell,) // Ícone para BACKSPACE
                          : Text(
                        key,
                        style: TextStyle(fontSize: 16,color: colorCell,),
                      ),
                    ),
                  ),
                ),
              );
            }).toList(),
          );
        }).toList(),
      ),
    );
  }
}
