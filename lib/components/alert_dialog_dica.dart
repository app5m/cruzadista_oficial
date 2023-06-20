import 'package:cruzadista/components/fonte_size.dart';
import 'package:flutter/material.dart';

import 'colors.dart';

class DialogDic extends StatefulWidget {
  Color? colorCell;
  Color? colorText;

  final Function(bool, bool, bool) onContainerFilter;

  DialogDic(
      {Key? key,
        this.colorCell,
        this.colorText,
        required this.onContainerFilter})
      : super(key: key);

  @override
  State<DialogDic> createState() => _DialogDicState();
}

class _DialogDicState extends State<DialogDic> {
  bool reveltionWord = false;
  bool reveltionLetre = false;
  bool reveltionGrade = false;

  @override
  Widget build(BuildContext context) {
    return FractionallySizedBox(
      widthFactor: 0.8,
      heightFactor: 0.4,
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
                    icon: Icon(
                      Icons.close,
                      color: widget.colorText == Colors.white
                          ? Colors.black
                          : widget.colorText,
                    ),
                    onPressed: () {

                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
              SizedBox(height: 4),
              Center(
                  child: Text(
                    'Selecione a dica',
                    style: TextStyle(
                        fontWeight: FontWeight.w600,
                        color: widget.colorText == Colors.white
                            ? Colors.black
                            : widget.colorText,
                        fontFamily: 'Poppins',
                        fontSize: FontSizes.titulo),
                  )),
              SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    reveltionWord = true;
                    reveltionLetre = false;
                    reveltionGrade = false;
                  });
                  widget.onContainerFilter(reveltionWord, reveltionLetre, reveltionGrade);
                  Navigator.of(context).pop();
                },
                child: Text(
                  'Revelar Palavra',
                  style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontFamily: 'Poppins',
                      color: widget.colorText,
                      fontSize: FontSizes.subTitulo),
                ),
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
                  setState(() {
                    reveltionWord = false;
                    reveltionLetre = true;
                    reveltionGrade = false;
                  });
                  widget.onContainerFilter(reveltionWord, reveltionLetre, reveltionGrade);
                  Navigator.of(context).pop();
                },
                child: Text(
                  'Relevar Letra',
                  style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontFamily: 'Poppins',
                      color: widget.colorText,
                      fontSize: FontSizes.subTitulo),
                ),
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
                  setState(() {
                    reveltionWord = false;
                    reveltionLetre = false;
                    reveltionGrade = true;
                  });
                  widget.onContainerFilter(reveltionWord, reveltionLetre, reveltionGrade);
                  Navigator.of(context).pop();
                },
                child: Text(
                  'Relevar Tudo',
                  style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontFamily: 'Poppins',
                      color: widget.colorText,
                      fontSize: FontSizes.subTitulo),
                ),
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
