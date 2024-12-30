class RoomChangeRequest {
  final String? blockNumber;
  final String? chngBlockNumber;
  final int? chngRoomNumber;
  final String? email;
  final String? firstName;
  final String? lastName;
  final String? reason;
  final String? requestId;
  final int? roomNumber;
  final String? status;
  final String? userId;

  RoomChangeRequest({
    this.blockNumber,
    this.chngBlockNumber,
    this.chngRoomNumber,
    this.email,
    this.firstName,
    this.lastName,
    this.reason,
    this.requestId,
    this.roomNumber,
    this.status,
    this.userId,
  });

  /// Factory method to create a `RoomChangeRequest` instance from a JSON map
  factory RoomChangeRequest.fromJson(Map<String, dynamic> json) {
    return RoomChangeRequest(
      blockNumber: json['block_number'] as String?,
      chngBlockNumber: json['chng_block_number'] as String?,
      chngRoomNumber: json['chng_room_number'] as int?,
      email: json['email'] as String?,
      firstName: json['firstName'] as String?,
      lastName: json['lastName'] as String?,
      reason: json['reason'] as String?,
      requestId: json['request_id'] as String?,
      roomNumber: json['room_number'] as int?,
      status: json['status'] as String?,
      userId: json['user_id'] as String?,
    );
  }

  /// Converts `RoomChangeRequest` instance to JSON map
  Map<String, dynamic> toJson() {
    return {
      'block_number': blockNumber,
      'chng_block_number': chngBlockNumber,
      'chng_room_number': chngRoomNumber,
      'email': email,
      'firstName': firstName,
      'lastName': lastName,
      'reason': reason,
      'request_id': requestId,
      'room_number': roomNumber,
      'status': status,
      'user_id': userId,
    };
  }

  /// Creates a copy of the instance with modified fields
  RoomChangeRequest copyWith({
    String? blockNumber,
    String? chngBlockNumber,
    int? chngRoomNumber,
    String? email,
    String? firstName,
    String? lastName,
    String? reason,
    String? requestId,
    int? roomNumber,
    String? status,
    String? userId,
  }) {
    return RoomChangeRequest(
      blockNumber: blockNumber ?? this.blockNumber,
      chngBlockNumber: chngBlockNumber ?? this.chngBlockNumber,
      chngRoomNumber: chngRoomNumber ?? this.chngRoomNumber,
      email: email ?? this.email,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      reason: reason ?? this.reason,
      requestId: requestId ?? this.requestId,
      roomNumber: roomNumber ?? this.roomNumber,
      status: status ?? this.status,
      userId: userId ?? this.userId,
    );
  }

  @override
  String toString() {
    return 'RoomChangeRequest(blockNumber: $blockNumber, chngBlockNumber: $chngBlockNumber, chngRoomNumber: $chngRoomNumber, email: $email, firstName: $firstName, lastName: $lastName, reason: $reason, requestId: $requestId, roomNumber: $roomNumber, status: $status, userId: $userId)';
  }
}
