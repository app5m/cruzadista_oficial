import 'package:cruzadista/components/alert_dialog_dica.dart';
import 'package:cruzadista/components/colors.dart';
import 'package:flutter/material.dart';
import '../components/crosswordview.dart';
import '../components/fonte_size.dart';


class Game extends StatefulWidget {
  const Game({Key? key}) : super(key: key);

  @override
  State<Game> createState() => _GameState();
}

class _GameState extends State<Game> {

  late List<int> _gridElements;

  late List<String> _acrossClues;

  late List<String> _downClues;
  var _theme = Colors.white;
  var _colorCell = Colors.white;
  var _themeDark = MyColors.darkMode;
  @override
  void initState() {
    super.initState();



    _gridElements = <int>[];
    for (int i = 0; i < 8; i++) {
      for (int j = 0; j < 8; j++) {
        if (i + j == 6 || i + j == 3) {
          _gridElements.add(0);
        } else {
          _gridElements.add(1);
        }
      }
    }

    _acrossClues = <String>[];
    _acrossClues.add('Hello');
    _acrossClues.add('Another one');
    _acrossClues.add('Cryptic');

    _downClues = <String>[];
    _downClues.add('Yellow');
    _downClues.add('Brown');
    _downClues.add('Sweet');
    _downClues.add('However');
    _downClues.add('Tunnel');
    _downClues.add('Train');
    _downClues.add('On your desk');
    _downClues.add('Nursery');
    _downClues.add('On the loose');
    _downClues.add('Oliver Twist');
    _downClues.add('Last one');
    _downClues.add('Last one');
  }



  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: _theme,
      body: Padding(
          padding: EdgeInsets.only(top: 50),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  IconButton(
                    icon: Icon(Icons.close),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                ],
              ),
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 16),
                    child: Text(
                      "N°1",
                      style: TextStyle(
                        fontSize: FontSizes.titulo,
                        fontWeight: FontWeight.w600,
                        fontFamily: 'Poppins',
                      ),
                    ),
                  ),
                  Spacer(),
                  Row(
                    children: [
                    ElevatedButton(onPressed: (){
                      setState(() {
                        if(_theme == Colors.white){
                          _colorCell = MyColors.colorCellDark;
                          _theme = _themeDark!;
                        }else{
                          _theme = Colors.white;
                          _colorCell = Colors.white;
                        }
                      });
                    }, style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.black,
                      ),
                      child: Text(
                      "MODO NOTURNO",

                      style: TextStyle(
                        color: _colorCell,
                        fontSize: FontSizes.textoNormal,
                        fontWeight: FontWeight.w400,
                        fontFamily: 'Poppins',
                      ),
                    ),),
                    SizedBox(width: 4,),
                    ElevatedButton(onPressed: (){
                      showDialog(
                        context: context,
                        builder: (_) => DialogDica(),
                      );
                    },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.black,
                      ),
                        child: Text(
                      "DICAS",
                      style: TextStyle(
                        color: _colorCell,
                        fontSize: FontSizes.textoNormal,
                        fontWeight: FontWeight.w400,
                        fontFamily: 'Poppins',
                      ),
                    ),
                    ),
                      SizedBox(width: 16,),
                  ],)
                ],
              ),
              Expanded(
                child: Column(
                  children: [
                    CrosswordView(gridElements: _gridElements, color: _theme, colorCell: _colorCell,),
                  Expanded(
                    child: CluesView(
                        acrossClues: _acrossClues, downClues: _downClues),
                  ),
                  KeyboardView(),
                ],
                ),
              )
            ],
          ),
        ),
    );
  }
}
