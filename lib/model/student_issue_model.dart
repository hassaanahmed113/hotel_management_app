import 'package:again/model/create_issue_model.dart';
import 'package:again/model/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class StudentIssue {
  List<Issue>? allUserIssue;
  final UserProfile? user;
  final String? userId;

  StudentIssue({
    this.allUserIssue,
    this.user,
    this.userId,
  });

  /// Factory method to create a `StudentIssue` instance from a JSON map
  factory StudentIssue.fromJson(Map<String, dynamic> json) {
    return StudentIssue(
      allUserIssue: json['all_user_issue'] != null
          ? (json['all_user_issue'] as List<dynamic>)
              .map((e) => Issue.fromJson(e as Map<String, dynamic>))
              .toList()
          : null, // Parse list of Issue objects
      user: json['user'] != null
          ? UserProfile.fromJson(json['user'] as Map<String, dynamic>)
          : null, // Parse UserProfile
      userId: json['user_id'] as String?,
    );
  }

  /// Converts `StudentIssue` instance to JSON map
  Map<String, dynamic> toJson() {
    return {
      'all_user_issue': allUserIssue?.map((issue) => issue.toJson()).toList(),
      'user': user?.toJson(), // Convert UserProfile to JSON
      'user_id': userId,
    };
  }

  /// Creates a copy of the instance with modified fields
  StudentIssue copyWith({
    List<Issue>? allUserIssue,
    UserProfile? user,
    String? userId,
  }) {
    return StudentIssue(
      allUserIssue: allUserIssue ?? this.allUserIssue,
      user: user ?? this.user,
      userId: userId ?? this.userId,
    );
  }

  @override
  String toString() {
    return 'StudentIssue(allUserIssue: $allUserIssue, user: $user, userId: $userId)';
  }
}
