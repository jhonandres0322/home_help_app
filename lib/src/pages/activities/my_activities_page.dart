import 'package:flutter/material.dart';
import 'package:homehealth/src/models/activity_model.dart';
import 'package:homehealth/src/providers/activity_provider.dart';
import 'package:homehealth/src/widgets/card_activity.dart';
import 'package:homehealth/src/widgets/background.dart';

class MyActivitiesPage extends StatefulWidget {


  @override
  _MyActivitiesPageState createState() => _MyActivitiesPageState();
}

class _MyActivitiesPageState extends State<MyActivitiesPage> {

  ActivityProvider _activityProvider = new ActivityProvider();
  List _myActivities = [];

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      child: _createListMyActivities(),
      margin: EdgeInsets.only(top: size.height * 0.1),
    );
  }

  Widget _createListMyActivities(){
    return FutureBuilder(
      future: _activityProvider.getMyActivities(),
      builder: (BuildContext context, AsyncSnapshot<List<ActivityModel>> snapshot){
        if(snapshot.hasData){
          _myActivities = snapshot.data;
          return ListView.builder(
            padding: EdgeInsets.all(10.0),
            shrinkWrap: true,
            itemCount: _myActivities.length,
            itemBuilder: (context,index) {
              if(_myActivities.length > 0 ) {
                return CardActivity(activity: _myActivities[index]);
              } else {
                return Center(child: Text("No tiene actividades creadas!!!"));
              }
            },
            
          );
        }else{
          return Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }
}