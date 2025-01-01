import 'package:cloud_firestore/cloud_firestore.dart';

class Issue {
  final String? blockNumber;
  final String? comment;
  final Timestamp? date; // Firestore Timestamp
  final String? email;
  final String? issueId;
  final String? issueStatus;
  final String? issueType;
  final Timestamp? lastUpdated; // Firestore Timestamp
  final String? phoneNumber;
  final int? roomNumber;
  final String? userId;
  final String? docId;

  Issue({
    this.blockNumber,
    this.comment,
    this.date,
    this.email,
    this.issueId,
    this.issueStatus,
    this.issueType,
    this.lastUpdated,
    this.phoneNumber,
    this.roomNumber,
    this.userId,
    this.docId,
  });

  factory Issue.fromJson(Map<String, dynamic> json) {
    return Issue(
      blockNumber: json['block_number'] as String?,
      comment: json['comment'] as String?,
      date: json['date'] != null
          ? json['date'] as Timestamp
          : null, // Directly use Timestamp
      email: json['email'] as String?,
      issueId: json['issue_id'] as String?,
      issueStatus: json['issue_status'] as String?,
      issueType: json['issue_type'] as String?,
      lastUpdated: json['last_updated'] != null
          ? json['last_updated'] as Timestamp
          : null, // Directly use Timestamp
      phoneNumber: json['phone_number'] as String?,
      roomNumber: json['room_number'] as int?,
      userId: json['user_id'] as String?,
      docId: json['docId'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'block_number': blockNumber,
      'comment': comment,
      'date': date, // Firestore Timestamp will be stored directly
      'email': email,
      'issue_id': issueId,
      'issue_status': issueStatus,
      'issue_type': issueType,
      'last_updated':
          lastUpdated, // Firestore Timestamp will be stored directly
      'phone_number': phoneNumber,
      'room_number': roomNumber,
      'user_id': userId,
      'docId': docId,
    };
  }

  Issue copyWith({
    String? blockNumber,
    String? comment,
    Timestamp? date, // Change to Timestamp
    String? email,
    String? issueId,
    String? issueStatus,
    String? issueType,
    Timestamp? lastUpdated, // Change to Timestamp
    String? phoneNumber,
    int? roomNumber,
    String? userId,
    String? docId,
  }) {
    return Issue(
      blockNumber: blockNumber ?? this.blockNumber,
      comment: comment ?? this.comment,
      date: date ?? this.date,
      email: email ?? this.email,
      issueId: issueId ?? this.issueId,
      issueStatus: issueStatus ?? this.issueStatus,
      issueType: issueType ?? this.issueType,
      lastUpdated: lastUpdated ?? this.lastUpdated,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      roomNumber: roomNumber ?? this.roomNumber,
      userId: userId ?? this.userId,
      docId: docId ?? this.docId,
    );
  }

  @override
  String toString() {
    return 'Issue(blockNumber: $blockNumber, comment: $comment, date: $date, email: $email, issueId: $issueId, issueStatus: $issueStatus, issueType: $issueType, lastUpdated: $lastUpdated, phoneNumber: $phoneNumber, roomNumber: $roomNumber)';
  }
}
