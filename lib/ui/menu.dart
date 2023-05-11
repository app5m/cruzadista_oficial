import 'dart:convert';
import 'dart:io';

import 'package:cruzadista/components/alert_dialog_generic.dart';
import 'package:cruzadista/components/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../components/fonte_size.dart';
import '../config/constants.dart';
import '../config/preferences.dart';
import '../config/requests.dart';
import '../model/user.dart';

class Menu extends StatefulWidget {
  const Menu({Key? key}) : super(key: key);

  @override
  State<Menu> createState() => _MenuState();
}

class _MenuState extends State<Menu> {
  final requestsWebServices = RequestsWebServices(WSConstantes.URLBASE);

  Future<String?> zeraProgress() async {
    await Preferences.init();
    var _userId = await Preferences.getUserData()!.id;
    final user = User();

      final body = {
        WSConstantes.ID: _userId,
        WSConstantes.TOKENID: WSConstantes.TOKEN
      };

      final response = await requestsWebServices.sendPostRequest(
          WSConstantes.ZERA_CRUZADA, body);
      final decodedResponse = jsonDecode(response);
      if (decodedResponse.isNotEmpty) {
        user.status = decodedResponse[0]['status'];
        user.msg = decodedResponse[0]['msg'];

        if (user.status == "01") {
          setState(() async {
            Fluttertoast.showToast(
              msg: user.msg!,
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
            );
            // await Preferences.clearUserData();
            // SystemNavigator.pop();
            Navigator.popUntil(context, ModalRoute.withName('/ui/home'));
            Navigator.pushReplacementNamed(context, '/ui/home');

          });
        } else {
          setState(() {
            Fluttertoast.showToast(
              msg: user.msg!,
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
            );
          });
        }
        print('Status ${user.status}, Mensagem: ${user.msg}');
      }


  }

  Future<String?> desativeAccount() async {
    await Preferences.init();
    var _userId = await Preferences.getUserData()!.id;
    final user = User();

    final body = {
      WSConstantes.ID: _userId,
      WSConstantes.TOKENID: WSConstantes.TOKEN
    };

    final response = await requestsWebServices.sendPostRequest(
        WSConstantes.DESATIVE_ACCOUNT, body);
    final decodedResponse = jsonDecode(response);
    if (decodedResponse.isNotEmpty) {
      user.status = decodedResponse[0]['status'];
      user.msg = decodedResponse[0]['msg'];

      if (user.status == "01") {
        setState(() async {
          Fluttertoast.showToast(
            msg: user.msg!,
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
          );
          await Preferences.clearUserData();
          SystemNavigator.pop();

        });
      } else {
        setState(() {
          Fluttertoast.showToast(
            msg: user.msg!,
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
          );
        });
      }
      print('Status ${user.status}, Mensagem: ${user.msg}');
    }


  }
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
                                zeraProgress();
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
                                desativeAccount();
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
