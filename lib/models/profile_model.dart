// To parse this JSON data, do
//
//     final profileModel = profileModelFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

ProfileModel profileModelFromJson(String str) =>
    ProfileModel.fromJson(json.decode(str));

String profileModelToJson(ProfileModel data) => json.encode(data.toJson());

class ProfileModel {
  final bool success;
  final User user;

  ProfileModel({
    required this.success,
    required this.user,
  });

  factory ProfileModel.fromJson(Map<String, dynamic> json) => ProfileModel(
        success: json["success"],
        user: User.fromJson(json["user"]),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "user": user.toJson(),
      };
}

class User {
  final String id;
  final String name;
  final String email;
  final String phoneNumber;
  final String address;
  final String gender;
  final String role;
  final int points;
  final List<dynamic> purchaseHistory;
  final List<dynamic> recommendedProduct;
  final bool isVerified;
  final dynamic otp;
  final dynamic otpExpiry;
  final DateTime createdAt;
  final DateTime updatedAt;
  final int v;
  final dynamic resetPasswordOtp;
  final dynamic resetPasswordOtpExpiry;
  final String? imgUrl; // ✅ Add this line

  User({
    required this.id,
    required this.name,
    required this.email,
    required this.phoneNumber,
    required this.address,
    required this.gender,
    required this.role,
    required this.points,
    required this.purchaseHistory,
    required this.recommendedProduct,
    required this.isVerified,
    required this.otp,
    required this.otpExpiry,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
    required this.resetPasswordOtp,
    required this.resetPasswordOtpExpiry,
    this.imgUrl, // ✅ Add this
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["_id"],
        name: json["name"],
        email: json["email"],
        phoneNumber: json["phoneNumber"],
        address: json["address"],
        gender: json["gender"],
        role: json["role"],
        points: json["points"],
        purchaseHistory:
            List<dynamic>.from(json["purchaseHistory"].map((x) => x)),
        recommendedProduct:
            List<dynamic>.from(json["recommendedProduct"].map((x) => x)),
        isVerified: json["isVerified"],
        otp: json["otp"],
        otpExpiry: json["otpExpiry"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        v: json["__v"],
        resetPasswordOtp: json["resetPasswordOtp"],
        resetPasswordOtpExpiry: json["resetPasswordOtpExpiry"],
        imgUrl: json["imgUrl"], // ✅ Add this
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "name": name,
        "email": email,
        "phoneNumber": phoneNumber,
        "address": address,
        "gender": gender,
        "role": role,
        "points": points,
        "purchaseHistory": List<dynamic>.from(purchaseHistory.map((x) => x)),
        "recommendedProduct":
            List<dynamic>.from(recommendedProduct.map((x) => x)),
        "isVerified": isVerified,
        "otp": otp,
        "otpExpiry": otpExpiry,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "__v": v,
        "resetPasswordOtp": resetPasswordOtp,
        "resetPasswordOtpExpiry": resetPasswordOtpExpiry,
        "imgUrl": imgUrl, // ✅ Add this
      };
}
