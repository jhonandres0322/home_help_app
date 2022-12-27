// To parse this JSON data, do
//
//     final activityModel = activityModelFromJson(jsonString);

import 'dart:convert';

ActivityModel activityModelFromJson(String str) => ActivityModel.fromJson(json.decode(str));

String activityModelToJson(ActivityModel data) => json.encode(data.toJson());

class ActivityModel {
    ActivityModel({
        this.id,
        this.title,
        this.description,
        this.state,
        this.pricePerHour,
        this.estimatedHours,
        this.creationDate,
        this.skill,
        this.date,
        this.postedBy,
        this.namePosted,
        this.timeAgo,
    });

    String id;
    String title;
    String description;
    String state;
    int pricePerHour;
    int estimatedHours;
    String creationDate;
    dynamic skill;
    String date;
    String postedBy;
    String namePosted;
    String timeAgo;

    factory ActivityModel.fromJson(Map<String, dynamic> json) => ActivityModel(
        id: json["id"],
        title: json["title"],
        description: json["description"],
        state: json["state"],
        pricePerHour: json["price_per_hour"],
        estimatedHours: json["estimated_hours"],
        creationDate: json["creation_date"],
        skill: json["skill"],
        postedBy: json["posted_by"],
        date: json["date"],
        namePosted: json["name_posted"],
        timeAgo: json["timeAgo"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "description": description,
        "state": state,
        "price_per_hour": pricePerHour,
        "estimated_hours": estimatedHours,
        "creation_date": creationDate,
        "skill": skill,
        "date" : date,
        "posted_by": postedBy,
        "namePosted": namePosted,
        "timeAgo": timeAgo
    };
}
