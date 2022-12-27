import 'package:flutter/material.dart';
import 'package:homehealth/src/models/activity_model.dart';
import 'package:intl/intl.dart';

class CardActivity extends StatelessWidget {

  ActivityModel activity;
  final formatCurrency = new NumberFormat.simpleCurrency();
  CardActivity({ @required this.activity});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Column(
      children: [
        Card(
          elevation: 10.0,
          shadowColor: Colors.black,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
          child: Column(
            children: [
              Container(
                height: size.height * 0.15,
                child: ListTile(
                  leading: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.task_alt_outlined,
                        size: size.width * 0.1
                      ),
                    ],
                  ),
                  onTap: () => Navigator.pushNamed(context, "activity",arguments: activity),
                  title: Container(
                    margin: EdgeInsets.all(size.height * 0.01),
                    child: Text(
                      activity.title,
                      style: TextStyle(
                        fontSize: 22.0,
                        fontWeight: FontWeight.bold,
                        fontFamily: "Roboto"
                      ),
                      textAlign: TextAlign.end,
                    ),
                  ),
                  subtitle: Column(
                    children: [
                      Container(
                        margin: EdgeInsets.only(
                          top: size.height * 0.01,
                          left: size.width * 0.4
                        ),
                        child: Text(
                          activity.timeAgo,
                          style: TextStyle(
                            fontSize: 17.0
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: size.height * 0.02),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Text(
                              '${formatCurrency.format(activity.pricePerHour)}',
                              style: TextStyle(
                                fontSize: 15.0
                              ),
                            ),
                            Text(
                              activity.estimatedHours == 1
                              ? "${activity.estimatedHours} hora"
                              : "${activity.estimatedHours} horas",
                              style: TextStyle(
                                fontSize: 15.0
                              ),
                            ),
                            Text("Posteado por: ${activity.namePosted}")
                          ],
                        ),
                      )
                    ],
                  ),
                  
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 10.0,)
      ],
    );
  }
}