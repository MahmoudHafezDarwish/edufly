// To parse this JSON data, do
//
//     final appUser = appUserFromJson(jsonString);
import 'package:flutter/material.dart';
import 'dart:convert';
AppUser appUserFromJson(String str) => AppUser.fromJson(json.decode(str));

String appUserToJson(AppUser data) => json.encode(data.toJson());

class AppUser {
    AppUser({
        required this.name,
        required this.bio,
        required this.profilePicture,
        required this.isplus,
        required this.email,
    });

    String name;
    // Timestamp birthdate;
    String bio;
    String profilePicture;
    bool isplus;
    String email;

    factory AppUser.fromJson(Map<String, dynamic> json) => AppUser(
        name: json["name"],
        bio: json["bio"],
        profilePicture: json["profilePicture"],
        isplus: json["isplus"],
        email: json["email"],
    );

    Map<String, dynamic> toJson() => {
        "name": name,
        "bio": bio,
        "profilePicture": profilePicture,
        "isplus": isplus,
        "email": email,
    };
}
