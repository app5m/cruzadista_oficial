import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../components/colors.dart';
import '../components/fonte_size.dart';
import '../config/constants.dart';
import '../config/preferences.dart';
import '../config/requests.dart';
import '../model/user.dart';

class UpdatePassword extends StatefulWidget {
  const UpdatePassword({Key? key}) : super(key: key);

  @override
  State<UpdatePassword> createState() => _UpdatePasswordState();
}

class _UpdatePasswordState extends State<UpdatePassword> {
  final user = User();
  final requestsWebServices = RequestsWebServices(WSConstantes.URLBASE);

  TextEditingController _passwordUpdateController = TextEditingController();
  TextEditingController _coPasswordUpdateController = TextEditingController();

  Future<String?> updatePassword(String password, String coPassword) async {
    await Preferences.init();
    var _userId = await Preferences.getUserData()!.id;
    String passwordValid = '';
    if (validationPassword(password, coPassword)) {
      passwordValid = password;
      final body = {
        WSConstantes.ID: _userId,
        WSConstantes.PASSWORD: passwordValid,
        WSConstantes.TOKENID: WSConstantes.TOKEN
      };

      final response = await requestsWebServices.sendPostRequest(
          WSConstantes.UPDATE_PASSWORD, body);
      final decodedResponse = jsonDecode(response);
      if (decodedResponse.isNotEmpty) {
        user.status = decodedResponse[0]['status'];
        user.msg = decodedResponse[0]['msg'];

        if (user.status == "01") {
          setState(() {
            Fluttertoast.showToast(
              msg: user.msg!,
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
            );
            Navigator.pop(context);
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

  }

  bool validationPassword(String password, String coPassword) {
    bool validation = false;
    if (coPassword != password) {
      setState(() {
        Fluttertoast.showToast(
          msg: WSConstantes.MSG_CO_PASSWORD_INVALIDO,
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
        );

        validation = false;
      });
    } else {
      validation = true;
    }
    return validation;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
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
                      "Atualizar Senha",
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
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Card(
                      elevation: 2,
                      color: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                        child: TextField(
                          controller: _passwordUpdateController,
                          obscureText: true,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: 'Senha',
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Card(
                      elevation: 2,
                      color: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                        child: TextField(
                          controller: _coPasswordUpdateController,
                          obscureText: true,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: 'Confirmar senha',
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(top: 16, left: 16, right: 16),
                    child: Container(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          setState(() {
                            updatePassword(_passwordUpdateController.text,_coPasswordUpdateController.text);
                          });

                        },
                        child: Text(
                          "ATUALIZAR SENHA",
                          style: TextStyle(
                              color: MyColors.colorOnPrimary,
                              fontFamily: 'Poppins',
                              fontSize: 16),
                        ),
                        style: ButtonStyle(
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20.0),
                            ),
                          ),
                          backgroundColor:
                              MaterialStateProperty.all(MyColors.colorPrimary),
                          padding: MaterialStateProperty.all(
                              const EdgeInsets.symmetric(vertical: 16)),
                        ),
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
