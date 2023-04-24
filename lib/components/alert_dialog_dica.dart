import 'package:flutter/material.dart';

import 'colors.dart';

class DialogDica extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FractionallySizedBox(
      widthFactor: 0.8,
      heightFactor: 0.3,
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  IconButton(
                    icon: Icon(Icons.close),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
              SizedBox(height: 4),
              Center(child: Text('Selecione a dica', style: TextStyle(
                fontWeight: FontWeight.w600,
                fontFamily: 'Poppins',
              ),)),
              SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('Revelar Palavra'),
                style: ButtonStyle(
                  shape: MaterialStateProperty.all<
                      RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                  backgroundColor: MaterialStateProperty.all(
                      MyColors.colorPrimary),
                  padding: MaterialStateProperty.all(
                      const EdgeInsets.symmetric(vertical: 10)),
                ),
              ),
              SizedBox(height: 8),
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('Relevar Letra'),
                style: ButtonStyle(
                  shape: MaterialStateProperty.all<
                      RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                  backgroundColor: MaterialStateProperty.all(
                      MyColors.colorPrimary),
                  padding: MaterialStateProperty.all(
                      const EdgeInsets.symmetric(vertical: 10)),
                ),
              ),

            ],
          ),
        ),

      ),
    );
  }
}
