import 'dart:collection';
import 'dart:developer';
import 'package:homehealth/src/models/activity_model.dart';
import 'package:homehealth/src/models/request_model.dart';
import 'package:homehealth/src/preferencias_usuario/preferencias_usuario.dart';
import 'package:homehealth/src/providers/usuario_provider.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
export 'package:homehealth/src/models/activity_model.dart';
import 'package:timeago/timeago.dart' as timeago;


class ActivityProvider{

  final String _url = 'https://homehelp-7ac26-default-rtdb.firebaseio.com//activities.json';
  final _prefs = new PreferenciasUsuario();
  final _usuarioProvider = new UsuarioProvider();
  List<ActivityModel> myActivities = [];
  List<ActivityModel> activities = [];

  Future<bool> createActivity(ActivityModel activity) async{
    activity.postedBy = _prefs.uid;
    final url = '$_url';
    final resp = await http.post(
      Uri.parse(url),
      body:activityModelToJson(activity)
    );
    Map<String, dynamic> decodedResp = json.decode(resp.body);
    print("decodeResp ---> $decodedResp");
    if (decodedResp.containsKey('name')) {
      return true;
    } else {
      return false;
    }
  }

  updateActivity(ActivityModel activity) async{

  }


  deleteActivity(ActivityModel activity) async{

  }

  Future<List<ActivityModel>> getMyActivities() async {
    myActivities = [];
    final url = '$_url';
    final resp = await http.get(
      Uri.parse(url),
    );
    Map<String, dynamic> decodedResp = json.decode(resp.body);
    if(decodedResp == null ) return [];
    decodedResp.forEach((id,actividad) { 
      if(actividad["posted_by"] == _prefs.uid) {
        final actividadTemp = ActivityModel.fromJson(actividad);
        actividadTemp.id = id;
        myActivities.add(actividadTemp);
      }
    });
    myActivities.sort((a,b) {
      var aDate = DateTime.parse(a.creationDate);
      var bDate = DateTime.parse(b.creationDate);
      return bDate.compareTo(aDate);
    });
    for (var item in myActivities) {
      item.namePosted = await this.getNamePostedBy(item.postedBy);
      log("item skill => ${item.skill}");
      item.timeAgo = timeago.format(DateTime.parse(item.creationDate), locale: 'es');
    }
    return myActivities;
  }

  Future<List<ActivityModel>> getActivities() async {
    activities = [];
    final url = '$_url';
    final resp = await http.get(
      Uri.parse(url),
    );
    Map<String, dynamic> decodedResp = json.decode(resp.body);
    if(decodedResp == null ) return [];

    decodedResp.forEach((id,actividad) { 
      if(actividad["posted_by"] != _prefs.uid) {
        final actividadTemp = ActivityModel.fromJson(actividad);
        actividadTemp.id = id;
        activities.add(actividadTemp);
      }
    });
    activities.sort((a,b) {
      var aDate = DateTime.parse(a.creationDate);
      var bDate = DateTime.parse(b.creationDate);
      return bDate.compareTo(aDate);
    });
    for (var item in activities) {
      item.namePosted = await this.getNamePostedBy(item.postedBy);
      item.timeAgo = timeago.format(DateTime.parse(item.creationDate), locale: 'es');
    }

    return activities;
  }

  getSkills() async {
    final url = 'https://homehelp-7ac26-default-rtdb.firebaseio.com/skills/.json';
    final resp = await http.get(
      Uri.parse(url)
  );
    Map<String,dynamic> responseDecoded = json.decode(resp.body);
    var skills = [];
    responseDecoded.forEach((key, value) { 
      var skill = {};
      skill["name"] = value["name"];
      skill["id"] = key;
      skills.add(skill);
    });
    return skills;
  }

  Future<String> getNamePostedBy(String idProfile) async {
    print("idProfile ----> $idProfile");
    String firstname = "";
    final url = 'https://homehelp-7ac26-default-rtdb.firebaseio.com/profiles/.json';
    final resp = await http.get(
      Uri.parse(url),
    );
    Map<String, dynamic> decodedResp = json.decode(resp.body);
    decodedResp.forEach((key, value) {
      if(key == idProfile){
        Map<String,dynamic> profile = HashMap.from(value);
        firstname = profile.values.first['firstname'];
      }
    });
    return firstname;
  }

  createRequest(RequestModel request) async {
    final url = 'https://homehelp-7ac26-default-rtdb.firebaseio.com/requests/.json';
    final resp = await http.post(
      Uri.parse(url),
      body: requestModelToJson(request)
    );

    Map<String, dynamic> decodedResp = json.decode(resp.body);
    print("decodeResp ---> $decodedResp");
    if (decodedResp.containsKey('name')) {
      return true;
    } else {
      return false;
    }
  }

}