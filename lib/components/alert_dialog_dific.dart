import 'package:flutter/material.dart';

import '../ui/home.dart';
import 'colors.dart';
import 'fonte_size.dart';

class DialogDific extends StatelessWidget {
  late final Function(int, int) onDifficultySelected;
  late int screenType;
  int typeEsay = 1;
  int typeMedium = 2;
  int typeDific = 3;
  int type = 1;

  DialogDific({required this.screenType, required this.onDifficultySelected});



  @override
  Widget build(BuildContext context) {
    return FractionallySizedBox(
      widthFactor: 0.8,
      heightFactor: 0.4,
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
              Center(
                  child: Text(
                'Escolha a dificuldade',
                style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontFamily: 'Poppins',
                    fontSize: FontSizes.titulo),
              )),
              SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  if(screenType == 0){
                    type = 1;
                  }else{
                    type = 2;
                  }
                  onDifficultySelected(type, typeEsay);
                  Navigator.of(context).pop();
                },
                child: Text('Fácil',
                  style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontFamily: 'Poppins',
                      fontSize: FontSizes.subTitulo),),
                style: ButtonStyle(
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                  backgroundColor:
                      MaterialStateProperty.all(MyColors.colorPrimary),
                  padding: MaterialStateProperty.all(
                      const EdgeInsets.symmetric(vertical: 10)),
                ),
              ),
              SizedBox(height: 8),
              ElevatedButton(
                onPressed: () {
                  if(screenType == 0){
                    type = 1;
                  }else{
                    type = 2;
                  }
                  onDifficultySelected(type, typeMedium);
                  Navigator.of(context).pop();
                },
                child: Text('Médio',
                  style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontFamily: 'Poppins',
                      fontSize: FontSizes.subTitulo),),
                style: ButtonStyle(
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                  backgroundColor:
                      MaterialStateProperty.all(MyColors.colorPrimary),
                  padding: MaterialStateProperty.all(
                      const EdgeInsets.symmetric(vertical: 10)),
                ),
              ),
              SizedBox(height: 8),
              ElevatedButton(
                onPressed: () {
                  if(screenType == 0){
                    type = 1;
                  }else{
                    type = 2;
                  }
                  onDifficultySelected(type, typeDific);
                  Navigator.of(context).pop();
                },
                child: Text('Difícil',
                  style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontFamily: 'Poppins',
                      fontSize: FontSizes.subTitulo),),
                style: ButtonStyle(
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                  backgroundColor:
                      MaterialStateProperty.all(MyColors.colorPrimary),
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
