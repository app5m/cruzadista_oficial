import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../components/colors.dart';
import '../components/fonte_size.dart';

class MyProfile extends StatefulWidget {
  const MyProfile({Key? key}) : super(key: key);

  @override
  State<MyProfile> createState() => _MyProfileState();
}

class _MyProfileState extends State<MyProfile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(child: Padding(
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
                        const EdgeInsets.symmetric(vertical: 8, horizontal: 16)),
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
                    child: const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                      child: TextField(
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
                    child: const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                      child: TextField(
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
                    child: const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                      child: TextField(
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
                    child: const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                      child: TextField(
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
                  padding: const EdgeInsets.only(top: 16, left: 16, right: 16),
                  child: Container(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
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
                        shape: MaterialStateProperty.all<
                            RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20.0),
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
                SizedBox(height: 16),
                InkWell(child: Row(
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
                    SvgPicture.asset('icons/lock.svg', height: 35, width: 35,),
                    SizedBox(width: 8),
                    Text('Atualizar senha', style: TextStyle(
                      fontSize: FontSizes.subTitulo,
                      fontWeight: FontWeight.w500,
                      fontFamily: 'Poppins',
                    ),)
                  ],
                ),
                  onTap: (){
                  Navigator.pushNamed(context, "/ui/updatePassword");
                  },
                )

              ],
            )
          ],
        ),
      ),),
    );
  }
}
