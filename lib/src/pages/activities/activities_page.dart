import 'package:flutter/material.dart';
import 'package:homehealth/src/providers/activity_provider.dart';
import 'package:homehealth/src/widgets/card_activity.dart';

class ActivitiesPage extends StatelessWidget {

  ActivityProvider _activityProvider = new ActivityProvider();
  List _activities = [];
  
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      child: _createListMyActivities(),
      margin: EdgeInsets.only(top: size.height * 0.05),
    );
  }

  Widget _createListMyActivities(){
    return FutureBuilder(
      future: _activityProvider.getActivities(),
      builder: (BuildContext context, AsyncSnapshot<List<ActivityModel>> snapshot){
        if(snapshot.hasData){
          _activities = snapshot.data;
          return ListView.builder(
            padding: EdgeInsets.all(10.0),
            shrinkWrap: true,
            itemCount: _activities.length,
            itemBuilder: (context,index) {
              if(_activities.length > 0 ) {
                return CardActivity(activity: _activities[index]);
              } else {
                return Center(child: Text("No tiene actividades creadas!!!"));
              }
            },
          );
        }else{
          return Center(
            child: CircularProgressIndicator() ,
          );
        }
      },
    );
  }

}