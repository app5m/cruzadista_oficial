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
  bool isLoading = false;
  String password = '';
  String passwordConfig = '';
  bool hasPasswordCoPassword = false;
  bool hasUppercase = false;
  bool hasMinLength = false;
  bool visibileOne = false;
  bool visibileTwo = false;

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

            isLoading = false;
          });
        } else {
          setState(() {
            Fluttertoast.showToast(
              msg: user.msg!,
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
            );
            isLoading = false;
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
                        child: TextFormField(
                          onChanged: (value) {
                            setState(() {
                              password = value;
                              visibileOne = true;
                              hasMinLength = password.length >= 8;
                              hasUppercase =
                                  password.contains(RegExp(r'[A-Z]'));
                              if (hasMinLength && hasUppercase) {
                                visibileOne = false;
                              }
                            });
                          },
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
                  SizedBox(height: 4),
                  Visibility(
                    visible: password.isNotEmpty,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Row(
                        children: [
                          Icon(
                            hasMinLength
                                ? Icons.check_circle
                                : Icons.check_circle,
                            color: hasMinLength ? Colors.green : Colors.grey,
                          ),
                          Text(
                            'Deve ter no mínimo 8 carácteres',
                            style: TextStyle(color: Color(0xFF000000)),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Visibility(
                    visible: password.isNotEmpty,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Row(
                        children: [
                          Icon(
                            hasUppercase
                                ? Icons.check_circle
                                : Icons.check_circle,
                            color: hasUppercase ? Colors.green : Colors.grey,
                          ),
                          Text(
                            'Deve ter uma letra maiúscula',
                            style: TextStyle(color: Color(0xFF000000)),
                          ),
                        ],
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
                        child: TextFormField(
                          onChanged: (value) {
                            setState(() {
                              visibileTwo = true;
                              passwordConfig = value;
                              hasPasswordCoPassword =
                                  passwordConfig == password;

                              if (hasPasswordCoPassword) {
                                visibileTwo = false;
                              }
                            });
                          },
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
                  SizedBox(height: 4),
                  Visibility(
                    visible: passwordConfig.isNotEmpty,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Row(
                        children: [
                          Icon(
                            hasPasswordCoPassword
                                ? Icons.check_circle
                                : Icons.check_circle,
                            color: hasPasswordCoPassword
                                ? Colors.green
                                : Colors.grey,
                          ),
                          Text(
                            'As senhas fornecidas são idênticas',
                            style: TextStyle(color: Color(0xFF000000)),
                          ),
                        ],
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
                            isLoading = true;
                          });
                          updatePassword(_passwordUpdateController.text,
                              _coPasswordUpdateController.text);
                        },
                        child: isLoading
                            ? CircularProgressIndicator(
                          color: MyColors.grayLite,
                          strokeWidth: 3,
                        )
                            :  Text(
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
