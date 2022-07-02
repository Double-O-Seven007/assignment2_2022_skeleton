///function converts the Notes to a list and saves on Backendless
Map<dynamic, dynamic> convertNotesListToMap(List<Note> notes) {
  Map<dynamic, dynamic> map = {};
  for (var i = 0; i < notes.length; i++) {
    map.addAll(
      {
        i: notes[i].toJson(),
      },
    );
  }
  return map;
}

List<Note> convertMapToNoteList(Map<dynamic, dynamic> map) {
  List<Note> notes = [];
  for (var i = 0; i < map.length; i++) {
    notes.add(
      (Note.fromJson(
        map[i],
      )),
    );
  }
  return notes;
}

///Notes have a Title, Email(ID user), and message

class Note {
  final String title;
  final String email;
  final String message;

  Note({
    required this.title,
    required this.email,
    required this.message,
  });

  Map<String, Object?> toJson() => {
        'title': title,
        'email': email,
        'message': message,
      };
  static Note fromJson(Map<dynamic, dynamic>? json) => Note(
        title: json!['title'] as String,
        email: json['email'] as String,
        message: json['message'] as String,
      );

  //TODO add the comparison operator https://youtu.be/Q00EaLNN_CQ?t=294 this still to be dilberated on.
  @override
  bool operator ==(covariant Note note) {
    return (title.toLowerCase().compareTo(note.title.toLowerCase()) == 0);
  }

  @override
  int get hashCode => title.hashCode;
}
