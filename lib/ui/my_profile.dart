import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

import '../components/colors.dart';
import '../components/fonte_size.dart';
import '../config/constants.dart';
import '../config/preferences.dart';
import '../config/requests.dart';
import '../model/user.dart';

class MyProfile extends StatefulWidget {
  const MyProfile({Key? key}) : super(key: key);

  @override
  State<MyProfile> createState() => _MyProfileState();
}

class _MyProfileState extends State<MyProfile> {
  final requestsWebServices = RequestsWebServices(WSConstantes.URLBASE);
  var nameUser = '';
  var avatarUser = '';
  final user = User();

  TextEditingController _nameUpdateController = TextEditingController();
  TextEditingController _emailUpdateController = TextEditingController();
  TextEditingController _cellphoneUpdateController = TextEditingController();
  TextEditingController _birthUpdateController = TextEditingController();

  Future<String?> getUserData() async {
    await Preferences.init();
    var _userId = await Preferences.getUserData()!.id;
    final body = {
      WSConstantes.ID: _userId,
      WSConstantes.TOKENID: WSConstantes.TOKEN
    };

    final response = await requestsWebServices.sendPostRequest(
        WSConstantes.PERFIL_USER, body);
    final decodedResponse = jsonDecode(response);
    if (decodedResponse.isNotEmpty) {
      user.id = decodedResponse['id'];
      user.name = decodedResponse['nome'];
      user.avatar = decodedResponse['avatar'];
      user.email = decodedResponse['email'];
      user.cellphone = decodedResponse['celular'];
      user.birth = decodedResponse['data_nascimento'];

      setState(() {
        avatarUser = WSConstantes.URL_AVATAR + user.avatar!;
        _nameUpdateController.text = user.name!;
        _emailUpdateController.text = user.email!;
        _cellphoneUpdateController.text = user.cellphone!;
        _birthUpdateController.text = user.birth!;
      });

      print(
          'meu id ${user.id}, meu nome: ${user.name}, avatar: ${user.avatar}');
    }
  }

  var maskFormatter = new MaskTextInputFormatter(
      mask: '(##) #####-####',
      filter: {"#": RegExp(r'[0-9]')},
      type: MaskAutoCompletionType.lazy);

  Future<String?> sendUserData(String phone, String name, String birth) async {
    await Preferences.init();
    var _userId = await Preferences.getUserData()!.id;
    final body = {
      WSConstantes.ID: _userId,
      WSConstantes.PHONE: phone,
      WSConstantes.NAME: name,
      WSConstantes.BIRTH: birth,
      WSConstantes.TOKENID: WSConstantes.TOKEN
    };

    final response = await requestsWebServices.sendPostRequest(
        WSConstantes.UPDATE_USER, body);
    final decodedResponse = jsonDecode(response);
    if (decodedResponse.isNotEmpty) {
      user.status = decodedResponse[0]['status'];
      user.msg = decodedResponse[0]['msg'];

      if(user.status == "01"){
        setState(() {
          Fluttertoast.showToast(
            msg: user.msg!,
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
          );
          getUserData();
        });
      }else{
        setState(() {
          Fluttertoast.showToast(
            msg: user.msg!,
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
          );
        });


      }



      print(
          'Status ${user.status}, Mensagem: ${user.msg}');
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getUserData();
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
                      "Meu Perfil",
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
                  CircleAvatar(
                    backgroundImage: ExactAssetImage('images/avatar.png'),
                    radius: 60,
                    backgroundColor: MyColors.grayLite,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pushNamed(context, "/ui/login");
                    },
                    child: Text(
                      "EDITAR AVATAR",
                      style: TextStyle(
                          color: MyColors.colorOnPrimary,
                          fontFamily: 'Poppins',
                          fontSize: 16),
                    ),
                    style: ButtonStyle(
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30.0),
                        ),
                      ),
                      backgroundColor:
                          MaterialStateProperty.all(MyColors.colorPrimary),
                      padding: MaterialStateProperty.all(
                          const EdgeInsets.symmetric(
                              vertical: 8, horizontal: 16)),
                    ),
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
                          controller: _nameUpdateController,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: 'Nome',
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
                          enabled: false,
                          controller: _emailUpdateController,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: 'Email',
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
                          controller: _cellphoneUpdateController,
                          inputFormatters: [maskFormatter],
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: 'Celular',
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
                          controller: _birthUpdateController,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: 'Data nascimento',
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
                          sendUserData(_cellphoneUpdateController.text, _nameUpdateController.text, _birthUpdateController.text);
                          //Navigator.pushNamed(context, "/ui/home");
                        },
                        child: Text(
                          "ATUALIZAR DADOS",
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
                  SizedBox(height: 16),
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
                                padding:
                                    const EdgeInsets.only(left: 2, right: 2),
                                child: SizedBox(
                                  width: 1,
                                  height: 50,
                                ),
                              )),
                        ),
                        SvgPicture.asset(
                          'icons/lock.svg',
                          height: 35,
                          width: 35,
                        ),
                        SizedBox(width: 8),
                        Text(
                          'Atualizar senha',
                          style: TextStyle(
                            fontSize: FontSizes.subTitulo,
                            fontWeight: FontWeight.w500,
                            fontFamily: 'Poppins',
                          ),
                        )
                      ],
                    ),
                    onTap: () {
                      Navigator.pushNamed(context, "/ui/updatePassword");
                    },
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
