class PigeonUserDetails {
  final String uid;
  final String email;
  final String name;

  PigeonUserDetails({required this.uid, required this.email, required this.name});

  // Factory constructor to create PigeonUserDetails from a map
  factory PigeonUserDetails.fromMap(Map<String, dynamic> data, String uid) {
    return PigeonUserDetails(
      uid: uid,
      email: data['email'] ?? '',
      name: data['name'] ?? '',
    );
  }

  // Convert PigeonUserDetails to a Map for Firestore
  Map<String, dynamic> toJson() {
    return {
      'uid': uid,
      'email': email,
      'name': name,
    };
  }

  // Override equality and hashCode
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is PigeonUserDetails &&
        other.uid == uid &&
        other.email == email &&
        other.name == name;
  }

  @override
  int get hashCode => uid.hashCode ^ email.hashCode ^ name.hashCode;

  // Override toString for better debugging
  @override
  String toString() {
    return 'PigeonUserDetails(uid: $uid, email: $email, name: $name)';
  }
}

PigeonUserDetails createPigeonUserDetails({
  required String uid,
  required String email,
  required String name,
}) {
  return PigeonUserDetails(uid: uid, email: email, name: name);
}
