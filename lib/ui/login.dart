import 'dart:convert';

import 'package:cruzadista/components/colors.dart';
import 'package:cruzadista/components/fonte_size.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
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

  var maskFormatter = new MaskTextInputFormatter(
      mask: '(##) #####-####',
      filter: {"#": RegExp(r'[0-9]')},
      type: MaskAutoCompletionType.lazy);

  //Aqui e para Login
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  //Aqui vai ser Para Cadastro
  TextEditingController _nameRegistreController = TextEditingController();
  TextEditingController _emailRegistreController = TextEditingController();
  TextEditingController _celularRegistreController = TextEditingController();
  TextEditingController _passwordRegistreController = TextEditingController();
  TextEditingController _coPasswordRegistreController = TextEditingController();

  //Botao com Progress
  bool isLoadingLogin = false;
  bool isLoadingRegistre = false;
  bool validationTextField = false;

  String password = '';
  String passwordConfig = '';
  bool hasPasswordCoPassword = false;
  bool hasUppercase = false;
  bool hasMinLength = false;
  bool visibileOne = false;
  bool visibileTwo = false;

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
                          padding:
                              EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                          child: TextField(
                            keyboardType: TextInputType.emailAddress,
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
                          padding:
                              EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                          child: TextField(
                            obscureText: true,
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
                              setState(() {
                                isLoadingLogin = true;
                              });

                              Preferences.init();
                              final email = _emailController?.text.toString();
                              final password =
                                  _passwordController?.text.toString();

                              if (validatonLogin(email!, password!)) {
                                try {
                                  final body = {
                                    WSConstantes.EMAIL: email,
                                    WSConstantes.PASSWORD: password,
                                    WSConstantes.TOKENID: WSConstantes.TOKEN
                                  };

                                  final response =
                                      await requestsWebServices.sendPostRequest(
                                          WSConstantes.LOGIN, body);

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
                                        id: userId,
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
                                          return DialogError(
                                            title: "Atenção!",
                                            content: message,
                                            btnConfirm: TextButton(
                                                style: TextButton.styleFrom(
                                                    foregroundColor:
                                                        MyColors.colorPrimary),
                                                onPressed: () {
                                                  Navigator.of(context).pop();
                                                },
                                                child: Text(
                                                  'Voltar',
                                                  style: TextStyle(
                                                    fontSize:
                                                        FontSizes.subTitulo,
                                                    fontWeight: FontWeight.w600,
                                                    fontFamily: 'Poppins',
                                                  ),
                                                )),
                                          );
                                        },
                                      );
                                    } else if (status == '03') {
                                      showDialog(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return DialogError(
                                            title: "Atenção!",
                                            content: message,
                                            btnConfirm: TextButton(
                                                style: TextButton.styleFrom(
                                                    foregroundColor:
                                                        MyColors.colorPrimary),
                                                onPressed: () {
                                                  Navigator.of(context).pop();
                                                },
                                                child: Text(
                                                  'Voltar',
                                                  style: TextStyle(
                                                    fontSize:
                                                        FontSizes.subTitulo,
                                                    fontWeight: FontWeight.w600,
                                                    fontFamily: 'Poppins',
                                                  ),
                                                )),
                                          );
                                        },
                                      );
                                    } else {
                                      showDialog(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return DialogError(
                                            title: "Atenção!",
                                            content:
                                                "Ocorreu um erro durante o login.",
                                            btnConfirm: TextButton(
                                                style: TextButton.styleFrom(
                                                    foregroundColor:
                                                        MyColors.colorPrimary),
                                                onPressed: () {
                                                  Navigator.of(context).pop();
                                                },
                                                child: Text(
                                                  'Voltar',
                                                  style: TextStyle(
                                                    fontSize:
                                                        FontSizes.subTitulo,
                                                    fontWeight: FontWeight.w600,
                                                    fontFamily: 'Poppins',
                                                  ),
                                                )),
                                          );
                                        },
                                      );
                                    }
                                  } else {
                                    showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return DialogError(
                                          title: "Atenção!",
                                          content:
                                              "Ocorreu um erro durante o login.",
                                          btnConfirm: TextButton(
                                              style: TextButton.styleFrom(
                                                  foregroundColor:
                                                      MyColors.colorPrimary),
                                              onPressed: () {
                                                Navigator.of(context).pop();
                                              },
                                              child: Text(
                                                'Voltar',
                                                style: TextStyle(
                                                  fontSize: FontSizes.subTitulo,
                                                  fontWeight: FontWeight.w600,
                                                  fontFamily: 'Poppins',
                                                ),
                                              )),
                                        );
                                      },
                                    );
                                  }
                                } catch (e) {
                                  print('Erro durante a requisição: $e');
                                  showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return DialogError(
                                        title: "Atenção!",
                                        content:
                                            "Erro durante a requisição: $e",
                                        btnConfirm: TextButton(
                                            style: TextButton.styleFrom(
                                                foregroundColor:
                                                    MyColors.colorPrimary),
                                            onPressed: () {
                                              Navigator.of(context).pop();
                                            },
                                            child: Text(
                                              'Voltar',
                                              style: TextStyle(
                                                fontSize: FontSizes.subTitulo,
                                                fontWeight: FontWeight.w600,
                                                fontFamily: 'Poppins',
                                              ),
                                            )),
                                      );
                                    },
                                  );
                                } finally {
                                  setState(() {
                                    isLoadingLogin = false;
                                  });
                                }
                              }else{
                                setState(() {
                                  isLoadingRegistre = false;
                                });
                              }
                            },
                            child: isLoadingLogin
                                ? CircularProgressIndicator(
                                    color: MyColors.grayLite,
                                    strokeWidth: 3,
                                  )
                                : Text(
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
                              )),
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
                          padding:
                              EdgeInsets.symmetric(horizontal: 16, vertical: 4),
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
                          padding:
                              EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                          child: TextField(
                            keyboardType: TextInputType.emailAddress,
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
                          padding:
                              EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                          child: TextField(
                            inputFormatters: [maskFormatter],
                            keyboardType: TextInputType.number,
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
                          padding:
                              EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                          child: TextFormField(
                            onChanged: (value) {
                              setState(() {
                                password = value;
                                visibileOne = true;
                                hasMinLength = password.length >= 8;
                                hasUppercase = password.contains(RegExp(r'[A-Z]'));
                                if (hasMinLength && hasUppercase) {
                                  visibileOne = false;
                                }
                              });
                            },
                            obscureText: true,
                            controller: _passwordRegistreController,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: 'Senha',
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 4),
                      Visibility(
                        visible: password.isNotEmpty,
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
                      Visibility(
                        visible: password.isNotEmpty,
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
                          padding:
                              EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                          child: TextFormField(
                            onChanged: (value) {
                              setState(() {
                                visibileTwo = true;
                                passwordConfig = value;
                                hasPasswordCoPassword = passwordConfig == password;

                                if (hasPasswordCoPassword) {
                                  visibileTwo = false;
                                }
                              });
                            },
                            obscureText: true,
                            controller: _coPasswordRegistreController,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: 'Confirmar Senha',
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 4),
                      Visibility(
                        visible: passwordConfig.isNotEmpty,
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
                              setState(() {
                                isLoadingRegistre = true;
                              });
                              Preferences.init();
                              final nameRegistre = _nameRegistreController?.text.toString();
                              final emailRegistre = _emailRegistreController?.text.toString();
                              final phoneRegistre = _celularRegistreController?.text.toString();
                              final passwordRegistre = _passwordRegistreController?.text.toString();
                              final coPasswordRegistre = _coPasswordRegistreController?.text.toString();


                              if(validatonRegistrer(nameRegistre!, emailRegistre!, phoneRegistre!, passwordRegistre!, coPasswordRegistre!)){
                                try {
                                  final body = {
                                    WSConstantes.NAME: nameRegistre,
                                    WSConstantes.EMAIL: emailRegistre,
                                    WSConstantes.PHONE: phoneRegistre,
                                    WSConstantes.PASSWORD: passwordRegistre,
                                    WSConstantes.TOKENID: WSConstantes.TOKEN
                                  };

                                  final response =
                                  await requestsWebServices.sendPostRequest(
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
                                        id: userId,
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
                                          return DialogError(
                                            title: "Atenção!",
                                            content: message,
                                            btnConfirm: TextButton(
                                                style: TextButton.styleFrom(
                                                    foregroundColor:
                                                    MyColors.colorPrimary),
                                                onPressed: () {
                                                  Navigator.of(context).pop();
                                                },
                                                child: Text(
                                                  'Voltar',
                                                  style: TextStyle(
                                                    fontSize: FontSizes.subTitulo,
                                                    fontWeight: FontWeight.w600,
                                                    fontFamily: 'Poppins',
                                                  ),
                                                )),
                                          );
                                        },
                                      );
                                    } else if (status == '03') {
                                      showDialog(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return DialogError(
                                            title: "Atenção!",
                                            content: message,
                                            btnConfirm: TextButton(
                                                style: TextButton.styleFrom(
                                                    foregroundColor:
                                                    MyColors.colorPrimary),
                                                onPressed: () {
                                                  Navigator.of(context).pop();
                                                },
                                                child: Text(
                                                  'Voltar',
                                                  style: TextStyle(
                                                    fontSize: FontSizes.subTitulo,
                                                    fontWeight: FontWeight.w600,
                                                    fontFamily: 'Poppins',
                                                  ),
                                                )),
                                          );
                                        },
                                      );
                                    } else {
                                      showDialog(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return DialogError(
                                            title: "Atenção!",
                                            content:
                                            "Ocorreu um erro durante o login.",
                                            btnConfirm: TextButton(
                                                style: TextButton.styleFrom(
                                                    foregroundColor:
                                                    MyColors.colorPrimary),
                                                onPressed: () {
                                                  Navigator.of(context).pop();
                                                },
                                                child: Text(
                                                  'Voltar',
                                                  style: TextStyle(
                                                    fontSize: FontSizes.subTitulo,
                                                    fontWeight: FontWeight.w600,
                                                    fontFamily: 'Poppins',
                                                  ),
                                                )),
                                          );
                                        },
                                      );
                                    }
                                  } else {
                                    showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return DialogError(
                                          title: "Atenção!",
                                          content:
                                          "Ocorreu um erro durante o login.",
                                          btnConfirm: TextButton(
                                              style: TextButton.styleFrom(
                                                  foregroundColor:
                                                  MyColors.colorPrimary),
                                              onPressed: () {
                                                Navigator.of(context).pop();
                                              },
                                              child: Text(
                                                'Voltar',
                                                style: TextStyle(
                                                  fontSize: FontSizes.subTitulo,
                                                  fontWeight: FontWeight.w600,
                                                  fontFamily: 'Poppins',
                                                ),
                                              )),
                                        );
                                      },
                                    );
                                  }
                                } catch (e) {
                                  print('Erro durante a requisição: $e');
                                  showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return DialogError(
                                        title: "Atenção!",
                                        content: "Erro durante a requisição: $e",
                                        btnConfirm: TextButton(
                                            style: TextButton.styleFrom(
                                                foregroundColor:
                                                MyColors.colorPrimary),
                                            onPressed: () {
                                              Navigator.of(context).pop();
                                            },
                                            child: Text(
                                              'Voltar',
                                              style: TextStyle(
                                                fontSize: FontSizes.subTitulo,
                                                fontWeight: FontWeight.w600,
                                                fontFamily: 'Poppins',
                                              ),
                                            )),
                                      );
                                    },
                                  );
                                } finally {
                                  setState(() {
                                    isLoadingRegistre = false;
                                  });
                                }
                              }else{
                                setState(() {
                                  isLoadingRegistre = false;
                                });
                              }

                            },
                            child: isLoadingRegistre
                                ? CircularProgressIndicator(
                                    color: MyColors.grayLite,
                                    strokeWidth: 3,
                                  ) // ou qualquer indicador de carregamento desejado
                                : Text(
                                    "CADASTRAR",
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

  bool validatonLogin(String email, String password) {
    bool validation = false;
    if (!validationEmail(email)) {
      setState(() {
        Fluttertoast.showToast(
          msg: WSConstantes.MSG_EMAIL_INVALIDO,
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
        );
        isLoadingLogin = false;
        validation = false;
      });
    } else if (password.isEmpty || password.length < 6) {
      setState(() {
        Fluttertoast.showToast(
          msg: WSConstantes.MSG_PASSWORD_INVALIDO,
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
        );
        isLoadingLogin = false;
        validation = false;
      });
    } else {
      validation = true;
    }

    return validation;
  }

  bool validatonRegistrer(String name, String email, String phone, String password, String coPassword ){
    bool validation = false;
    if(name.isEmpty){
      setState(() {
        Fluttertoast.showToast(
          msg: WSConstantes.MSG_NOME_INVALIDO,
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
        );
        isLoadingLogin = false;
        validation = false;
      });
    } else if (!validationEmail(email)) {
      setState(() {
        Fluttertoast.showToast(
          msg: WSConstantes.MSG_EMAIL_EMPTY,
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
        );
        isLoadingLogin = false;
        validation = false;
      });
    } else if (phone.isEmpty) {
      setState(() {
        Fluttertoast.showToast(
          msg: WSConstantes.MSG_PHONE_EMPTY,
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
        );
        isLoadingLogin = false;
        validation = false;
      });
    }else if (password.isEmpty) {
      setState(() {
        Fluttertoast.showToast(
          msg: WSConstantes.MSG_PASSWORD_EMPTY,
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
        );
        isLoadingLogin = false;
        validation = false;
      });
    } else if (password.length < 8) {
      setState(() {
        Fluttertoast.showToast(
          msg: WSConstantes.MSG_PASSWORD_INVALIDO,
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
        );
        isLoadingLogin = false;
        validation = false;
      });
    } else if (coPassword.isEmpty) {
      setState(() {
        Fluttertoast.showToast(
          msg: WSConstantes.MSG_CO_PASSWORD_EMPTY,
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
        );
        isLoadingLogin = false;
        validation = false;
      });
    }else if (coPassword != password) {
      setState(() {
        Fluttertoast.showToast(
          msg: WSConstantes.MSG_CO_PASSWORD_INVALIDO,
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
        );
        isLoadingLogin = false;
        validation = false;
      });
    } else {
      validation = true;
    }

    return validation;
  }

  bool validationEmail(String email) {
    final regex = RegExp(r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,7}$');
    return regex.hasMatch(email);
  }
}
