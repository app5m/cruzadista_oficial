import 'dart:convert';

import 'package:cruzadista/components/colors.dart';
import 'package:cruzadista/components/fonte_size.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../config/constants.dart';
import '../config/requests.dart';

class DialogRecoveryPassword extends StatefulWidget {
  const DialogRecoveryPassword({Key? key}) : super(key: key);

  @override
  State<DialogRecoveryPassword> createState() => _DialogRecoveryPasswordState();
}

class _DialogRecoveryPasswordState extends State<DialogRecoveryPassword> {
  TextEditingController _emailRecoveryController = TextEditingController();
  final requestsWebServices = RequestsWebServices(WSConstantes.URLBASE);


  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        height: 280,
        child: Card(
          color: MyColors.grayLite,
          margin: EdgeInsets.all(16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                Text(
                  'Recuperar senha',
                  style: TextStyle(
                      fontSize: FontSizes.titulo, fontWeight: FontWeight.w500),
                ),
                SizedBox(height: 16,),
                Text(
                  'Todas as intruções para alterar a senha serão enviadas via email.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: FontSizes.subTitulo, fontWeight: FontWeight.w400),
                ),
                SizedBox(height: 16,),
                Card(
                  elevation: 2,
                  color: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    child: TextField(
                      controller: _emailRecoveryController,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Email',
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 16,),
                Padding(
                  padding: const EdgeInsets.only(),
                  child: Container(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () async {

                        final email = _emailRecoveryController?.text.toString();



                        try {
                          final body = {
                            WSConstantes.EMAIL: email,

                            WSConstantes.TOKENID: WSConstantes.TOKEN
                          };

                          final response = await requestsWebServices.sendPostRequest(WSConstantes.RECOVERRY_PASSWORD, body);

                          final decodedResponse = jsonDecode(response);

                          if (decodedResponse is List && decodedResponse.isNotEmpty) {
                            final userResponse = decodedResponse[0];
                            final status = userResponse['status'];
                            final message = userResponse['msg'];

                            if (status == '01') {

                              setState(() {
                                Fluttertoast.showToast(
                                  msg: message,
                                  toastLength: Toast.LENGTH_SHORT,
                                  gravity: ToastGravity.BOTTOM,
                                );
                              });

                              Navigator.pop(context);
                            } else if (status == '02') {

                              //Coloca TOAST
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: Text('Erro de autenticação'),
                                    content: Text(message),
                                    actions: <Widget>[
                                      TextButton(
                                        child: Text('OK'),
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                        },
                                      ),
                                    ],
                                  );
                                },
                              );
                            } else {
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: Text('Erro'),
                                    content: Text('Ocorreu um erro durante o login.'),
                                    actions: <Widget>[
                                      TextButton(
                                        child: Text('OK'),
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                        },
                                      ),
                                    ],
                                  );
                                },
                              );
                            }
                          } else {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: Text('Erro'),
                                  content: Text('Ocorreu um erro durante o login.'),
                                  actions: <Widget>[
                                    TextButton(
                                      child: Text('OK'),
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                    ),
                                  ],
                                );
                              },
                            );
                          }
                        } catch (e) {

                          print('Erro durante a requisição: $e');
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: Text('Erro'),
                                content: Text('Ocorreu um erro durante o login.'),
                                actions: <Widget>[
                                  TextButton(
                                    child: Text('OK'),
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                  ),
                                ],
                              );
                            },
                          );
                        }
                      },
                      child: Text(
                        "REDEFINIR SENHA",
                        style: TextStyle(
                            color: MyColors.colorOnPrimary,
                            fontFamily: 'Poppins',
                            fontSize: 16),
                      ),
                      style: ButtonStyle(
                        shape: MaterialStateProperty.all<
                            RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16.0),
                          ),
                        ),
                        backgroundColor: MaterialStateProperty.all(
                            MyColors.colorPrimary),
                        padding: MaterialStateProperty.all(
                            const EdgeInsets.symmetric(vertical: 12)),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
