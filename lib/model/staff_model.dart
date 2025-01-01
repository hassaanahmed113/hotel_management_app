class Staff {
  String? email;
  String? firstName;
  String? lastName;
  String? pass;
  String? role;
  String? staffId;
  String? username;
  String? phone;

  // Constructor
  Staff({
    this.email,
    this.firstName,
    this.lastName,
    this.pass,
    this.role,
    this.staffId,
    this.username,
    this.phone,
  });

  // Factory method to create a Staff instance from a map (for Firebase or API response)
  factory Staff.fromMap(Map<String, dynamic> map) {
    return Staff(
      email: map['email'] ?? '',
      firstName: map['firstName'] ?? '',
      lastName: map['lastName'] ?? '',
      pass: map['pass'] ?? '',
      role: map['role'] ?? '',
      staffId: map['staff_id'] ?? '',
      username: map['username'] ?? '',
      phone: map['phone'] ?? '',
    );
  }

  // Method to convert Staff instance to a map (for saving to Firebase or sending to API)
  Map<String, dynamic> toMap() {
    return {
      'email': email,
      'firstName': firstName,
      'lastName': lastName,
      'pass': pass,
      'role': role,
      'staff_id': staffId,
      'username': username,
      'phone': phone,
    };
  }

  // Method to create a copy of the Staff instance with updated fields (useful for updates)
  Staff copyWith({
    String? email,
    String? firstName,
    String? lastName,
    String? pass,
    String? role,
    String? staffId,
    String? username,
    String? phone,
  }) {
    return Staff(
      email: email ?? this.email,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      pass: pass ?? this.pass,
      role: role ?? this.role,
      staffId: staffId ?? this.staffId,
      username: username ?? this.username,
      phone: phone ?? this.phone,
    );
  }

  // Convert Staff instance to JSON
  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'firstName': firstName,
      'lastName': lastName,
      'pass': pass,
      'role': role,
      'staff_id': staffId,
      'username': username,
      'phone': phone,
    };
  }

  // Create a Staff instance from JSON
  factory Staff.fromJson(Map<String, dynamic> json) {
    return Staff(
      email: json['email'] ?? '',
      firstName: json['firstName'] ?? '',
      lastName: json['lastName'] ?? '',
      pass: json['pass'] ?? '',
      role: json['role'] ?? '',
      staffId: json['staff_id'] ?? '',
      username: json['username'] ?? '',
      phone: json['phone'] ?? '',
    );
  }
}
