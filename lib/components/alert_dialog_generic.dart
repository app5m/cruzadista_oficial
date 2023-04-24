import 'package:flutter/material.dart';

import 'colors.dart';
import 'fonte_size.dart';

class DialogGeneric extends StatefulWidget {
  String? title;
  String? content;
  TextButton? btnBack;
  TextButton? btnConfirm;

  DialogGeneric({
    Key? key,
    this.title,
    this.content,
    this.btnBack,
    this.btnConfirm,
  });

  // DialogGeneric({Key? key}) : super(key: key);

  @override
  State<DialogGeneric> createState() => _DialogGenericState();
}

class _DialogGenericState extends State<DialogGeneric> {
  @override
  Widget build(BuildContext context) {
    return Center(
        child: SizedBox(
            height: 280,
            child: Card(
              color: MyColors.colorOnPrimary,
              margin: EdgeInsets.all(16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      widget.title!,
                      style: TextStyle(
                        fontSize: FontSizes.titulo,
                        fontWeight: FontWeight.w600,
                        fontFamily: 'Poppins',
                      ),
                    ),
                    Text(
                      widget.content!,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: FontSizes.subTitulo,
                        fontWeight: FontWeight.w400,
                        fontFamily: 'Poppins',
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        widget.btnBack!,
                        widget.btnConfirm!
                      ],
                    )
                  ],
                ),
              ),
            )));
  }
}
