class NoteEntry {
  Map<dynamic, dynamic> notes;
  String username;
  String? objectId;
  DateTime? created;
  DateTime? updated;
  NoteEntry({
    required this.notes,
    required this.username,
    this.objectId,
    this.created,
    this.updated,
  });

  Map<String, Object?> toJson() => {
        'username': username,
        'notes': notes,
        'created': created,
        'updated': updated,
        'objectId': objectId,
      };

  static NoteEntry fromJson(Map<dynamic, dynamic>? json) => NoteEntry(
        notes: json!['notes'] as Map<dynamic, dynamic>,
        username: json['username'] as String,
        objectId: json['objectId'] as String,
        created: json['created'] as DateTime,
        //updated: json['updated'] as DateTime,
      );
}
