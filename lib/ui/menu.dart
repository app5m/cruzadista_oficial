import 'package:cruzadista/components/colors.dart';
import 'package:flutter/material.dart';

import '../components/fonte_size.dart';

class Menu extends StatefulWidget {
  const Menu({Key? key}) : super(key: key);

  @override
  State<Menu> createState() => _MenuState();
}

class _MenuState extends State<Menu> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                    "Menu",
                    style: TextStyle(
                      fontSize: FontSizes.titulo,
                      fontWeight: FontWeight.w600,
                      fontFamily: 'Poppins',
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 16),
            Column(
              children: [
                Row(

                mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      alignment: Alignment.centerLeft,
                      child: Card(
                          color: MyColors.colorPrimary,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.only(
                                topRight: Radius.circular(8),
                                bottomRight: Radius.circular(8)),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.only(left: 2, right: 2),
                            child: SizedBox(width: 1, height: 50,),
                          )),
                    ),
                    Icon(Icons.person, size: 35,),
                    Text('Meu Perfil', style: TextStyle(
                      fontSize: FontSizes.subTitulo,
                      fontWeight: FontWeight.w400,
                      fontFamily: 'Poppins',
                    ),)
                  ],
                ),
                Row(

                mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      alignment: Alignment.centerLeft,
                      child: Card(
                          color: MyColors.colorPrimary,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.only(
                                topRight: Radius.circular(8),
                                bottomRight: Radius.circular(8)),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.only(left: 2, right: 2),
                            child: SizedBox(width: 1, height: 50,),
                          )),
                    ),
                    Icon(Icons.share_outlined, size: 35,),
                    Text('Compatilhar Jogo', style: TextStyle(
                      fontSize: FontSizes.subTitulo,
                      fontWeight: FontWeight.w400,
                      fontFamily: 'Poppins',
                    ),)
                  ],
                ),
                Row(

                mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      alignment: Alignment.centerLeft,
                      child: Card(
                          color: MyColors.colorPrimary,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.only(
                                topRight: Radius.circular(8),
                                bottomRight: Radius.circular(8)),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.only(left: 2, right: 2),
                            child: SizedBox(width: 1, height: 50,),
                          )),
                    ),
                    Icon(Icons.lock_reset_outlined, size: 35,),
                    Text('Zerar Prtogresso', style: TextStyle(
                      fontSize: FontSizes.subTitulo,
                      fontWeight: FontWeight.w400,
                      fontFamily: 'Poppins',
                    ),)
                  ],
                ),
                Row(

                mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      alignment: Alignment.centerLeft,
                      child: Card(
                          color: MyColors.colorPrimary,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.only(
                                topRight: Radius.circular(8),
                                bottomRight: Radius.circular(8)),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.only(left: 2, right: 2),
                            child: SizedBox(width: 1, height: 50,),
                          )),
                    ),
                    Icon(Icons.restore_from_trash_outlined, size: 35,),
                    Text('Desativar Conta', style: TextStyle(
                      fontSize: FontSizes.subTitulo,
                      fontWeight: FontWeight.w400,
                      fontFamily: 'Poppins',
                    ),)
                  ],
                ),
                Row(

                mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      alignment: Alignment.centerLeft,
                      child: Card(
                          color: MyColors.colorPrimary,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.only(
                                topRight: Radius.circular(8),
                                bottomRight: Radius.circular(8)),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.only(left: 2, right: 2),
                            child: SizedBox(width: 1, height: 50,),
                          )),
                    ),
                    Icon(Icons.exit_to_app_rounded, size: 35,),
                    Text('Sair', style: TextStyle(
                      fontSize: FontSizes.subTitulo,
                      fontWeight: FontWeight.w400,
                      fontFamily: 'Poppins',
                    ),)
                  ],
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
