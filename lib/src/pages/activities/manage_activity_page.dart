import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:homehealth/src/bloc/activity_bloc.dart';
import 'package:homehealth/src/models/activity_model.dart';
import 'package:homehealth/src/providers/activity_provider.dart';
import 'package:homehealth/src/providers/provider.dart';
import 'package:homehealth/src/utils/utils.dart';
import 'package:homehealth/src/widgets/background.dart';
import 'package:intl/intl.dart';

class ManageActivityPage extends StatefulWidget {

  @override
  _ManageActivityPageState createState() => _ManageActivityPageState();
}

class _ManageActivityPageState extends State<ManageActivityPage> {
  final _textEditingController = new TextEditingController();
  ActivityModel _activityModel = new ActivityModel();
  ActivityProvider _activityProvider = new ActivityProvider();

  List<dynamic> _skills = [];

  String _skillSelected;

  @override
  void initState() {
    super.initState();
    this.getSkills();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final _bloc = Provider.activity(context);
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: Text("Crear Actividad"),
        elevation: 0.0,
        backgroundColor: Colors.transparent,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Background(
          child: Container(
            margin: EdgeInsets.only(top: size.height * 0.15),
            child: Column(
              children: [
                Container(
                  margin: EdgeInsets.symmetric(vertical:10.0),
                  padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
                  width: size.width * 0.8,
                  decoration: BoxDecoration(
                    color: Colors.grey.shade100,
                    borderRadius: BorderRadius.circular(29)
                  ),
                  child: StreamBuilder<Object>(
                    stream: _bloc.nameStream,
                    builder: (context, snapshot) {
                      return TextField(
                        onChanged: (value) => _bloc.changeName(value),
                        decoration: InputDecoration(
                          hintText: "Nombre de la actividad",
                          border: InputBorder.none,
                          icon: Icon(Icons.task, color: Colors.black12),
                          errorText: snapshot.error
                        ),
                        keyboardType: TextInputType.name,
                      );
                    }
                  ),
                ),
                Container(
                  margin: EdgeInsets.symmetric(vertical:10.0),
                  padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
                  width: size.width * 0.8,
                  decoration: BoxDecoration(
                    color: Colors.grey.shade100,
                    borderRadius: BorderRadius.circular(29)
                  ),
                  child: StreamBuilder<Object>(
                    stream: _bloc.descriptionStream,
                    builder: (context, snapshot) {
                      return TextField(
                        onChanged: (value) => _bloc.changeDescription(value),
                        decoration: InputDecoration(
                          hintText: "Descripción de la actividad",
                          border: InputBorder.none,
                          icon: Icon(Icons.description, color: Colors.black12),
                          errorText: snapshot.error
                        ),
                        maxLines: 4,
                        keyboardType: TextInputType.name,
                      );
                    }
                  ),
                ),
                Container(
                  margin: EdgeInsets.symmetric(vertical:10.0),
                  padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
                  width: size.width * 0.8,
                  decoration: BoxDecoration(
                    color: Colors.grey.shade100,
                    borderRadius: BorderRadius.circular(29)
                  ),
                  child: StreamBuilder<Object>(
                    stream: _bloc.priceStream,
                    builder: (context, snapshot) {
                      return TextField(
                        onChanged: (value) => _bloc.changePrice(value),
                        decoration: InputDecoration(
                          hintText: "Precio por hora",
                          border: InputBorder.none,
                          icon: Icon(Icons.monetization_on_outlined, color: Colors.black12),
                          errorText: snapshot.error
                        ),
                        keyboardType: TextInputType.number,
                      );
                    }
                  ),
                ),
                Container(
                  margin: EdgeInsets.symmetric(vertical:10.0),
                  padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
                  width: size.width * 0.8,
                  decoration: BoxDecoration(
                    color: Colors.grey.shade100,
                    borderRadius: BorderRadius.circular(29)
                  ),
                  child: StreamBuilder<Object>(
                    stream: _bloc.hoursStream,
                    builder: (context, snapshot) {
                      return TextField(
                        onChanged: (value) => _bloc.changeHours(value),
                        decoration: InputDecoration(
                          hintText: "Horas Estimadas",
                          border: InputBorder.none,
                          icon: Icon(Icons.watch_later_outlined, color: Colors.black12),
                          errorText: snapshot.error
                        ),
                        keyboardType: TextInputType.number,
                      );
                    }
                  ),
                ),
                Container(
                  margin: EdgeInsets.symmetric(vertical: 10),
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                  width: size.width * 0.8,
                  decoration: BoxDecoration(
                    color: Colors.grey.shade100,
                    borderRadius: BorderRadius.circular(29)
                  ),
                  child: StreamBuilder(
                    stream: _bloc.dateStream,
                    builder: (context, snapshot) {
                      return TextField(
                        onChanged: (value) => {},
                        controller: _textEditingController,
                        keyboardType: TextInputType.text,
                        decoration: InputDecoration(
                        icon: Icon(Icons.calendar_today, color: Colors.black12),
                          hintText: "Fecha de realización",
                          border: InputBorder.none,
                        ),
                        onTap: () {
                          FocusScope.of(context).requestFocus(new FocusNode());
                          _selectDate(context, _bloc);
                        },
                      );
                    }
                  )
                ),
                Container(
                  margin: EdgeInsets.symmetric(vertical: 10),
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                  width: size.width * 0.8,
                  decoration: BoxDecoration(
                    color: Colors.grey.shade100,
                    borderRadius: BorderRadius.circular(29)
                  ),
                  child: StreamBuilder<Object>(
                    stream: _bloc.skillStream,
                    builder: (context, snapshot) {
                      return DropdownButtonHideUnderline(
                        child: DropdownButton(
                          icon: Icon(Icons.attribution_outlined, color: Colors.black12),
                          value: snapshot.data,
                          items: _skills.map((dynamic item){
                            return DropdownMenuItem(
                              child: Text(item["name"]),
                              value: item["id"]
                            );
                          }).toList(),
                          onChanged: (value){
                            setState(() {
                              _bloc.changeSkill(value);
                            });
                          },
                        ),
                      );
                    }
                  ),
                ),
              SizedBox(height: size.height * 0.02),
              StreamBuilder(
                stream: _bloc.formValidStream,
                builder: (context, snapshot) {
                  return ElevatedButton(
                    onPressed: snapshot.hasData
                      ? () => createActivity(_bloc, context)
                      : null,
                    child: Container(
                      child: Text(
                        'Crear Actividad',
                        style: TextStyle(fontSize: 18.0),
                      ),
                      padding: EdgeInsets.symmetric(vertical: 19, horizontal: 100),
                    ),
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(29)
                      ),
                      elevation: 0.0,
                      primary: Colors.deepPurple,
                      onPrimary: Colors.white
                    )
                  );
                }
              ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  getSkills() async {
    this._skills = await _activityProvider.getSkills();
  }

  createActivity(ActivityBloc bloc, BuildContext context) async {
    print("Creando Actividad");
    _activityModel.creationDate = (new DateTime.now()).toString();
    _activityModel.description = bloc.description;
    _activityModel.estimatedHours =  int.parse(bloc.hours);
    _activityModel.pricePerHour = int.parse(bloc.price);
    _activityModel.date = bloc.date;
    _activityModel.title = bloc.name;
    _activityModel.skill = bloc.skill;
    _activityModel.state = "Sin Asignar";
    
    bool resp = await _activityProvider.createActivity(_activityModel);
    if (resp) {
      print("resp ---> $resp");
      mostrarAlerta(context, "Actividad Creada con Exito");
    } else {
      print("resp ---> $resp");
      mostrarAlerta(context, "No se pudo crear la actividad");
    }
  }

  void _selectDate(BuildContext context,ActivityBloc bloc) async {
    DateTime picked = await showDatePicker(
      context: context,
      initialDate: new DateTime.now(),
      firstDate: new DateTime(1900),
      lastDate: new DateTime(2025),
      locale: Locale('es', 'ES')
    );
    if (picked != null) {
      final formatDate = new DateFormat("dd-MM-yyyy");
      bloc.changeDate(picked.toString());
      _textEditingController.text = formatDate.format(picked);
    }
  }
}