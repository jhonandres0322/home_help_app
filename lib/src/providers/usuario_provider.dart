import 'dart:convert';
import 'dart:collection';
import 'dart:developer';
import 'package:homehealth/src/models/profile_model.dart';
import 'package:homehealth/src/preferencias_usuario/preferencias_usuario.dart';

import 'package:http/http.dart' as http;

class UsuarioProvider {
  //cambiar dependiendo de  la base de datosd
  final String _firebaseToken = 'AIzaSyDgyaFe5aZooh0srj9mJ9YHKoDE1YgeHlM';
  final String _urlProfile =
      'https://homehelp-7ac26-default-rtdb.firebaseio.com';
  final _prefs = new PreferenciasUsuario();
  final String _urlSkill = 'https://homehelp-7ac26-default-rtdb.firebaseio.com/skills';
  

  Future<Map<String, dynamic>> login(String email, String password) async {
    final authData = {
      'email': email,
      'password': password,
      'returnSecureToken': true
    };
    final resp = await http.post(
        Uri.parse(
            'https://identitytoolkit.googleapis.com/v1/accounts:signInWithPassword?key=$_firebaseToken'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: json.encode(authData));
    Map<String, dynamic> decodedResp = json.decode(resp.body);
    log("decodedResp ---> $decodedResp");
    if (decodedResp.containsKey('idToken')) {
      //_prefs.token = decodedResp['idToken'];
      _prefs.uid = decodedResp['localId'];
      log("uid --> ${_prefs.uid}");
      return {
        'ok': true,
        'token': decodedResp['idToken'],
        'Uid': decodedResp['localId']
      };
    } else {
      return {'ok': false, 'mensaje': decodedResp['error']['message']};
    }
  }

  Future<Map<String, dynamic>> registerUser(
      String email, String password) async {
    final authData = {
      'email': email,
      'password': password,
      'returnSecureToken': true
    };
    final resp = await http.post(
        Uri.parse(
            'https://identitytoolkit.googleapis.com/v1/accounts:signUp?key=$_firebaseToken'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: json.encode(authData));
    print(resp);
    //print(resp.body);
    Map<String, dynamic> decodedResp = json.decode(resp.body);
    if (decodedResp.containsKey('idToken')) {
      _prefs.token = decodedResp['idToken'];
      _prefs.email = decodedResp['email'];
      return {
        'ok': true,
        'token': decodedResp['idToken'],
        'Uid': decodedResp['localId']
      };
    } else {
      return {'ok': false, 'mensaje': decodedResp['error']['message']};
    }
  }

  Future<bool> registerProfileUser(ProfileModel profile) async {
    final url =
        '$_urlProfile/profiles/${profile.uID}.json'; //  se le quita el authtentication pora hora porque genera problema con laregla del servidor "?auth=${_prefs.token}"
    profile.user = _prefs.email;
    final resp = await http.post(Uri.parse(url), body: profileToJson(profile));
    Map<String, dynamic> decodedData = json.decode(resp.body);
    log(" DECODED DATA ----> $decodedData ");
    if (decodedData.containsKey('name')) {
      return true;
    } else {
      return false;
    }
  }

  Future<bool> updateProfileUser(ProfileModel profile) async {
    final url =
        '$_urlProfile/profiles/${profile.uID}.json'; //  se le quita el authtentication pora hora porque genera problema con laregla del servidor "?auth=${_prefs.token}"
    profile.user = _prefs.email;

    final resp = await http.put(Uri.parse(url), body: profileToJson(profile));
    Map<String, dynamic> decodedData = json.decode(resp.body);
    log(" DECODED DATA ----> $decodedData ");
    if (decodedData.containsKey('name')) {
      return true;
    } else {
      return false;
    }
  }

  ///     ESTE METODO NO SE A TERMINA DO DEVUELVE UN OBJETO PROFILE PERO EL OBJETO ESTA VACIO FALTA RELLENARLO CKON L RESPUESTA DE LACONSUTLA Y VERIFICAR LA CONSULTA JSLR
  Future<dynamic> getProfileUser() async {
    final uidProfile = _prefs.uid;
    print("uidProfile ----> $uidProfile");
    dynamic infoProfile; 
    final url = 'https://homehelp-7ac26-default-rtdb.firebaseio.com/profiles/.json';
    final resp = await http.get(
      Uri.parse(url),
    );
    Map<String, dynamic> decodedResp = json.decode(resp.body);
    decodedResp.forEach((key, value) {
      if(key == uidProfile){
        Map<String,dynamic> profile = HashMap.from(value);
        infoProfile = profile.values.first;
        List skills = [];
        log("infoProfile => $infoProfile");
        log("infoProfile => ${infoProfile['skills']}");
        if(!infoProfile["skills"].isEmpty) {
          infoProfile["skills"].forEach((key,value){
            var skillTemp = {};
            skillTemp["skill"] = key;
            skillTemp["score"] = value;
            skills.add(skillTemp);
          });
          infoProfile["skills"] = skills;
        }

      }
    });
    if(!infoProfile["skills"].isEmpty) {
      for (var item in infoProfile["skills"]) {
        log("skill => ${item["skill"]}");
        item = await getSkill(item);
      }
    }
    return infoProfile;
  }

  getSkill(item) async {
    log("item => $item");
    String url = "";
    if(item is int){
      log("entrando al if");
      url = '$_urlSkill/$item.json';
      final resp = await http.get(
        Uri.parse(url),
      );
      Map<String, dynamic> decodedResp = json.decode(resp.body);
      var newItem = {};
      newItem["skill"] = item;
      newItem["name"] = decodedResp["name"];
      log("newItem => $newItem");
      return newItem;
    } else {
      log("entrando al else");
      url = '$_urlSkill/${item["skill"]}.json';
      final resp = await http.get(
        Uri.parse(url),
      );
      Map<String, dynamic> decodedResp = json.decode(resp.body);
      item["name"] = decodedResp["name"];
      item["image"] = decodedResp["image"];
      return item;
    }
  }

  cerrarSesion()  {
    _prefs.email = "";
    _prefs.token = "";
    _prefs.uid = "";
  }
}
