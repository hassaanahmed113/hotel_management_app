class Room {
  final String? blockNumber;
  final int? occupied;
  final int? maxRoom;
  final String? roomId;
  final int? roomNumber;
  final String? roomType; // Nullable field

  Room({
    this.blockNumber,
    this.occupied,
    this.maxRoom,
    this.roomId,
    this.roomNumber,
    this.roomType, // Nullable field
  });

  Map<String, dynamic> toJson() {
    return {
      'block_number': blockNumber,
      'occupied': occupied,
      'maxRoom': maxRoom,
      'room_id': roomId,
      'room_number': roomNumber,
      'room_type': roomType, // Nullable, can be null
    };
  }

  factory Room.fromJson(Map<String, dynamic> json) {
    return Room(
      blockNumber: json['block_number'] as String?,
      occupied: json['occupied'] as int?,
      maxRoom: json['maxRoom'] as int?,
      roomId: json['room_id'] as String?,
      roomNumber: json['room_number'] as int?,
      roomType: json['room_type'] as String?, // Nullable
    );
  }

  Room copyWith({
    String? blockNumber,
    int? occupied,
    int? maxRoom,
    String? roomId,
    int? roomNumber,
    String? roomType, // Nullable
  }) {
    return Room(
      blockNumber: blockNumber ?? this.blockNumber,
      occupied: occupied ?? this.occupied,
      maxRoom: maxRoom ?? this.maxRoom,
      roomId: roomId ?? this.roomId,
      roomNumber: roomNumber ?? this.roomNumber,
      roomType: roomType ?? this.roomType, // Nullable field
    );
  }

  @override
  String toString() {
    return 'Room(blockNumber: $blockNumber, occupied: $occupied, maxRoom: $maxRoom, roomId: $roomId, roomNumber: $roomNumber, roomType: $roomType)';
  }
}
