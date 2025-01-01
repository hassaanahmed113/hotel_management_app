import 'package:cloud_firestore/cloud_firestore.dart';

class UserProfile {
  final String? blockNumber;
  final bool? isAdmin;
  Charges? charges;
  final String? degree;
  final String? email;
  final String? firstName;
  final String? lastName;
  final int? roomNumber;
  final String? userId;
  final String? username;

  UserProfile({
    this.blockNumber,
    this.charges,
    this.degree,
    this.firstName,
    this.lastName,
    this.isAdmin,
    this.email,
    this.roomNumber,
    this.userId,
    this.username,
  });

  factory UserProfile.fromJson(Map<String, dynamic> json) {
    return UserProfile(
      blockNumber: json['block_number'] as String?,
      isAdmin: json['isAdmin'] as bool?,
      charges:
          json['charges'] != null ? Charges.fromJson(json['charges']) : null,
      degree: json['degree'] as String?,
      email: json['email'] as String?,
      firstName: json['firstName'] as String?,
      lastName: json['lastName'] as String?,
      roomNumber: json['room_number'] as int?,
      userId: json['user_id'] as String?,
      username: json['username'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'block_number': blockNumber,
      'isAdmin': isAdmin,
      'charges': charges?.toJson(), // Call charges.toJson()
      'degree': degree,
      'email': email,
      'firstName': firstName,
      'lastName': lastName,
      'room_number': roomNumber,
      'user_id': userId,
      'username': username,
    };
  }

  UserProfile copyWith({
    String? blockNumber,
    Charges? charges,
    bool? isAdmin,
    String? degree,
    String? email,
    String? firstName,
    String? lastName,
    int? roomNumber,
    String? userId,
    String? username,
  }) {
    return UserProfile(
      blockNumber: blockNumber ?? this.blockNumber,
      isAdmin: isAdmin ?? this.isAdmin,
      charges: charges ?? this.charges,
      degree: degree ?? this.degree,
      email: email ?? this.email,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      roomNumber: roomNumber ?? this.roomNumber,
      userId: userId ?? this.userId,
      username: username ?? this.username,
    );
  }

  @override
  String toString() {
    return 'UserProfile(blockNumber: $blockNumber, charges: $charges, degree: $degree, email: $email, name: $firstName, roomNumber: $roomNumber, userId: $userId, username: $username)';
  }
}

class Charges {
  final num? maintenance;
  final num? parking;
  final num? roomCharge;
  final num? water;
  final String? status;
  final String? feeId;
  final Timestamp? lastPaid; // Change to Timestamp

  Charges({
    this.maintenance,
    this.parking,
    this.roomCharge,
    this.water,
    this.status,
    this.feeId,
    this.lastPaid,
  });

  factory Charges.fromJson(Map<String, dynamic> json) {
    return Charges(
      maintenance: json['maintenance'] as num?,
      parking: json['parking'] as num?,
      roomCharge: json['room_charge'] as num?,
      water: json['water'] as num?,
      status: json['status'] as String?,
      feeId: json['feeId'] as String?,
      lastPaid: json['lastPaid'] != null ? json['lastPaid'] as Timestamp : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'maintenance': maintenance,
      'parking': parking,
      'room_charge': roomCharge,
      'water': water,
      'status': status,
      'feeId': feeId,
      'lastPaid': lastPaid,
    };
  }

  Charges copyWith({
    num? maintenance,
    num? parking,
    num? roomCharge,
    num? water,
    String? status,
    String? feeId,
    Timestamp? lastPaid,
  }) {
    return Charges(
        maintenance: maintenance ?? this.maintenance,
        parking: parking ?? this.parking,
        roomCharge: roomCharge ?? this.roomCharge,
        water: water ?? this.water,
        feeId: feeId ?? this.feeId,
        lastPaid: lastPaid ?? this.lastPaid,
        status: status ?? this.status);
  }

  @override
  String toString() {
    return 'Charges(maintenance: $maintenance, parking: $parking, roomCharge: $roomCharge, water: $water)';
  }
}
