import 'dart:convert';

import 'package:cruzadista/components/colors.dart';
import 'package:cruzadista/components/fonte_size.dart';
import 'package:flutter/material.dart';

import '../components/alert_dialog_recovery_password.dart';
import '../components/dialog_alert_error.dart';
import '../config/constants.dart';
import '../config/preferences.dart';
import '../config/requests.dart';
import '../model/user.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  var _colorBtnLogin = MyColors.colorPrimary;
  var _colorBtnRegistre = MyColors.gray;
  bool _screenLogin = false;

  //Aqui e para Login
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  //Aqui vai ser Para Cadastro
  TextEditingController _nameRegistreController = TextEditingController();
  TextEditingController _emailRegistreController = TextEditingController();
  TextEditingController _celularRegistreController = TextEditingController();
  TextEditingController _passwordRegistreController = TextEditingController();
  TextEditingController _coPasswordRegistreController = TextEditingController();

  //Aqui para recuperar senha



  final requestsWebServices = RequestsWebServices(WSConstantes.URLBASE);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(top: 56.0, left: 16, right: 16),
          child: Column(
            children: [
              SizedBox(
                height: 16,
              ),
              Center(
                child: Image.asset(
                  'images/logo.png',
                  height: 120,
                ),
              ),
              SizedBox(
                height: 16,
              ),
              Row(
                children: [
                  TextButton(
                      style: ButtonStyle(
                        overlayColor: MaterialStateProperty.all<Color>(
                          Colors.transparent,
                        ),
                      ),
                      onPressed: () {
                        setState(() {
                          _colorBtnLogin = MyColors.colorPrimary;
                          _colorBtnRegistre = MyColors.gray;
                          _screenLogin = false;
                        });
                      },
                      child: Text(
                        "Login",
                        style: TextStyle(
                            color: _colorBtnLogin,
                            fontSize: FontSizes.titulo,
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w500),
                      )),
                  TextButton(
                      style: ButtonStyle(
                        overlayColor: MaterialStateProperty.all<Color>(
                          Colors.transparent,
                        ),
                      ),
                      onPressed: () {
                        setState(() {
                          _colorBtnLogin = MyColors.gray;
                          _colorBtnRegistre = MyColors.colorPrimary;
                          _screenLogin = true;
                        });
                      },
                      child: Text(
                        "Cadastro",
                        style: TextStyle(
                            color: _colorBtnRegistre,
                            fontSize: FontSizes.titulo,
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w500),
                      ))
                ],
              ),
              if (!_screenLogin)
                Container(
                  child: Column(
                    children: [
                      Card(
                        elevation: 2,
                        color: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: 16, vertical: 4),
                          child: TextFormField(
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Por favor, preencha email valido';
                              }else{
                                bool emailValido = validationEmail(value!);
                                if (!emailValido) {
                                  return'O email é inválido!';
                                }
                              }

                            },
                            decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: 'Email',
                                filled: false),
                            controller: _emailController,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Card(
                        elevation: 2,
                        color: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: 16, vertical: 4),
                          child: TextField(
                            controller: _passwordController,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: 'Senha',
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 32),
                        child: Container(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: () async {
                              Preferences.init();
                              final email = _emailController?.text.toString();
                              final password = _passwordController?.text
                                  .toString();


                              try {
                                final body = {
                                  WSConstantes.EMAIL: email,
                                  WSConstantes.PASSWORD: password,
                                  WSConstantes.TOKENID: WSConstantes.TOKEN
                                };

                                final response = await requestsWebServices
                                    .sendPostRequest(WSConstantes.LOGIN, body);

                                final decodedResponse = jsonDecode(response);

                                if (decodedResponse is List &&
                                    decodedResponse.isNotEmpty) {
                                  final userResponse = decodedResponse[0];
                                  final status = userResponse['status'];
                                  final message = userResponse['msg'];

                                  if (status == '01') {
                                    final userId = userResponse['id'];
                                    final name = userResponse['nome'];
                                    final email = userResponse['email'];
                                    final phone = userResponse['celular'];

                                    final user = User(
                                      user_id: userId,
                                      name: name,
                                      email: email,
                                      cellphone: phone,
                                    );

                                    await Preferences.setUserData(user);
                                    await Preferences.setLogin(true);

                                    Navigator.pushNamed(context, '/ui/home');
                                  } else if (status == '02') {
                                    showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return DialogError(title: "Atenção!",
                                            content: message,
                                            btnConfirm: TextButton(
                                                style: TextButton.styleFrom(
                                                    foregroundColor: MyColors
                                                        .colorPrimary),
                                                onPressed: () {
                                                  Navigator.of(context).pop();
                                                },
                                                child: Text(
                                                  'Voltar', style: TextStyle(
                                                  fontSize: FontSizes.subTitulo,
                                                  fontWeight: FontWeight.w600,
                                                  fontFamily: 'Poppins',
                                                ),
                                                )
                                            ),);
                                      },
                                    );
                                  }else if (status == '03') {
                                    showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return DialogError(title: "Atenção!",
                                            content: message,
                                            btnConfirm: TextButton(
                                                style: TextButton.styleFrom(
                                                    foregroundColor: MyColors
                                                        .colorPrimary),
                                                onPressed: () {
                                                  Navigator.of(context).pop();
                                                },
                                                child: Text(
                                                  'Voltar', style: TextStyle(
                                                  fontSize: FontSizes.subTitulo,
                                                  fontWeight: FontWeight.w600,
                                                  fontFamily: 'Poppins',
                                                ),
                                                )
                                            ),);
                                      },
                                    );
                                  } else {
                                    showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return DialogError(title: "Atenção!",
                                          content: "Ocorreu um erro durante o login.",
                                          btnConfirm: TextButton(
                                              style: TextButton.styleFrom(
                                                  foregroundColor: MyColors
                                                      .colorPrimary),
                                              onPressed: () {
                                                Navigator.of(context).pop();
                                              },
                                              child: Text(
                                                'Voltar', style: TextStyle(
                                                fontSize: FontSizes.subTitulo,
                                                fontWeight: FontWeight.w600,
                                                fontFamily: 'Poppins',
                                              ),
                                              )
                                          ),);
                                      },
                                    );
                                  }
                                } else {
                                  showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return DialogError(title: "Atenção!",
                                        content: "Ocorreu um erro durante o login.",
                                        btnConfirm: TextButton(
                                            style: TextButton.styleFrom(
                                                foregroundColor: MyColors
                                                    .colorPrimary),
                                            onPressed: () {
                                              Navigator.of(context).pop();
                                            },
                                            child: Text(
                                              'Voltar', style: TextStyle(
                                              fontSize: FontSizes.subTitulo,
                                              fontWeight: FontWeight.w600,
                                              fontFamily: 'Poppins',
                                            ),
                                            )
                                        ),);
                                    },
                                  );
                                }
                              } catch (e) {
                                print('Erro durante a requisição: $e');
                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return DialogError(title: "Atenção!",
                                      content: "Erro durante a requisição: $e",
                                      btnConfirm: TextButton(
                                          style: TextButton.styleFrom(
                                              foregroundColor: MyColors
                                                  .colorPrimary),
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                          },
                                          child: Text(
                                            'Voltar', style: TextStyle(
                                            fontSize: FontSizes.subTitulo,
                                            fontWeight: FontWeight.w600,
                                            fontFamily: 'Poppins',
                                          ),
                                          )
                                      ),);
                                  },
                                );
                              }
                            },
                            child: Text(
                              "ENTRAR",
                              style: TextStyle(
                                  color: MyColors.colorOnPrimary,
                                  fontFamily: 'Poppins',
                                  fontSize: 16),
                            ),
                            style: ButtonStyle(
                              shape: MaterialStateProperty.all<
                                  RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30.0),
                                ),
                              ),
                              backgroundColor: MaterialStateProperty.all(
                                  MyColors.colorPrimary),
                              padding: MaterialStateProperty.all(
                                  const EdgeInsets.symmetric(vertical: 16)),
                            ),
                          ),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          TextButton(
                              style: ButtonStyle(
                                overlayColor: MaterialStateProperty.all<Color>(
                                  Colors.transparent,
                                ),
                              ),
                              onPressed: () {
                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return DialogRecoveryPassword();
                                  },
                                );
                              },
                              child: Text(
                                "Esqueceu a Senha?",
                                style: TextStyle(
                                    color: _colorBtnLogin,
                                    fontSize: FontSizes.textoNormal,
                                    fontFamily: 'Poppins',
                                    fontWeight: FontWeight.w500),
                              )
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              if (_screenLogin)
                Container(
                  child: Column(
                    children: [
                      Card(
                        elevation: 2,
                        color: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: 16, vertical: 4),
                          child: TextField(
                            controller: _nameRegistreController,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: 'Nome',
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Card(
                        elevation: 2,
                        color: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: 16, vertical: 4),
                          child: TextField(
                            controller: _emailRegistreController,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: 'Email',
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Card(
                        elevation: 2,
                        color: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: 16, vertical: 4),
                          child: TextField(
                            controller: _celularRegistreController,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: 'Celular',
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Card(
                        elevation: 2,
                        color: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: 16, vertical: 4),
                          child: TextField(
                            controller: _passwordRegistreController,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: 'Senha',
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Card(
                        elevation: 2,
                        color: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: 16, vertical: 4),
                          child: TextField(
                            controller: _coPasswordRegistreController,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: 'Confirmar Senha',
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text('Ao clicar no botão Cadastrar, você aceita os'),
                      Text(
                        'termos de privacidade do aplicativo.',
                        style: TextStyle(
                            fontFamily: 'Poppins', fontWeight: FontWeight.w600),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 16),
                        child: Container(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: () async {
                              Preferences.init();
                              final nameRegistre = _nameRegistreController?.text
                                  .toString();
                              final emailRegistre = _emailRegistreController
                                  ?.text.toString();
                              final phoneRegistre = _celularRegistreController
                                  ?.text.toString();
                              final passwordRegistre = _passwordRegistreController
                                  ?.text.toString();
                              final coPasswordRegistre = _coPasswordRegistreController
                                  ?.text.toString();
                              var passwordFinal = '';

                              if (passwordRegistre == coPasswordRegistre) {
                                passwordFinal = passwordRegistre!;
                              } else {
                                // Senhas não correspondem, exibir AlertDialog
                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      title: Text('Erro'),
                                      content: Text(
                                          'As senhas não correspondem.'),
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


                              try {
                                final body = {
                                  WSConstantes.NAME: nameRegistre,
                                  WSConstantes.EMAIL: emailRegistre,
                                  WSConstantes.PHONE: phoneRegistre,
                                  WSConstantes.PASSWORD: passwordFinal,
                                  WSConstantes.TOKENID: WSConstantes.TOKEN
                                };

                                final response = await requestsWebServices
                                    .sendPostRequest(
                                    WSConstantes.REGISTRER, body);

                                final decodedResponse = jsonDecode(response);

                                if (decodedResponse is List &&
                                    decodedResponse.isNotEmpty) {
                                  final userResponse = decodedResponse[0];
                                  final status = userResponse['status'];
                                  final message = userResponse['msg'];

                                  if (status == '01') {
                                    final userId = userResponse['id'];
                                    final name = userResponse['nome'];
                                    final email = userResponse['email'];
                                    final phone = userResponse['celular'];

                                    final user = User(
                                      user_id: userId,
                                      name: name,
                                      email: email,
                                      cellphone: phone,
                                    );

                                    await Preferences.setUserData(user);
                                    await Preferences.setLogin(true);

                                    Navigator.pushNamed(context, '/ui/home');

                                  } else if (status == '02') {
                                    showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return DialogError(title: "Atenção!",
                                          content: message,
                                          btnConfirm: TextButton(
                                              style: TextButton.styleFrom(
                                                  foregroundColor: MyColors
                                                      .colorPrimary),
                                              onPressed: () {
                                                Navigator.of(context).pop();
                                              },
                                              child: Text(
                                                'Voltar', style: TextStyle(
                                                fontSize: FontSizes.subTitulo,
                                                fontWeight: FontWeight.w600,
                                                fontFamily: 'Poppins',
                                              ),
                                              )
                                          ),);
                                      },
                                    );
                                  }else if (status == '03') {
                                    showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return DialogError(title: "Atenção!",
                                          content: message,
                                          btnConfirm: TextButton(
                                              style: TextButton.styleFrom(
                                                  foregroundColor: MyColors
                                                      .colorPrimary),
                                              onPressed: () {
                                                Navigator.of(context).pop();
                                              },
                                              child: Text(
                                                'Voltar', style: TextStyle(
                                                fontSize: FontSizes.subTitulo,
                                                fontWeight: FontWeight.w600,
                                                fontFamily: 'Poppins',
                                              ),
                                              )
                                          ),);
                                      },
                                    );
                                  } else {
                                    showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return DialogError(title: "Atenção!",
                                          content: "Ocorreu um erro durante o login.",
                                          btnConfirm: TextButton(
                                              style: TextButton.styleFrom(
                                                  foregroundColor: MyColors
                                                      .colorPrimary),
                                              onPressed: () {
                                                Navigator.of(context).pop();
                                              },
                                              child: Text(
                                                'Voltar', style: TextStyle(
                                                fontSize: FontSizes.subTitulo,
                                                fontWeight: FontWeight.w600,
                                                fontFamily: 'Poppins',
                                              ),
                                              )
                                          ),);
                                      },
                                    );
                                  }
                                } else {
                                  showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return DialogError(title: "Atenção!",
                                        content: "Ocorreu um erro durante o login.",
                                        btnConfirm: TextButton(
                                            style: TextButton.styleFrom(
                                                foregroundColor: MyColors
                                                    .colorPrimary),
                                            onPressed: () {
                                              Navigator.of(context).pop();
                                            },
                                            child: Text(
                                              'Voltar', style: TextStyle(
                                              fontSize: FontSizes.subTitulo,
                                              fontWeight: FontWeight.w600,
                                              fontFamily: 'Poppins',
                                            ),
                                            )
                                        ),);
                                    },
                                  );
                                }
                              } catch (e) {
                                print('Erro durante a requisição: $e');
                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return DialogError(title: "Atenção!",
                                      content: "Erro durante a requisição: $e",
                                      btnConfirm: TextButton(
                                          style: TextButton.styleFrom(
                                              foregroundColor: MyColors
                                                  .colorPrimary),
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                          },
                                          child: Text(
                                            'Voltar', style: TextStyle(
                                            fontSize: FontSizes.subTitulo,
                                            fontWeight: FontWeight.w600,
                                            fontFamily: 'Poppins',
                                          ),
                                          )
                                      ),);
                                  },
                                );
                              }
                            },
                            child: Text(
                              "CADASTRA-SE",
                              style: TextStyle(
                                  color: MyColors.colorOnPrimary,
                                  fontFamily: 'Poppins',
                                  fontSize: 16),
                            ),
                            style: ButtonStyle(
                              shape: MaterialStateProperty.all<
                                  RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30.0),
                                ),
                              ),
                              backgroundColor: MaterialStateProperty.all(
                                  MyColors.colorPrimary),
                              padding: MaterialStateProperty.all(
                                  const EdgeInsets.symmetric(vertical: 16)),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
  bool validationEmail(String email) {
    // Expressão regular para verificar o formato do email
    final regex = RegExp(r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,7}$');

    return regex.hasMatch(email);
  }

}
