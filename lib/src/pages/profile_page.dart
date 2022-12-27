import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:homehealth/src/models/profile_model.dart';
import 'package:homehealth/src/preferencias_usuario/preferencias_usuario.dart';
import 'package:homehealth/src/providers/usuario_provider.dart';

class ProfilePage extends StatelessWidget {
  final _prefs = PreferenciasUsuario();

  final UsuarioProvider _usuarioProvider = new UsuarioProvider();

  Size _size;

  @override
  Widget build(BuildContext context) {
    _size = MediaQuery.of(context).size;
    return Column(
      children: [
        buttonLogout(context),
        Container(
          child: FutureBuilder(
            future: _usuarioProvider.getProfileUser(),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              final infoProfile = snapshot.data;
              if (snapshot.hasData) {
                return SingleChildScrollView(
                  child: Column(
                    children: [
                      Container(
                        margin: EdgeInsets.only(
                          top: _size.height * 0.08,
                        ),
                        child: Column(
                          children: [
                            createInfoProfile(infoProfile),
                            Container(
                              margin: EdgeInsets.only(
                                top: _size.height * 0.03,
                                left: _size.width * 0.03,
                              ),
                              alignment: Alignment.centerLeft,
                              child: Text(
                                "Biografía",
                                style: TextStyle(
                                    fontSize: 26.0, fontWeight: FontWeight.bold),
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.symmetric(horizontal: _size.width * 0.03),
                              child: Text(
                                "Tengo 23 años, soy estudiante de ingenieria de sistemas cursando el noveno semestre, actualmente me encuentro realizando trabajo de grado, actitudes positivas para el trabajo y capaz de realizar cualquier tarea del hogar",
                                style: TextStyle(
                                  fontSize: 18.0,
                                ),  
                                textAlign: TextAlign.justify,
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(
                                top: _size.height * 0.03,
                                left: _size.width * 0.03,
                              ),
                              alignment: Alignment.centerLeft,
                              child: Text(
                                "Skills",
                                style: TextStyle(
                                    fontSize: 26.0, fontWeight: FontWeight.bold),
                              ),
                            ),
                            Container(
                              height: _size.height * 0.3,
                              child: PageView.builder(
                                itemBuilder: (context, i) {
                                  print("infoProfile => ${infoProfile["skills"]}");
                                  return _crearTarjetaSkill(context, infoProfile["skills"][i]);
                                },
                                pageSnapping: true,
                                controller: PageController(
                                  viewportFraction: 0.4
                                ),
                                itemCount: infoProfile["skills"].length,
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              } else {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
            },
          ),
        ),
      ],
    );
  }

  Widget createInfoProfile(infoProfile) {
    return Container(
        height: _size.height * 0.2,
        margin: EdgeInsets.symmetric(horizontal: _size.width * 0.03),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(10.0),
          child: showInfoProfile(_size, infoProfile),
        ));
  }

  Widget showInfoProfile(Size size, infoProfile) {
    return Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20.0), 
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.3),
                spreadRadius: 5,
                blurRadius: 7,
                offset: Offset(0, 3)
              )
            ]
        ),
        child: Row(
          children: [
            Container(
              margin: EdgeInsets.symmetric(horizontal: size.width * 0.02),
              height: double.infinity,
              child: CircleAvatar(
                  backgroundImage: AssetImage("assets/images/jhon.jpg")),
              width: size.width * 0.3,
            ),
            Container(
              height: double.infinity,
              width: size.width * 0.55,
              margin: EdgeInsets.symmetric(vertical: size.height * 0.03),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("${infoProfile["firstname"]} ${infoProfile["lastname"]}",
                      style: TextStyle(
                          fontSize: 23.0, fontWeight: FontWeight.bold)),
                  SizedBox(height: size.height * 0.006),
                  Text(
                    '${infoProfile["address"]} Bucaramanga/Santander',
                  ),
                  SizedBox(height: size.height * 0.006),
                  Text('${infoProfile["phone"]}'),
                  SizedBox(height: size.height * 0.006),
                  Text('${infoProfile["user"]}')
                ],
              ),
            )
          ],
        )
    );
  }

  _crearTarjetaSkill(BuildContext context, dynamic skill) {
    return Container(
      margin: EdgeInsets.only(right: 15.0),
      child: Column(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(20.0),
            child: FadeInImage(
              placeholder: AssetImage('assets/images/no-image.jpg'),
              image: NetworkImage(skill["image"]),
              fit: BoxFit.cover,
              height: 200,
            ),
          ),
          SizedBox(
            height: 5.0,
          ),
          Text(
            "${skill["name"]} -- ${skill["score"]} puntos",
            overflow: TextOverflow.ellipsis,
            style: Theme.of(context).textTheme.caption,
          )
        ],
      ),
    );
  }

  buttonLogout(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: SizedBox(width: 20.0,),
        ),
        Container(
          child: IconButton(
            iconSize: 30.0,
            color: Colors.grey,
            icon: Icon(Icons.logout),
            onPressed: (){
              _confirmLogout(context);
            }
          ),
        ),
      ],
    );
  }

  _confirmLogout(BuildContext context) {
    showDialog(
      context: context, 
      builder: (context) {
        return AlertDialog(
          title: Text('Cerrar'),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(20.0))
          ),
          content: Text("¿Desear cerrar sesión?"),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text('Cancelar'),
            ),
            TextButton(
              onPressed: () {
                _logout();
                Navigator.pushReplacementNamed(context, 'login');
              },
              child: Text('Salir'),
            )
          ],
        );
      }
    );
  }

  _logout() {
    _usuarioProvider.cerrarSesion();
  }
}
