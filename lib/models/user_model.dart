import 'package:flutter/material.dart';

class User {
  final String id;
  final String username;
  final String? email;
  final String? profileImage;
  final List<int>? favoriteMovies;

  User({
    required this.id,
    required this.username,
    this.email,
    this.profileImage,
    this.favoriteMovies,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      username: json['username'] ?? 'Guest',
      email: json['email'],
      profileImage: json['profile_image'],
      favoriteMovies: (json['favorite_movies'] as List<dynamic>?)
              ?.map((id) => id as int)
              .toList() ??
          [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'username': username,
      'email': email,
      'profile_image': profileImage,
      'favorite_movies': favoriteMovies,
    };
  }
}
