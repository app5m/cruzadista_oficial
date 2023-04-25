import 'package:flutter/material.dart';

import 'colors.dart';

class DialogDic extends StatefulWidget {
  Color? colorCell;
  Color? colorText;
  DialogDic({Key? key, this.colorCell, this.colorText,}) : super(key: key);

  @override
  State<DialogDic> createState() => _DialogDicState();
}

class _DialogDicState extends State<DialogDic> {
  @override
  Widget build(BuildContext context) {
    return FractionallySizedBox(
      widthFactor: 0.8,
      heightFactor: 0.3,
      child: Card(
        color: widget.colorCell,
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
                    icon: Icon(Icons.close, color: widget.colorText == Colors.white ? Colors.black : widget.colorText,),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
              SizedBox(height: 4),
              Center(child: Text('Selecione a dica', style: TextStyle(
                fontWeight: FontWeight.w600,
                color: widget.colorText == Colors.white ? Colors.black : widget.colorText,
                fontFamily: 'Poppins',
              ),)),
              SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('Revelar Palavra', style: TextStyle(
                  fontWeight: FontWeight.w600,
                  color: widget.colorText,
                  fontFamily: 'Poppins',
                ),
                ),
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
                child: Text('Relevar Letra' , style: TextStyle(
                  fontWeight: FontWeight.w600,
                  color: widget.colorText,
                  fontFamily: 'Poppins',
                ),
                ),
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

