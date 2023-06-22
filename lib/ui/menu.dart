import 'dart:convert';
import 'dart:io';

import 'package:cruzadista/components/alert_dialog_generic.dart';
import 'package:cruzadista/components/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_share/flutter_share.dart';

import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:share_plus/share_plus.dart';

import '../components/fonte_size.dart';
import '../config/constants.dart';
import '../config/preferences.dart';
import '../config/requests.dart';
import '../model/user.dart';

class Menu extends StatefulWidget {
  bool? isloggin;
  Menu({Key? key, this.isloggin}) : super(key: key);

  @override
  State<Menu> createState() => _MenuState();
}

class _MenuState extends State<Menu> {
  final requestsWebServices = RequestsWebServices(WSConstantes.URLBASE);
  bool isLoggedIn = false;
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

  Future<void> initilPreferences() async {
    await Preferences.init();
    isLoggedIn = await Preferences.getLogin();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initilPreferences();
  }

  @override
  Widget build(BuildContext context) {
    isLoggedIn = widget.isloggin!;
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
                if(isLoggedIn)
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
                  onTap: () {
                    share();
                  },
                ),
                if(isLoggedIn)
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
                        'Zerar Progresso',
                        style: TextStyle(
                          fontSize: FontSizes.subTitulo,
                          fontWeight: FontWeight.w500,
                          fontFamily: 'Poppins',
                        ),
                      )
                    ],
                  ),
                  onTap: () {
                    _showModalBottomSheetZero(context);
                  },
                ),
                if(isLoggedIn)
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
                    _showModalBottomSheetDesative(context);
                  },
                ),
                if(isLoggedIn)
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
                    _showModalBottomSheetExit(context);
                  },
                ),
                if(!isLoggedIn)
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
                          'icons/login.svg',
                          height: 35,
                          width: 35,
                        ),
                        SizedBox(width: 8),
                        Text(
                          'Login',
                          style: TextStyle(
                            fontSize: FontSizes.subTitulo,
                            fontWeight: FontWeight.w500,
                            fontFamily: 'Poppins',
                          ),
                        )
                      ],
                    ),
                    onTap: () {
                      Navigator.pushNamedAndRemoveUntil(
                        context,
                        '/ui/login',
                            (Route<dynamic> route) => false,
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

  void _showModalBottomSheetExit(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
        topLeft: Radius.circular(16),
        topRight: Radius.circular(16),
      )),
      builder: (BuildContext bc) {
        return Container(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                padding: EdgeInsets.only(top: 8),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Atenção",
                          style: TextStyle(
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w600,
                              fontSize: 16,
                              color: Color(0xff000000)),
                        ),
                      ],
                    ),
                    Divider(
                      thickness: 1,
                    ),
                    SizedBox(height: 16),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Text(
                        "Você tem certeza que deseja sair?",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w400,
                            fontSize: 14,
                            color: Color(0xff000000)),
                      ),
                    ),
                    SizedBox(height: 16),
                    Row(
                      children: [
                        Spacer(),
                        ElevatedButton(
                          onPressed: () async {
                            await Preferences.init();
                            await Preferences.clearUserData();
                            Navigator.pushNamedAndRemoveUntil(
                              context,
                              '/ui/login',
                              (Route<dynamic> route) => false,
                            );
                          },
                          child: Text("Sim"),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Color(0xff000000),
                          ),
                        ),
                        SizedBox(
                          width: 8,
                        ),
                        TextButton(
                          onPressed: () => Navigator.of(context).pop(false),
                          child: Text(
                            "Não",
                            style: TextStyle(color: Color(0xff000000)),
                          ),
                        ),
                        SizedBox(
                          width: 8,
                        ),
                      ],
                    ),
                    SizedBox(height: 16)
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
  void _showModalBottomSheetGoLgin(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(16),
            topRight: Radius.circular(16),
          )),
      builder: (BuildContext bc) {
        return Container(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                padding: EdgeInsets.only(top: 8),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Atenção",
                          style: TextStyle(
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w600,
                              fontSize: 16,
                              color: Color(0xff000000)),
                        ),
                      ],
                    ),
                    Divider(
                      thickness: 1,
                    ),
                    SizedBox(height: 16),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Text(
                        "Para realizar essa ação é necessário efetuar login",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w400,
                            fontSize: 14,
                            color: Color(0xff000000)),
                      ),
                    ),
                    SizedBox(height: 16),
                    Row(
                      children: [
                        Spacer(),
                        ElevatedButton(
                          onPressed: () {
                            // Coloca para ir para login
                            Navigator.pushNamed(context, "/ui/login");
                          },
                          child: Text("Login/Cadastro"),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Color(0xff000000),
                          ),
                        ),
                        SizedBox(
                          width: 8,
                        ),
                        TextButton(
                          onPressed: () => Navigator.of(context).pop(false),
                          child: Text(
                            "Não",
                            style: TextStyle(color: Color(0xff000000)),
                          ),
                        ),
                        SizedBox(
                          width: 8,
                        ),
                      ],
                    ),
                    SizedBox(height: 16)
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
  void _showModalBottomSheetZero(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
        topLeft: Radius.circular(16),
        topRight: Radius.circular(16),
      )),
      builder: (BuildContext bc) {
        return Container(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                padding: EdgeInsets.only(top: 8),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Atenção",
                          style: TextStyle(
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w600,
                              fontSize: 16,
                              color: Color(0xff000000)),
                        ),
                      ],
                    ),
                    Divider(
                      thickness: 1,
                    ),
                    SizedBox(height: 16),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Text(
                        "Você tem certeza que deseja zera seu progesso?",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w400,
                            fontSize: 14,
                            color: Color(0xff000000)),
                      ),
                    ),
                    SizedBox(height: 16),
                    Row(
                      children: [
                        Spacer(),
                        ElevatedButton(
                          onPressed: () async {
                            zeraProgress();
                          },
                          child: Text("Sim"),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Color(0xff000000),
                          ),
                        ),
                        SizedBox(
                          width: 8,
                        ),
                        TextButton(
                          onPressed: () => Navigator.of(context).pop(false),
                          child: Text(
                            "Não",
                            style: TextStyle(color: Color(0xff000000)),
                          ),
                        ),
                        SizedBox(
                          width: 8,
                        ),
                      ],
                    ),
                    SizedBox(height: 16)
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  void _showModalBottomSheetDesative(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
        topLeft: Radius.circular(16),
        topRight: Radius.circular(16),
      )),
      builder: (BuildContext bc) {
        return Container(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                padding: EdgeInsets.only(top: 8),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Atenção",
                          style: TextStyle(
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w600,
                              fontSize: 16,
                              color: Color(0xff000000)),
                        ),
                      ],
                    ),
                    Divider(
                      thickness: 1,
                    ),
                    SizedBox(height: 16),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Text(
                        "Você tem certeza que deseja deativar sua conta?",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w400,
                            fontSize: 14,
                            color: Color(0xff000000)),
                      ),
                    ),
                    SizedBox(height: 16),
                    Row(
                      children: [
                        Spacer(),
                        ElevatedButton(
                          onPressed: () async {
                            desativeAccount();
                          },
                          child: Text("Sim"),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Color(0xff000000),
                          ),
                        ),
                        SizedBox(
                          width: 8,
                        ),
                        TextButton(
                          onPressed: () => Navigator.of(context).pop(false),
                          child: Text(
                            "Não",
                            style: TextStyle(color: Color(0xff000000)),
                          ),
                        ),
                        SizedBox(
                          width: 8,
                        ),
                      ],
                    ),
                    SizedBox(height: 16)
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  void _showModalBottomSheetShared(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
        topLeft: Radius.circular(16),
        topRight: Radius.circular(16),
      )),
      builder: (BuildContext bc) {
        return Container(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                padding: EdgeInsets.only(top: 8),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Compatilhar jogo",
                          style: TextStyle(
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w600,
                              fontSize: 16,
                              color: Color(0xff000000)),
                        ),
                      ],
                    ),
                    Divider(
                      thickness: 1,
                    ),
                    SizedBox(height: 16),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Text(
                        "Baixe o APP Cruzadista nas lojas PLAY STORE ou APP STORE e divirta-se!",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w400,
                            fontSize: 14,
                            color: Color(0xff000000)),
                      ),
                    ),
                    SizedBox(height: 16),
                    Row(
                      children: [
                        Spacer(),
                        ElevatedButton(
                          onPressed: () {
                            share();
                          },
                          child: Text("Sim"),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Color(0xff000000),
                          ),
                        ),
                        SizedBox(
                          width: 8,
                        ),
                        TextButton(
                          onPressed: () => Navigator.of(context).pop(false),
                          child: Text(
                            "Não",
                            style: TextStyle(color: Color(0xff000000)),
                          ),
                        ),
                        SizedBox(
                          width: 8,
                        ),
                      ],
                    ),
                    SizedBox(height: 16)
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Future<void> share() async {
    await FlutterShare.share(
        title: 'Cruzadista',
        text: 'Baixe o APP Cruzadista nas lojas PLAY STORE ou APP STORE e divirta-se!',
        linkUrl: '',
        chooserTitle: 'Example Chooser Title');
  }
}
