// To parse this JSON data, do
//
//     final skillModel = skillModelFromJson(jsonString);

import 'dart:convert';

SkillModel skillModelFromJson(String str) => SkillModel.fromJson(json.decode(str));

String skillModelToJson(SkillModel data) => json.encode(data.toJson());

class SkillModel {
    SkillModel({
        this.name,
        this.score,
    });

    String name;
    int score;

    factory SkillModel.fromJson(Map<String, dynamic> json) => SkillModel(
        name: json["name"],
        score: json["score"],
    );

    Map<String, dynamic> toJson() => {
        "name": name,
        "score": score,
    };
}
