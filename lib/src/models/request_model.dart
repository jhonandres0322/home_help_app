// To parse this JSON data, do
//
//     final requestModel = requestModelFromJson(jsonString);

import 'dart:convert';

RequestModel requestModelFromJson(String str) => RequestModel.fromJson(json.decode(str));

String requestModelToJson(RequestModel data) => json.encode(data.toJson());

class RequestModel {
    RequestModel({
        this.description,
        this.activity,
        this.requestby,
    }); 

    String description;
    String activity;
    String requestby;

    factory RequestModel.fromJson(Map<String, dynamic> json) => RequestModel(
        description: json["description"],
        activity: json["activity"],
        requestby: json["requestby"],
    );

    Map<String, dynamic> toJson() => {
        "description": description,
        "activity": activity,
        "requestby": requestby,
    };
}
