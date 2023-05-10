import 'dart:io';

import 'package:cruzadista/components/alert_dialog_generic.dart';
import 'package:cruzadista/components/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:flutter_svg/svg.dart';

import '../components/fonte_size.dart';
import '../config/preferences.dart';

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
                InkWell(
                  child: Row(
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
                              child: SizedBox(
                                width: 1,
                                height: 50,
                              ),
                            )),
                      ),
                      SvgPicture.asset(
                        'icons/user.svg',
                        height: 35,
                        width: 35,
                      ),
                      SizedBox(width: 8),
                      Text(
                        'Meu Perfil',
                        style: TextStyle(
                          fontSize: FontSizes.subTitulo,
                          fontWeight: FontWeight.w500,
                          fontFamily: 'Poppins',
                        ),
                      )
                    ],
                  ),
                  onTap: () {
                    Navigator.pushNamed(context, "/ui/myProfile");
                  },
                ),
                InkWell(
                  child: Row(
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
                              child: SizedBox(
                                width: 1,
                                height: 50,
                              ),
                            )),
                      ),
                      SvgPicture.asset(
                        'icons/share.svg',
                        height: 35,
                        width: 35,
                      ),
                      SizedBox(width: 8),
                      Text(
                        'Compatilhar Jogo',
                        style: TextStyle(
                          fontSize: FontSizes.subTitulo,
                          fontWeight: FontWeight.w500,
                          fontFamily: 'Poppins',
                        ),
                      )
                    ],
                  ),
                  onTap: () {},
                ),
                InkWell(
                  child: Row(
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
                              child: SizedBox(
                                width: 1,
                                height: 50,
                              ),
                            )),
                      ),
                      SvgPicture.asset(
                        'icons/reset2.svg',
                        height: 35,
                        width: 35,
                      ),
                      SizedBox(width: 8),
                      Text(
                        'Zerar Prtogresso',
                        style: TextStyle(
                          fontSize: FontSizes.subTitulo,
                          fontWeight: FontWeight.w500,
                          fontFamily: 'Poppins',
                        ),
                      )
                    ],
                  ),
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return DialogGeneric(
                          title: 'Atenção!',
                          content:
                              'Você tem certeza que deseja zera seu progesso?',
                          btnBack: TextButton(
                              style: TextButton.styleFrom(
                                  foregroundColor: MyColors.colorPrimary),
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              child: Text(
                                'Não',
                                style: TextStyle(
                                  fontSize: FontSizes.subTitulo,
                                  fontWeight: FontWeight.w600,
                                  fontFamily: 'Poppins',
                                ),
                              )),
                          btnConfirm: TextButton(
                              style: TextButton.styleFrom(
                                  foregroundColor: MyColors.colorPrimary),
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              child: Text(
                                'Sim',
                                style: TextStyle(
                                  fontSize: FontSizes.subTitulo,
                                  fontWeight: FontWeight.w600,
                                  fontFamily: 'Poppins',
                                ),
                              )),
                        );
                      },
                    );
                  },
                ),
                InkWell(
                  child: Row(
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
                              child: SizedBox(
                                width: 1,
                                height: 50,
                              ),
                            )),
                      ),
                      SvgPicture.asset(
                        'icons/trash.svg',
                        height: 35,
                        width: 35,
                      ),
                      SizedBox(width: 8),
                      Text(
                        'Desativar Conta',
                        style: TextStyle(
                          fontSize: FontSizes.subTitulo,
                          fontWeight: FontWeight.w500,
                          fontFamily: 'Poppins',
                        ),
                      )
                    ],
                  ),
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return DialogGeneric(
                          title: 'Atenção!',
                          content:
                              'Você tem certeza que deseja deativar sua conta?',
                          btnBack: TextButton(
                              style: TextButton.styleFrom(
                                  foregroundColor: MyColors.colorPrimary),
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              child: Text(
                                'Não',
                                style: TextStyle(
                                  fontSize: FontSizes.subTitulo,
                                  fontWeight: FontWeight.w600,
                                  fontFamily: 'Poppins',
                                ),
                              )),
                          btnConfirm: TextButton(
                              style: TextButton.styleFrom(
                                  foregroundColor: MyColors.colorPrimary),
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              child: Text(
                                'Sim',
                                style: TextStyle(
                                  fontSize: FontSizes.subTitulo,
                                  fontWeight: FontWeight.w600,
                                  fontFamily: 'Poppins',
                                ),
                              )),
                        );
                      },
                    );
                  },
                ),
                InkWell(
                  child: Row(
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
                              child: SizedBox(
                                width: 1,
                                height: 50,
                              ),
                            )),
                      ),
                      SvgPicture.asset(
                        'icons/exit.svg',
                        height: 35,
                        width: 35,
                      ),
                      SizedBox(width: 8),
                      Text(
                        'Sair',
                        style: TextStyle(
                          fontSize: FontSizes.subTitulo,
                          fontWeight: FontWeight.w500,
                          fontFamily: 'Poppins',
                        ),
                      )
                    ],
                  ),
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return DialogGeneric(
                          title: 'Atenção!',
                          content:
                              'Você tem certeza que deseja realizar seu logout?',
                          btnBack: TextButton(
                              style: TextButton.styleFrom(
                                  foregroundColor: MyColors.colorPrimary),
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              child: Text(
                                'Não',
                                style: TextStyle(
                                  fontSize: FontSizes.subTitulo,
                                  fontWeight: FontWeight.w600,
                                  fontFamily: 'Poppins',
                                ),
                              )),
                          btnConfirm: TextButton(
                              style: TextButton.styleFrom(
                                  foregroundColor: MyColors.colorPrimary),
                              onPressed: () async {
                                await Preferences.init();
                                await Preferences.clearUserData();
                                SystemNavigator.pop();
                                // if(Platform.isAndroid){
                                //   FlutterExitApp.exitApp();
                                // }else{
                                //   FlutterExitApp.exitApp(iosForceExit: true);
                                // }
                              },
                              child: Text(
                                'Sim',
                                style: TextStyle(
                                  fontSize: FontSizes.subTitulo,
                                  fontWeight: FontWeight.w600,
                                  fontFamily: 'Poppins',
                                ),
                              )),
                        );
                      },
                    );
                  },
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
