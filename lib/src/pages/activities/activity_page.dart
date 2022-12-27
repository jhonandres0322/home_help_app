import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:homehealth/src/bloc/request_bloc.dart';
import 'package:homehealth/src/models/activity_model.dart';
import 'package:homehealth/src/models/request_model.dart';
import 'package:homehealth/src/preferencias_usuario/preferencias_usuario.dart';
import 'package:homehealth/src/providers/activity_provider.dart';
import 'package:homehealth/src/providers/provider.dart';
import 'package:homehealth/src/providers/usuario_provider.dart';
import 'package:homehealth/src/utils/utils.dart';
import 'package:intl/intl.dart';

class ActivityPage extends StatelessWidget {
  Size _size;
  TextStyle _styleTextTitle =
      new TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold);
  final _usuarioProvider = new UsuarioProvider();
  final formatCurrency = new NumberFormat.simpleCurrency();
  final DateFormat formatter = DateFormat('dd-MM-yyyy');
  ActivityModel actData;
  PreferenciasUsuario _prefs = new PreferenciasUsuario();
  RequestBloc _bloc;
  RequestModel _requestModel = new RequestModel();
  ActivityProvider _activityProvider = new ActivityProvider();

  @override
  Widget build(BuildContext context) {
    _bloc = Provider.request(context);
    actData = ModalRoute.of(context).settings.arguments;
    _size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("${actData.title}",
            style: TextStyle(fontSize: 30.0, fontWeight: FontWeight.bold)),
      ),
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin: EdgeInsets.only(
                    top: _size.height * 0.02, left: _size.width * 0.03),
                child: Text(
                  "Información Personal",
                  style: TextStyle(fontSize: 25.0, fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(height: _size.height * 0.03),
              Container(
                margin: EdgeInsets.symmetric(
                  horizontal: _size.width * 0.03,
                  vertical: _size.height * 0.005,
                ),
                child: Text("Descripción", style: _styleTextTitle),
              ),
              Container(
                  margin: EdgeInsets.symmetric(
                    horizontal: _size.width * 0.03,
                    vertical: _size.height * 0.005,
                  ),
                  child: Text("${actData.description}")),
              Divider(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Column(
                    children: [
                      Container(
                        child: Text("Precio", style: _styleTextTitle),
                        margin: EdgeInsets.symmetric(
                          horizontal: _size.width * 0.03,
                          vertical: _size.height * 0.005,
                        ),
                      ),
                      Container(
                          margin: EdgeInsets.symmetric(
                            horizontal: _size.width * 0.03,
                            vertical: _size.height * 0.005,
                          ),
                          child: Text(
                              "${formatCurrency.format(actData.pricePerHour)}")),
                    ],
                  ),
                  Column(
                    children: [
                      Container(
                        child: Text("Horas Estimadas", style: _styleTextTitle),
                        margin: EdgeInsets.symmetric(
                          horizontal: _size.width * 0.03,
                          vertical: _size.height * 0.005,
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.symmetric(
                          horizontal: _size.width * 0.03,
                          vertical: _size.height * 0.005,
                        ),
                        child: Text(
                          actData.estimatedHours == 1
                              ? "${actData.estimatedHours} hora"
                              : "${actData.estimatedHours} horas",
                          style: TextStyle(fontSize: 15.0),
                        ),
                      ),
                    ],
                  )
                ],
              ),
              Divider(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Column(
                    children: [
                      Container(
                        child: Text("Publicado por", style: _styleTextTitle),
                        margin: EdgeInsets.symmetric(
                          horizontal: _size.width * 0.03,
                          vertical: _size.height * 0.005,
                        ),
                      ),
                      Container(
                          margin: EdgeInsets.symmetric(
                            horizontal: _size.width * 0.03,
                            vertical: _size.height * 0.005,
                          ),
                          child: Text("${actData.namePosted}")),
                    ],
                  ),
                  Column(
                    children: [
                      Container(
                        child: Text("Estado de la Actividad",
                            style: _styleTextTitle),
                        margin: EdgeInsets.symmetric(
                          horizontal: _size.width * 0.03,
                          vertical: _size.height * 0.005,
                        ),
                      ),
                      Container(
                          margin: EdgeInsets.symmetric(
                            horizontal: _size.width * 0.03,
                            vertical: _size.height * 0.005,
                          ),
                          child: Text("${actData.state}")),
                    ],
                  )
                ],
              ),
              Divider(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Column(
                    children: [
                      Container(
                        child: Text("Skill", style: _styleTextTitle),
                        margin: EdgeInsets.symmetric(
                          horizontal: _size.width * 0.03,
                          vertical: _size.height * 0.005,
                        ),
                      ),
                      Container(
                          margin: EdgeInsets.symmetric(
                            horizontal: _size.width * 0.03,
                            vertical: _size.height * 0.005,
                          ),
                          child: FutureBuilder(
                              future: _usuarioProvider
                                  .getSkill(int.parse(actData.skill)),
                              builder: (BuildContext context, snapshot) {
                                if (snapshot.hasData) {
                                  log("snapshot => ${snapshot.data}}");
                                  return Text("${snapshot.data["name"]}");
                                } else {
                                  return Text("");
                                }
                              })),
                    ],
                  ),
                  Column(
                    children: [
                      Container(
                        child: Text("Fecha", style: _styleTextTitle),
                        margin: EdgeInsets.symmetric(
                          horizontal: _size.width * 0.03,
                          vertical: _size.height * 0.005,
                        ),
                      ),
                      Container(
                          margin: EdgeInsets.symmetric(
                            horizontal: _size.width * 0.03,
                            vertical: _size.height * 0.005,
                          ),
                          child: Text(
                              "${formatter.format(DateTime.parse(actData.date))}")),
                    ],
                  )
                ],
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: _crearBoton(context),
    );
  }

  Widget _crearBoton(BuildContext context) {
    if (actData.postedBy != _prefs.uid) {
      return FloatingActionButton(
          onPressed: () => _showModalCreateRequest(context),
          child: Icon(
            Icons.add,
          ),
          backgroundColor: Colors.grey);
    }
    return Container();
  }

  void _showModalCreateRequest(BuildContext context) {
    showDialog(
        context: context,
        builder: (context) {
          return Container(
            child: AlertDialog(
              title: Text('Crear Solicitud'),
              content: Container(
                margin: EdgeInsets.symmetric(vertical: 10.0),
                padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
                width: _size.width * 0.8,
                decoration: BoxDecoration(
                    color: Colors.grey.shade100,
                    borderRadius: BorderRadius.circular(29)),
                child: StreamBuilder<String>(
                    stream: _bloc.descriptionStream,
                    builder: (context, snapshot) {
                      return TextField(
                        onChanged: (value) => _bloc.changeDescription(value),
                        decoration: InputDecoration(
                            hintText: "Descripción de la Solicitud",
                            border: InputBorder.none,
                            icon: Icon(Icons.task, color: Colors.black12),
                            errorText: snapshot.error),
                        maxLines: 4,
                        keyboardType: TextInputType.name,
                      );
                    }),
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: Text("Cancelar"),
                ),
                StreamBuilder<Object>(
                    stream: _bloc.formValidStream,
                    builder: (context, snapshot) {
                      return TextButton(
                        onPressed: () => _createRequest(context),
                        child: Text('Crear'),
                      );
                    })
              ],
            ),
          );
        });
  }

  _createRequest(BuildContext context) async {
    _requestModel.description = _bloc.description;
    _requestModel.requestby = _prefs.uid;
    _requestModel.activity = actData.id;

    final bool = await _activityProvider.createRequest(_requestModel);
    if (bool) {
      print("resp ---> $bool");
      mostrarAlerta(context, "Actividad Creada con Exito");
    } else {
      print("resp ---> $bool");
      mostrarAlerta(context, "No se pudo crear la actividad");
    }
  }
}
